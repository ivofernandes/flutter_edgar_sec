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
    final double? value = getDoubleValueForIndex(index);
    final Set<String> percentLabels = {
      'Operating Margin',
      'Net Margin',
      'Interest Coverage Ratio',
    };
    final Set<String> currencyLabels = {
      'EPS',
      'EPS Diluted',
    };

    if (percentLabels.contains(labels[index])) {
      return value?.percentFormat ?? '';
    }
    if (currencyLabels.contains(labels[index])) {
      return value?.currencyFormat ?? '';
    } else {
      return value?.reportFormat ?? '';
    }
  }

  double? getDoubleValueForIndex(int index) {
    final String name = labels[index];

    return getValueForLabel(name);
  }

  double? getValueForLabel(String name) {
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
        return null;
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

  factory IncomeStatement.fromJson(Map<String, dynamic> json) =>
      IncomeStatement()
        ..revenues = json['revenues'] as double
        ..costOfRevenues = json['costOfRevenues'] as double
        ..grossProfit = json['grossProfit'] as double
        ..researchAndDevelopmentExpenses =
            json['researchAndDevelopmentExpenses'] as double
        ..generalAndAdministrativeExpenses =
            json['generalAndAdministrativeExpenses'] as double
        ..operatingIncome = json['operatingIncome'] as double
        ..foreignCurrencyExchange = json['foreignCurrencyExchange'] as double
        ..interestExpenses = json['interestExpenses'] as double
        ..otherNonOperatingIncomeExpense =
            json['otherNonOperatingIncomeExpense'] as double
        ..incomeTaxExpense = json['incomeTaxExpense'] as double
        ..netIncome = json['netIncome'] as double
        ..eps = json['eps'] as double
        ..epsDiluted = json['epsDiluted'] as double
        ..shares = json['shares'] as double
        ..sharesDiluted = json['sharesDiluted'] as double;

  Map<String, dynamic> toJson() => {
        'revenues': revenues,
        'costOfRevenues': costOfRevenues,
        'grossProfit': grossProfit,
        'researchAndDevelopmentExpenses': researchAndDevelopmentExpenses,
        'generalAndAdministrativeExpenses': generalAndAdministrativeExpenses,
        'operatingIncome': operatingIncome,
        'foreignCurrencyExchange': foreignCurrencyExchange,
        'interestExpenses': interestExpenses,
        'otherNonOperatingIncomeExpense': otherNonOperatingIncomeExpense,
        'incomeTaxExpense': incomeTaxExpense,
        'netIncome': netIncome,
        'eps': eps,
        'epsDiluted': epsDiluted,
        'shares': shares,
        'sharesDiluted': sharesDiluted,
      };
}
