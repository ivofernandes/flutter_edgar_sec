import 'package:flutter_edgar_sec/src/model/financials/balance_sheet.dart';

mixin BalanceExtrapolate {
  static void fillMissingQuarter(
    BalanceSheet balanceSheet,
    BalanceSheet fullYear,
    BalanceSheet qa,
    BalanceSheet qb,
    BalanceSheet qc,
  ) {
    balanceSheet.cashAndCashEquivalents = fullYear.cashAndCashEquivalents -
        qc.cashAndCashEquivalents -
        qb.cashAndCashEquivalents -
        qa.cashAndCashEquivalents;
    balanceSheet.shortTermInvestments =
        fullYear.shortTermInvestments - qc.shortTermInvestments - qb.shortTermInvestments - qa.shortTermInvestments;

    balanceSheet.accountsReceivable =
        fullYear.accountsReceivable - qc.accountsReceivable - qb.accountsReceivable - qa.accountsReceivable;

    balanceSheet.otherReceivables =
        fullYear.otherReceivables - qc.otherReceivables - qb.otherReceivables - qa.otherReceivables;

    balanceSheet.inventory = fullYear.inventory - qc.inventory - qb.inventory - qa.inventory;

    balanceSheet.deferredTaxAssets =
        fullYear.deferredTaxAssets - qc.deferredTaxAssets - qb.deferredTaxAssets - qa.deferredTaxAssets;

    balanceSheet.otherCurrentAssets =
        fullYear.otherCurrentAssets - qc.otherCurrentAssets - qb.otherCurrentAssets - qa.otherCurrentAssets;

    balanceSheet.goodwill = fullYear.goodwill - qc.goodwill - qb.goodwill - qa.goodwill;

    balanceSheet.totalLiabilities =
        fullYear.totalLiabilities - qc.totalLiabilities - qb.totalLiabilities - qa.totalLiabilities;

    balanceSheet.currentLiabilities =
        fullYear.currentLiabilities - qc.currentLiabilities - qb.currentLiabilities - qa.currentLiabilities;

    balanceSheet.equity = fullYear.equity - qc.equity - qb.equity - qa.equity;
  }
}
