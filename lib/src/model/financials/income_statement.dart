class IncomeStatement {
  IncomeStatement();

  double revenues = 0;

  // CostOfGoodsAndServicesSold": {
  // "label": "Cost of Goods and Services Sold",
  // CostOfRevenues": {
  // "label" :" The aggregate cost of goods produced and sold and services rendered during the reporting period.
  double costOfRevenues = 0;

  // The portion of profit or loss for the period, net of income taxes, which is attributable to the parent.
  double netIncome = 0;

  // The net result for the period of deducting operating expenses from operating revenues.
  double operatingIncome = 0;

  // Gross profit is the difference between the revenue and the cost of goods sold.
  double grossProfit = 0;

  // R&D
  double researchAndDevelopmentExpenses = 0;

  // SG&A
  double sellingGeneralAndAdministrativeExpenses = 0;

  // R&D + SG&A
  double operatingExpenses = 0;

  // Calculated margins
  double get netMargin => netIncome / revenues;

  double get operatingMargin => operatingIncome / revenues;

  @override
  String toString() => '''
  revenues: $revenues
  costOfRevenues: $costOfRevenues
  netIncome: $netIncome
  operatingIncome: $operatingIncome
  grossProfit: $grossProfit
  researchAndDevelopmentExpense: $researchAndDevelopmentExpenses
  sellingGeneralAndAdministrativeExpense: $sellingGeneralAndAdministrativeExpenses
  operatingExpenses: $operatingExpenses
  netMargin: $netMargin
  operatingMargin: $operatingMargin
  ''';
}
