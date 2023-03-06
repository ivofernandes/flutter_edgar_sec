import 'package:flutter_edgar_sec/src/model/financials/cash_flow_statement.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/processor/utils/base_processor.dart';

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
    'PaymentsForRepurchaseOfCommonStock',
  };

  static const Set<String> supportedFields = {
    ...dividendsFields,
    ...buyBackFields,
    'SecuritiesSoldUnderAgreementsToRepurchaseFairValueOfCollateral',
  };

  static void process(Map<String, dynamic> facts, Map<String, FinancialStatement> index) {
    for (final field in supportedFields) {
      // Filter the quarters, i.e. rows that are 10-Q
      final quarters = BaseProcessor.getQuarterRows(facts, field, index);

      for (final quarter in quarters) {
        final endDateString = quarter['end'];
        final value = quarter['val'] as num;
        final financialStatement = index[endDateString]!;
        final incomeStatement = financialStatement.cashFlowStatement;

        _mapValue(field, value.toDouble(), incomeStatement);
      }
    }
  }

  static void _mapValue(String field, double value, CashFlowStatement cashFlowStatement) {
    if (dividendsFields.contains(field)) {
      cashFlowStatement.dividends += value;
      return;
    }

    if (buyBackFields.contains(field)) {
      cashFlowStatement.buyback += value;
      return;
    }

    switch (field) {
      case 'SecuritiesSoldUnderAgreementsToRepurchaseFairValueOfCollateral':
        break;
    }
  }
}
