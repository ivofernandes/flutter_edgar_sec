class IncomeStatement {
  IncomeStatement();

  double revenues = 0;
  // CostOfGoodsAndServicesSold": {
  // "label": "Cost of Goods and Services Sold",
  double costOfGoodsAndServicesSold = 0;
  double netIncome = 0;
  double operatingIncome = 0;

  double get netMargin => netIncome / revenues;

  double get operatingMargin => operatingIncome / revenues;

  @override
  String toString() => '''
  revenues: $revenues
  costOfRevenues: $costOfGoodsAndServicesSold
  netIncome: $netIncome
  operatingIncome: $operatingIncome
  ''';
}
