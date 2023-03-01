class IncomeStatement {

  double revenues;
  double netIncome;

  IncomeStatement({
    this.revenues = 0,
    this.netIncome = 0,
  });

  @override
  String toString() => '''
  revenues: $revenues
  netIncome: $netIncome
  ''';

}