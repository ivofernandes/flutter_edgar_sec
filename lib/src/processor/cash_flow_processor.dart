import 'package:flutter_edgar_sec/src/model/enums/financial_statment_period.dart';
import 'package:flutter_edgar_sec/src/model/financials/cash_flow_statement.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/processor/utils/base_processor.dart';
import 'package:flutter_edgar_sec/src/utils/number_utils.dart';

/// Cash flow processor
/// https://seekingalpha.com/symbol/AAPL/cash-flow-statement
class CashFlowProcessor {
  static const Set<String> dividendsFields = {
    'PaymentsOfDividendsCommonStock',
    'PaymentsOfDividends',
    'Dividends',
  };

  static const Set<String> buyBackFields = {
    //'StockRepurchasedAndRetiredDuringPeriodValue',
    'PaymentsForRepurchaseOfCommonStock'
  };

  static const Set<String> supportedFields = {
    ...dividendsFields,
    ...buyBackFields,
    'SecuritiesSoldUnderAgreementsToRepurchaseFairValueOfCollateral',
    'ShareBasedCompensation',
    'AccumulatedDepreciationDepletionAndAmortizationPropertyPlantAndEquipment',
    'PaymentsToAcquirePropertyPlantAndEquipment',
    'DepreciationDepletionAndAmortization',
    'NetCashProvidedByUsedInOperatingActivities',
    'NetCashProvidedByUsedInInvestingActivities',
    'NetCashProvidedByUsedInFinancingActivities',
    'DeferredIncomeTaxesAndTaxCredits',
    'PaymentsToAcquireMarketableSecurities',
    'ProceedsFromSaleAndMaturityOfMarketableSecurities',
  };

  static void process(
    Map<String, dynamic> facts,
    Map<String, FinancialStatement> index,
    FinancialStatementPeriod typeOfForm,
  ) {
    // Auxiliar code to find the fields that are not mapped
    final List<String> factsKeys = facts.keys.toList();
    for (final field in factsKeys) {
      final periods =
          BaseProcessor.getRows(facts, field, index, typeOfForm: typeOfForm);

      for (final period in periods) {
        final String endDateString = period['end'] as String;
        final double value = (period['val'] as num).toDouble();
        final valueBillions = value.billions;

        if (BaseProcessor.calculateIsAnnualReport(period)) {
          final DateTime endDate = DateTime.parse(endDateString);
          final bool matchField = field.toLowerCase().contains('repurchase') ||
              field.toLowerCase().contains('stock');
          final bool matchDate = endDate.year == 2021;
          final bool match = matchField && matchDate;
          if (match) {
            //AppLogger().debug('Found $field @ $endDateString = $valueBillions');

            final financialStatement = index[endDateString]!;
            final cashFlowStatement = financialStatement.cashFlowStatement;

            _mapValue(field, value, cashFlowStatement);
          }
        }
      }
    } // end for factsKeys

    /// Process the supported fields
    for (final field in supportedFields) {
      // Filter the quarters, i.e. rows that are 10-Q
      final quarters = BaseProcessor.getRows(
        facts,
        field,
        index,
        typeOfForm: typeOfForm,
      );

      for (final quarter in quarters) {
        final endDateString = quarter['end'];
        final value = quarter['val'] as num;
        final financialStatement = index[endDateString]!;
        final incomeStatement = financialStatement.cashFlowStatement;

        _mapValue(field, value.toDouble(), incomeStatement);
      }
    }
  }

  static void _mapValue(
      String field, double value, CashFlowStatement cashFlowStatement) {
    if (dividendsFields.contains(field)) {
      cashFlowStatement.dividends += value;
      return;
    }

    if (buyBackFields.contains(field)) {
      cashFlowStatement.buyback = value;
      return;
    }

    switch (field) {
      case 'SecuritiesSoldUnderAgreementsToRepurchaseFairValueOfCollateral':
        break;
      case 'ShareBasedCompensation':
        cashFlowStatement.shareBasedCompensation = value;
        break;
      case 'AccumulatedDepreciationDepletionAndAmortizationPropertyPlantAndEquipment':
        cashFlowStatement.accumulatedDepreciation = value;
        break;
      case 'PaymentsToAcquirePropertyPlantAndEquipment':
        cashFlowStatement.capitalExpenditures = value;
        break;
      case 'DepreciationDepletionAndAmortization':
        cashFlowStatement.depreciationAndAmortization = value;
        break;
      case 'NetCashProvidedByUsedInOperatingActivities':
        cashFlowStatement.cashFromOperations = value;
        break;
      case 'NetCashProvidedByUsedInInvestingActivities':
        cashFlowStatement.cashFromInvesting = value;
        break;
      case 'NetCashProvidedByUsedInFinancingActivities':
        cashFlowStatement.cashFromFinancing = value;
        break;
      case 'DeferredIncomeTaxesAndTaxCredits':
        cashFlowStatement.deferredIncomeTax = value;
        break;
      case 'ProceedsFromSaleAndMaturityOfMarketableSecurities':
        cashFlowStatement.sellMarketableSecurities = value;
        break;
      case 'PaymentsToAcquireMarketableSecurities':
        cashFlowStatement.buyMarketableSecurities = value;
        break;
    }
  }
}
