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
  static const List<String> revenueFields = [
    'RevenueFromContractWithCustomerExcludingAssessedTax',
    'SalesRevenueGoodsNet',
    'SalesRevenueNet',
    'TotalRevenuesAndOtherIncome',
    'RevenueFromContractWithCustomerIncludingAssessedTax'
  ];

  static const List<String> supportedFields = [
    ...revenueFields,
    'CostOfGoodsAndServicesSold',
    'NetIncomeLoss',
    'OperatingIncomeLoss',
  ];

  static void process(Map<String, dynamic> facts, Map<String, FinancialStatement> index) {
    for (final field in supportedFields) {
      // Filter the quarters, i.e. rows that are 10-Q
      final quarters = BaseProcessor.getQuarterRows(facts, field, index);

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

    switch (field) {
      case 'CostOfGoodsAndServicesSold':
        incomeStatement.costOfGoodsAndServicesSold = value;
        break;
      case 'NetIncomeLoss':
        incomeStatement.netIncome = value;
        break;
      case 'OperatingIncomeLoss':
        incomeStatement.operatingIncome = value;
        break;
    }
  }
}
