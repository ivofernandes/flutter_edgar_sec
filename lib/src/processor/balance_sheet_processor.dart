import 'package:flutter_edgar_sec/src/model/financials/balance_sheet.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/processor/utils/base_processor.dart';

/// Processes the balance sheet from the json response
/// https://seekingalpha.com/symbol/AAPL/balance-sheet
class BalanceSheetProcessor {
  static final List<String> supportedFields = ['AssetsCurrent'];

  static void process(
    Map<String, dynamic> facts,
    Map<String, FinancialStatement> index,
  ) {
    for (final field in supportedFields) {
      // Filter the quarters, i.e. rows that are 10-Q
      final quarters = BaseProcessor.getQuarterRows(facts, field, index);

      for (final quarter in quarters) {
        final endDateString = quarter['end'];
        final value = quarter['val'] as num;
        final financialStatement = index[endDateString]!;
        final balanceSheet = financialStatement.balanceSheet;

        _mapValue(field, value.toDouble(), balanceSheet);
      }
    }
  }

  static void _mapValue(String field, double value, BalanceSheet balanceSheet) {
    switch (field) {
      case 'AssetsCurrent':
        balanceSheet.currentAssets = value;
        break;
    }
  }
}
