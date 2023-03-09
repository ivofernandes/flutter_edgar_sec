class BalanceSheet {

  double cashAndCashEquivalents = 0;
  double shortTermInvestments = 0;

  double currentAssets = 0;

  BalanceSheet();

  @override
  String toString() => '''
  cashAndCashEquivalents: $cashAndCashEquivalents,
  shortTermInvestments: $shortTermInvestments,
  currentAssets: $currentAssets
  ''';
}
