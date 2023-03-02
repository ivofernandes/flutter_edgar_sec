class IncomeStatement {
  IncomeStatement();

  double revenues = 0;
  double netIncome = 0;

  double get netMargin => revenues / netIncome;

  @override
  String toString() => '''
  revenues: $revenues
  netIncome: $netIncome
  ''';
}
