import 'package:flutter_edgar_sec/src/model/financials/balance_sheet.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/processor/utils/base_processor.dart';

/// Processes the balance sheet from the json response
/// https://seekingalpha.com/symbol/AAPL/balance-sheet
class BalanceSheetProcessor {

  // Cash % Short term Investments
  static const Set<String> cashAndShortTermInvestments = {
    'CashAndCashEquivalentsAtCarryingValue', // Cash And Equivalents
    '',
  };

  static const Set<String> supportedFields = {
    ...cashAndShortTermInvestments,
    'AssetsCurrent'
  };

  static void process(
    Map<String, dynamic> facts,
    Map<String, FinancialStatement> index,
    String typeOfForm,
  ) {
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
        final balanceSheet = financialStatement.balanceSheet;

        _mapValue(field, value.toDouble(), balanceSheet);
      }
    }
  }

  static void _mapValue(String field, double value, BalanceSheet balanceSheet) {

    // print('field: '+field);

    if (cashAndShortTermInvestments.contains(field)) {
      balanceSheet.cashAndCashEquivalents = value;
      return;
    }

    switch (field) {
      // case 'CashAndCashEquivalentsAtCarryingValue':
      //   balanceSheet.cashAndCashEquivalents = value;
      //   break;
      case 'AssetsCurrent':
        balanceSheet.currentAssets = value;
        break;
    }
  }
}
