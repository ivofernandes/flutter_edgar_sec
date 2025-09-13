mixin IncomeValues {
  /// The aggregate amount of revenues earned by the company during the reporting period.
  double revenues = 0;

  /// CostOfGoodsAndServicesSold": {
  /// "label": "Cost of Goods and Services Sold",
  /// CostOfRevenues": {
  /// "label" :" The aggregate cost of goods produced and sold and services rendered during the reporting period.
  double costOfRevenues = 0;

  /// The portion of profit or loss for the period, net of income taxes, which is attributable to the parent.
  double netIncome = 0;

  /// The net result for the period of deducting operating expenses from operating revenues.
  double operatingIncome = 0;

  /// Gross profit is the difference between the revenue and the cost of goods sold.
  double grossProfit = 0;

  /// R&D
  double researchAndDevelopmentExpenses = 0;

  /// SG&A
  double generalAndAdministrativeExpenses = 0;

  /// R&D + SG&A
  double get operatingExpenses => totalOperatingExpenses;

  double totalOperatingExpenses = 0;

  double foreignCurrencyExchange = 0;

  /// Interest on debt
  double interestExpenses = 0;

  /// Other income and expenses
  double otherNonOperatingIncomeExpense = 0;

  /// Total of all non operating income and expenses
  /// Some reports may have this field reported as other non operating income expense
  /// But should confirm if this is also including the interest expenses
  double totalNonOperatingIncomeExpense = 0;

  /// Income tax expense
  double incomeTaxExpense = 0;

  // Calculated margins
  double get netMargin => netIncome / revenues;

  double get operatingMargin => operatingIncome / revenues;

  // ignore: non_constant_identifier_names
  double get EBIT => operatingIncome;

  ///Interest Cover Ratio
  ///Interest Coverage Ratio = EBIT / Interest Expense
  double get interestCoverageRatio => EBIT / interestExpenses;

  /// Sum of operating and cost of revenues
  double costsAndExpenses = 0;

  /// Charges on restructuring
  double restructuring = 0;

  /// Amount of money spent because of acquisitions and efforts to combine the businesses
  double acquisitionCosts = 0;

  /// Amortization of intangibles assets like goodwill and other intangible assets
  double amortizationOfIntangibles = 0;

  /// Earnings per share
  double eps = 0;
  double epsDiluted = 0;

  /// Shares outstanding
  double shares = 0;
  double sharesDiluted = 0;

  /// Other operating expenses that are not R&D neither SG&A
  double get otherOperatingExpenses =>
      totalOperatingExpenses -
      researchAndDevelopmentExpenses -
      generalAndAdministrativeExpenses;

  @override
  String toString() => '''
  revenues: $revenues
  costOfRevenues: $costOfRevenues
  netIncome: $netIncome
  operatingIncome: $operatingIncome
  grossProfit: $grossProfit
  researchAndDevelopmentExpense: $researchAndDevelopmentExpenses
  sellingGeneralAndAdministrativeExpense: $generalAndAdministrativeExpenses
  operatingExpenses: $operatingExpenses
  interestExpenses: $interestExpenses
  otherNonOperatingIncomeExpense: $otherNonOperatingIncomeExpense
  incomeTaxExpense: $incomeTaxExpense
  netMargin: $netMargin
  operatingMargin: $operatingMargin
  interestCoverageRatio: $interestCoverageRatio
  acquisitionCosts: $acquisitionCosts
  restructuring: $restructuring
  amortizationOfIntangibles: $amortizationOfIntangibles
  eps: $eps
  epsDiluted: $epsDiluted
  shares: $shares
  sharesDiluted: $sharesDiluted
  ''';
}
