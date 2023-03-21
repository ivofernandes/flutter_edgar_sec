import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/processor/utils/base_processor.dart';
import 'package:flutter_edgar_sec/src/processor/utils/debug_fields.dart';

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
  };

  static const Set<String> supportedFields = {
    ...revenueFields,
    ...costOfRevenueFields,
    'NetIncomeLoss',
    'OperatingIncomeLoss',
    'ResearchAndDevelopmentExpense',
    'GrossProfit',
    'SellingGeneralAndAdministrativeExpense',
    'OperatingExpenses',
    'InterestExpense',
    'OtherNonoperatingIncomeExpense',
    'IncomeTaxesPaidNet',
    'IncomeTaxExpenseBenefit',
  };

  /// Process the income statement
  /// @param facts: the facts from the SEC json response
  /// @param index: the index to find the financial statements
  /// @typeOfForm: 10-Q or 10-K
  static void process(
    Map<String, dynamic> facts,
    Map<String, FinancialStatement> index,
    String typeOfForm,
  ) {
    DebugFields.debugFields(facts, index, typeOfForm, supportedFields);
    // Auxiliar code to find the fields that are not mapped
    List<String> factsKeys = facts.keys.toList();
    for (final field in factsKeys) {
      final periods =
          BaseProcessor.getRows(facts, field, index, typeOfForm: typeOfForm);

      for (final period in periods) {
        final endDateString = period['end'];
        final double value = (period['val'] as num).toDouble();
        final valueBillions = value.billions;

        if (typeOfForm == '10-K') {
          if (valueBillions == 146.698 ||
              valueBillions == 36.422 ||
              valueBillions == 67.984 ||
              valueBillions == -1.497 ||
              valueBillions == 14.701) {
            print('Found');

            final financialStatement = index[endDateString]!;
            final incomeStatement = financialStatement.incomeStatement;

            _mapValue(field, value.toDouble(), incomeStatement);
          }
        }
      }
    } // end for factsKeys

    /// Process the supported fields
    for (final field in supportedFields) {
      // Filter the quarters or the annuals, i.e. rows that are 10-Q or 10-K
      final periods =
          BaseProcessor.getRows(facts, field, index, typeOfForm: typeOfForm);

      // Map the values for each report
      for (final period in periods) {
        final endDateString = period['end'];
        final value = period['val'] as num;
        final financialStatement = index[endDateString]!;
        final incomeStatement = financialStatement.incomeStatement;

        _mapValue(field, value.toDouble(), incomeStatement);
      }
    }
  }

  static void _mapValue(
      String field, double value, IncomeStatement incomeStatement) {
    if (revenueFields.contains(field)) {
      incomeStatement.revenues = value;
      return;
    }

    if (costOfRevenueFields.contains(field)) {
      incomeStatement.costOfRevenues = value;
      return;
    }

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
      case 'SellingGeneralAndAdministrativeExpense':
        incomeStatement.sellingGeneralAndAdministrativeExpenses = value;
        break;
      case 'OperatingExpenses':
        incomeStatement.operatingExpenses = value;
        break;
      case 'InterestExpense':
        incomeStatement.interestExpenses = value;
        break;
      case 'OtherNonoperatingIncomeExpense':
        incomeStatement.otherNonOperatingIncomeExpense = value;
        break;
      case 'IncomeTaxExpenseBenefit':
        incomeStatement.incomeTaxExpense = value;
        break;
    }
  }
}
