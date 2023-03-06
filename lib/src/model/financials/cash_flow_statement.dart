class CashFlowStatement {
  double buyback = 0;
  double dividends = 0;

  CashFlowStatement();

  @override
  String toString() => '''
  buyBacks: $buyback
  dividends: $dividends
  ''';
}
