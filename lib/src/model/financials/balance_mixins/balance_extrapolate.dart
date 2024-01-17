import 'package:flutter_edgar_sec/src/model/financials/balance_sheet.dart';

mixin BalanceExtrapolate {
  static void fillMissingQuarter(
    BalanceSheet balanceSheet,
    BalanceSheet fullYear,
    BalanceSheet qa,
    BalanceSheet qb,
    BalanceSheet qc,
  ) {
    balanceSheet.cashAndCashEquivalents = fullYear.cashAndCashEquivalents;
    balanceSheet.shortTermInvestments = fullYear.shortTermInvestments;
    balanceSheet.accountsReceivable = fullYear.accountsReceivable;
    balanceSheet.otherReceivables = fullYear.otherReceivables;
    balanceSheet.inventory = fullYear.inventory;
    balanceSheet.deferredTaxAssets = fullYear.deferredTaxAssets;
    balanceSheet.otherCurrentAssets = fullYear.otherCurrentAssets;
    balanceSheet.goodwill = fullYear.goodwill;
    balanceSheet.totalLiabilities = fullYear.totalLiabilities;
    balanceSheet.currentLiabilities = fullYear.currentLiabilities;
    balanceSheet.equity = fullYear.equity;
  }
}
