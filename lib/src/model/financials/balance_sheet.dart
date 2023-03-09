class BalanceSheet {

  // Cash & Short Term Investments division
  double cashAndCashEquivalents = 0;
  double shortTermInvestments = 0;
  double tradingAssetSecurities = 0;

  // Receivables division
  double accountsReceivable = 0;
  double otherReceivables = 0;

  double currentAssets = 0;

  // Calculated margins
  double get totalCashAndShortTermInvestments => cashAndCashEquivalents
      + shortTermInvestments + tradingAssetSecurities;

  BalanceSheet();

  @override
  String toString() => '''
  cashAndCashEquivalents: $cashAndCashEquivalents,
  shortTermInvestments: $shortTermInvestments,
  accountsReceivable: $accountsReceivable,
  otherReceivables: $otherReceivables,
  currentAssets: $currentAssets
  ''';
}
