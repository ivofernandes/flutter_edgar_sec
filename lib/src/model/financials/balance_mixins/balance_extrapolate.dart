import 'package:flutter_edgar_sec/src/model/financials/balance_sheet.dart';

mixin BalanceExtrapolate {
  static void fillMissingQuarter(
    BalanceSheet incomeStatement,
    BalanceSheet fullYear,
    BalanceSheet qa,
    BalanceSheet qb,
    BalanceSheet qc,
  ) {
    incomeStatement.cashAndCashEquivalents = fullYear.cashAndCashEquivalents -
        qc.cashAndCashEquivalents -
        qb.cashAndCashEquivalents -
        qa.cashAndCashEquivalents;
    incomeStatement.shortTermInvestments =
        fullYear.shortTermInvestments - qc.shortTermInvestments - qb.shortTermInvestments - qa.shortTermInvestments;

    incomeStatement.accountsReceivable =
        fullYear.accountsReceivable - qc.accountsReceivable - qb.accountsReceivable - qa.accountsReceivable;

    incomeStatement.otherReceivables =
        fullYear.otherReceivables - qc.otherReceivables - qb.otherReceivables - qa.otherReceivables;

    incomeStatement.inventory = fullYear.inventory - qc.inventory - qb.inventory - qa.inventory;

    incomeStatement.deferredTaxAssets =
        fullYear.deferredTaxAssets - qc.deferredTaxAssets - qb.deferredTaxAssets - qa.deferredTaxAssets;

    incomeStatement.otherCurrentAssets =
        fullYear.otherCurrentAssets - qc.otherCurrentAssets - qb.otherCurrentAssets - qa.otherCurrentAssets;

    incomeStatement.goodwill = fullYear.goodwill - qc.goodwill - qb.goodwill - qa.goodwill;

    incomeStatement.equity = fullYear.equity - qc.equity - qb.equity - qa.equity;
  }
}
