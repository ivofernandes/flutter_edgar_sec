class BalanceSheet {

  // Cash & Short Term Investments division
  double cashAndCashEquivalents = 0;
  double shortTermInvestments = 0;
  double tradingAssetSecurities = 0;

  // Receivables division
  double accountsReceivable = 0;
  double otherReceivables = 0;

  // Current Assets
  double inventory = 0;
  double deferredTaxAssets = 0;
  double restrictedCash = 0;

  double currentAssets = 0;

  // Calculated total cash n cash equivalents
  double get totalCashAndShortTermInvestments => cashAndCashEquivalents
      + shortTermInvestments + tradingAssetSecurities;

  BalanceSheet();

  @override
  String toString() => '''
  cashAndCashEquivalents: $cashAndCashEquivalents,
  shortTermInvestments: $shortTermInvestments,
  Total Cash Eqs: $totalCashAndShortTermInvestments,
  accountsReceivable: $accountsReceivable,
  otherReceivables: $otherReceivables,
  inventory: $inventory,
  deferredTaxAssets: $deferredTaxAssets,
  restrictedCash: $restrictedCash,
  currentAssets: $currentAssets
  ''';
}
