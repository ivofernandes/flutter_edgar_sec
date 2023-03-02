class IncomeStatement {
  IncomeStatement();

  double revenues = 0;
  double netIncome = 0;
  double operatingIncome = 0;

  double get netMargin => netIncome / revenues;

  double get operatingMargin => operatingIncome / revenues;

  @override
  String toString() => '''
  revenues: $revenues
  netIncome: $netIncome
  operatingIncome: $operatingIncome
  ''';
}
