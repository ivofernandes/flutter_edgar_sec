import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_edgar_sec/src/processor/utils/base_processor.dart';
import 'package:flutter_edgar_sec/src/processor/utils/debug_fields.dart';
import 'package:flutter_edgar_sec/src/utils/app_logger.dart';

/// Processes the income statement from the json response
/// https://seekingalpha.com/symbol/AAPL/income-statement
///
/// To add a new field we need to add it to the supportedFields list and add a new case to the _mapValue method
///

class IncomeStatementProcessor {
  /// Revenue: https://xbrl.us/forums/topic/how-to-find-a-complete-list-of-similar-concept/
  static const Set<String> revenueFields = {
    'RevenueFromContractWithCustomerExcludingAssessedTax',
    'SalesRevenueGoodsNet',
    'SalesRevenueNet',
    'TotalRevenuesAndOtherIncome',
    'RevenueFromContractWithCustomerIncludingAssessedTax'
  };

  // Cost of revenue fields
  static const Set<String> costOfRevenueFields = {
    'CostOfGoodsAndServicesSold',
    'CostOfRevenue',
    //'CostOfServices',
    //'CostOfServicesMaintenanceCosts',
  };

  static const Set<String> generalAndAdministrativeFields = {
    'SellingGeneralAndAdministrativeExpense',
    'SellingAndMarketingExpense',
    'GeneralAndAdministrativeExpense',
    'FulfillmentExpense',
    'MarketingExpense',
  };

  static const Set<String> supportedFields = {
    ...revenueFields,
    ...costOfRevenueFields,
    ...generalAndAdministrativeFields,
    'NetIncomeLoss',
    'OperatingIncomeLoss',
    'ResearchAndDevelopmentExpense',
    'GrossProfit',
    'OperatingExpenses',
    'InterestExpense',
    'NonoperatingIncomeExpense',
    'OtherNonoperatingIncomeExpense',
    'IncomeTaxesPaidNet',
    'IncomeTaxExpenseBenefit',
    'CostsAndExpenses',
    'RestructuringCharges',
    'BusinessCombinationAcquisitionRelatedCosts',
    'AmortizationOfIntangibleAssets',
    'ForeignCurrencyTransactionGainLossBeforeTax',
    'EarningsPerShareBasic',
    'EarningsPerShareDiluted',
    'WeightedAverageNumberOfSharesOutstandingBasic',
    'WeightedAverageNumberOfDilutedSharesOutstanding',
  };

  /// The fields that have been processed
  static Set<String> processed = {};

  /// Process the income statement
  /// @param facts: the facts from the SEC json response
  /// @param index: the index to find the financial statements
  /// @typeOfForm: 10-Q or 10-K
  static void process(
    Map<String, dynamic> facts,
    Map<String, FinancialStatement> index,
    String typeOfForm,
  ) {
    // Reset the processed fields
    processed = {};

    DebugFields.debugFields(facts, index, typeOfForm, supportedFields);
    // Auxiliar code to find the fields that are not mapped
    final List<String> factsKeys = facts.keys.toList();
    for (final field in factsKeys) {
      final periods = BaseProcessor.getRows(facts, field, index, typeOfForm: typeOfForm);

      for (final period in periods) {
        final endDateString = period['end'] as String;
        final double value = (period['val'] as num).toDouble();
        final valueBillions = value.billions;

        if (typeOfForm == '10-K') {
          if (field == 75.111) {
            AppLogger().debug('Found $field @ $endDateString = $valueBillions');
          }

          final DateTime endDate = DateTime.parse(endDateString);
          final bool matchField = field.toLowerCase().contains('costof');
          final bool matchDate = endDate.year == 2022;
          final bool match = matchField && matchDate;
          if (match) {
            AppLogger().debug('Found $field @ $endDateString = $valueBillions');

            final financialStatement = index[endDateString]!;
            final incomeStatement = financialStatement.incomeStatement;

            //_mapValue(field, value, incomeStatement, endDateString);
          }
        }
      }
    } // end for factsKeys

    /// Process the supported fields
    for (final field in supportedFields) {
      // Filter the quarters or the annuals, i.e. rows that are 10-Q or 10-K
      final periods = BaseProcessor.getRows(facts, field, index, typeOfForm: typeOfForm);

      if (field == 'WeightedAverageNumberOfSharesOutstandingBasic') {
        AppLogger().debug('Found $field');
      }
      // Map the values for each report
      for (final period in periods) {
        final endDateString = period['end'];
        final value = period['val'] as num;
        final financialStatement = index[endDateString]!;
        final incomeStatement = financialStatement.incomeStatement;

        _mapValue(field, value.toDouble(), incomeStatement, period);
      }
    }
  }

  /// Map the value to the correct field
  static void _mapValue(String field, double value, IncomeStatement incomeStatement, Map<String, dynamic> period) {
    // If there is no value, return. It's not be processed anyway
    if (value == 0) {
      return;
    }

    // Check if the field has been processed
    final String key = '${field}_${period['fy']}_${period['fp']}';

    if (key.contains('2021_FY') && field == 'DeferredTaxAssetsInProcessResearchAndDevelopment') {
      AppLogger().debug('Field $key = $value');
    }

    bool alreadyProcessed = false;
    if (processed.contains(key)) {
      //AppLogger().debug'Field $key already processed, will ignore $value');
      alreadyProcessed = true;
    }

    processed.add(key);

    // Process the field
    if (revenueFields.contains(field)) {
      final endDateString = period['end'] as String;
      if (endDateString == '2021-12-31') {
        AppLogger().debug('Found REV $field @ $endDateString = ${value.billions}');
      }
      incomeStatement.revenues = value;
    } else if (costOfRevenueFields.contains(field)) {
      incomeStatement.costOfRevenues = value;
    } else if (generalAndAdministrativeFields.contains(field) && !alreadyProcessed) {
      final endDateString = period['end'] as String;
      if (endDateString == '2021-12-31') {
        AppLogger().debug('Found GAS $field @ $endDateString = ${value.billions}');
      }
      incomeStatement.generalAndAdministrativeExpenses += value;
    } else {
      switch (field) {
        case 'NetIncomeLoss':
          incomeStatement.netIncome = value;
          break;
        case 'OperatingIncomeLoss':
          incomeStatement.operatingIncome = value;
          break;
        case 'ResearchAndDevelopmentExpense':
          incomeStatement.researchAndDevelopmentExpenses = value;
          break;
        case 'GrossProfit':
          incomeStatement.grossProfit = value;
          break;
        case 'OperatingExpenses':
          incomeStatement.totalOperatingExpenses = value;
          break;
        case 'ForeignCurrencyTransactionGainLossBeforeTax':
          incomeStatement.foreignCurrencyExchange = value;
          break;
        case 'InterestExpense':
          incomeStatement.interestExpenses = value;
          break;
        case 'OtherNonoperatingIncomeExpense':
          incomeStatement.totalNonOperatingIncomeExpense = value;
          break;
        case 'NonoperatingIncomeExpense':
          incomeStatement.otherNonOperatingIncomeExpense = value;
          break;
        case 'IncomeTaxExpenseBenefit':
          incomeStatement.incomeTaxExpense = value;
          break;
        case 'CostsAndExpenses':
          incomeStatement.costsAndExpenses = value;
          break;
        case 'RestructuringCharges':
          incomeStatement.restructuring = value;
          break;
        case 'BusinessCombinationAcquisitionRelatedCosts':
          incomeStatement.acquisitionCosts = value;
          break;
        case 'AmortizationOfIntangibleAssets':
          incomeStatement.amortizationOfIntangibles = value;
          break;
        case 'EarningsPerShareBasic':
          incomeStatement.eps = value;
          break;
        case 'EarningsPerShareDiluted':
          incomeStatement.epsDiluted = value;
          break;
        case 'WeightedAverageNumberOfSharesOutstandingBasic':
          incomeStatement.shares = value;
          break;
        case 'WeightedAverageNumberOfDilutedSharesOutstanding':
          incomeStatement.sharesDiluted = value;
          break;
      }
    }
  }
}
