import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r1_company_results.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/ui/chart/income/funnel_step.dart';

/// A custom widget that represents an income funnel chart.
///
/// This widget takes a [CompanyResults] object and displays the income
/// statement data in a funnel chart. The chart shows the following financial
/// data: revenues, cost of revenues, gross profit, operating expenses,
/// operating income, income tax expense, and net income.
///
/// The [positiveColor] parameter is used for positive values (e.g., revenues,
/// gross profit, operating income) and defaults to [Colors.green] if not provided.
///
/// The [negativeColor] parameter is used for negative values (e.g., cost of revenues,
/// operating expenses, income tax expense) and defaults to [Colors.red] if not provided.
class IncomeFunnelUI extends StatelessWidget {
  final CompanyResults companyResults;

  /// The color used for positive values (e.g., revenues, gross profit, operating income)
  final Color positiveColor;

  /// The color used for negative values (e.g., cost of revenues, operating expenses, income tax expense)
  final Color negativeColor;

  /// The color used to represent the dividends and buybacks, the direct to holders payments
  final Color deliveredToHolders;

  /// Creates an [IncomeFunnelUI] widget.
  ///
  /// The [companyResults] parameter is required and must not be null.
  /// The [positiveColor] and [negativeColor] parameters are optional
  const IncomeFunnelUI({
    required this.companyResults,
    this.positiveColor = const Color(0xff005500),
    this.negativeColor = Colors.red,
    this.deliveredToHolders = const Color(0xff000088),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FinancialStatement financialStatement = companyResults.yearReports.last;
    final IncomeStatement incomeStatement = financialStatement.incomeStatement;
    final cashFlowStatement = financialStatement.cashFlowStatement;

    final LinkedHashMap<String, Tuple<double, Color>> data = LinkedHashMap.from({
      'Revenues': Tuple(incomeStatement.revenues, positiveColor),
      'Cost of Revenue': Tuple(incomeStatement.costOfRevenues, negativeColor),
      'Gross Profit': Tuple(incomeStatement.grossProfit, positiveColor),
      'Operating Expenses': Tuple(incomeStatement.operatingExpenses, negativeColor),
      'Operating Income': Tuple(incomeStatement.operatingIncome, positiveColor),
      'Interest Expense': Tuple(incomeStatement.interestExpenses, negativeColor),
      'Income Tax Expense': Tuple(incomeStatement.incomeTaxExpense, negativeColor),
      'Other Expenses': Tuple(incomeStatement.otherNonOperatingIncomeExpense.abs(), negativeColor),
      'Net Income': Tuple(incomeStatement.netIncome, positiveColor),
      'Buybacks': Tuple(cashFlowStatement.buyback, deliveredToHolders),
      'Dividend': Tuple(cashFlowStatement.dividends, deliveredToHolders),
    });

    final maxValue = incomeStatement.revenues;

    return Column(
      children: data.entries
          .map((entry) =>
          FunnelStep(
            label: entry.key,
            value: entry.value.item1,
            maxValue: maxValue,
            color: entry.value.item2,
          ))
          .toList(),
    );
  }
}

class Tuple<T1, T2> {
  final T1 item1;
  final T2 item2;

  Tuple(this.item1, this.item2);
}
