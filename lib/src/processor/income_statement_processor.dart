import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/processor/utils/base_processor.dart';

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

  static void process(
    Map<String, dynamic> facts,
    Map<String, FinancialStatement> index,
    String typeOfForm,
  ) {
    for (final field in supportedFields) {
      // Filter the quarters, i.e. rows that are 10-Q
      final quarters = BaseProcessor.getRows(facts, field, index, typeOfForm: typeOfForm);

      //TODO - NF - should we change "quarter" for "period"? because period can
      //TODO - represent a quarter or annual
      for (final quarter in quarters) {
        final endDateString = quarter['end'];
        final value = quarter['val'] as num;
        final financialStatement = index[endDateString]!;
        final incomeStatement = financialStatement.incomeStatement;

        _mapValue(field, value.toDouble(), incomeStatement);
      }
    }
  }

  static void _mapValue(String field, double value, IncomeStatement incomeStatement) {
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
      case 'incomeTaxExpenseBenefit':
        incomeStatement.incomeTaxExpense += value;
        break;
    }
  }
}
