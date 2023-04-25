import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';

class IncomeStatement {
  static List<String> labels = [
    'Revenues',
    'Cost of Revenues',
    'Operating Income',
    'Gross Profit',
    'Research and Development Expenses',
    'Selling General and Admin Expenses',
    'Other Operating Expenses',
    'Operating Expenses',
    'Operating Income',
    'Currency Exchange',
    'Interest Expenses',
    'Other Non Operating Income Expenses',
    'Income tax Expense',
    'Net Income',
    'Operating Margin',
    'Net Margin',
    'EBIT',
    'Interest Coverage Ratio',
  ];

  /// This is just an abstraction for the frontend, and needs to match the labels array
  String getValueForIndex(int index) {
    final double value = getDoubleValueForIndex(index);
    final Set<String> percentLabels = {
      'Operating Margin',
      'Net Margin',
      'Interest Coverage Ratio',
    };

    if (percentLabels.contains(labels[index])) {
      return value.percentFormat;
    } else {
      return value.reportFormat;
    }
  }

  double getDoubleValueForIndex(int index) {
    final String name = labels[index];
    switch (name) {
      case 'Revenues':
        return revenues;
      case 'Cost of Revenues':
        return costOfRevenues;
      case 'Operating Income':
        return operatingIncome;
      case 'Gross Profit':
        return grossProfit;
      case 'Research and Development Expenses':
        return researchAndDevelopmentExpenses;
      case 'Selling General and Admin Expenses':
        return generalAndAdministrativeExpenses;
      case 'Other Operating Expenses':
        return otherOperatingExpenses;
      case 'Operating Expenses':
        return operatingExpenses;
      case 'Net Income':
        return netIncome;
      case 'Interest Expenses':
        return interestExpenses;
      case 'Other Non Operating Income Expenses':
        return otherNonOperatingIncomeExpense;
      case 'Income tax Expense':
        return incomeTaxExpense;
      case 'Net Margin':
        return netMargin;
      case 'Operating Margin':
        return operatingMargin;
      case 'EBIT':
        return EBIT;
      case 'Interest Coverage Ratio':
        return interestCoverageRatio;
      case 'Currency Exchange':
        return foreignCurrencyExchange;
      default:
        return 0;
    }
  }

  IncomeStatement();

  factory IncomeStatement.extrapolate(
    IncomeStatement fullYear,
    IncomeStatement q1,
    IncomeStatement q2,
    IncomeStatement q3,
  ) {
    final IncomeStatement incomeStatement = IncomeStatement();
    //TODO
    return incomeStatement;
  }

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

  /// Other operating expenses that are not R&D neither SG&A
  double get otherOperatingExpenses =>
      totalOperatingExpenses - researchAndDevelopmentExpenses - generalAndAdministrativeExpenses;

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
  ''';
}
