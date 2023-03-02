class CashFlowStatement {
  double buyBacks = 0;
  double dividends = 0;

  CashFlowStatement();

  @override
  String toString() => '''
  buyBacks: $buyBacks
  dividends: $dividends
  ''';
}
