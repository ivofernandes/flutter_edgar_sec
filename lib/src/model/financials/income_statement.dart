import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_mixins/income_extrapolate.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_mixins/income_values.dart';

class IncomeStatement with IncomeValues, IncomeExtrapolate {
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
    'EPS',
    'EPS Diluted',
    'Shares',
    'Shares Diluted',
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

    return getValueForLabel(name);
  }

  double getValueForLabel(String name) {
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
      case 'EPS':
        return eps;
      case 'EPS Diluted':
        return epsDiluted;
      case 'Shares':
        return shares;
      case 'Shares Diluted':
        return sharesDiluted;
      default:
        return 0;
    }
  }

  IncomeStatement();

  factory IncomeStatement.extrapolate(
    IncomeStatement fullYear,
    IncomeStatement qa,
    IncomeStatement qb,
    IncomeStatement qc,
  ) {
    final IncomeStatement incomeStatement = IncomeStatement();

    IncomeExtrapolate.fillMissingQuarter(incomeStatement, fullYear, qa, qb, qc);

    return incomeStatement;
  }
}
