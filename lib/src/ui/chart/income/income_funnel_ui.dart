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
  final Color positiveColor;
  final Color negativeColor;

  /// Creates an [IncomeFunnelUI] widget.
  ///
  /// The [companyResults] parameter is required and must not be null.
  /// The [positiveColor] and [negativeColor] parameters are optional and have
  /// default values of [Colors.green] and [Colors.red], respectively.
  const IncomeFunnelUI({
    required this.companyResults,
    this.positiveColor = Colors.green,
    this.negativeColor = Colors.red,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FinancialStatement financialStatement = companyResults.yearReports.last;
    final IncomeStatement incomeStatement = financialStatement.incomeStatement;

    final LinkedHashMap<String, Tuple<double, Color>> data = LinkedHashMap.from({
      'Revenues': Tuple(incomeStatement.revenues, positiveColor),
      'Cost of Revenue': Tuple(incomeStatement.costOfRevenues, negativeColor),
      'Gross Profit': Tuple(incomeStatement.grossProfit, positiveColor),
      'Operating Expenses': Tuple(incomeStatement.operatingExpenses, negativeColor),
      'Operating Income': Tuple(incomeStatement.operatingIncome, positiveColor),
      'Income Tax Expense': Tuple(incomeStatement.incomeTaxExpense, negativeColor),
      'Net Income': Tuple(incomeStatement.netIncome, positiveColor),
    });

    final maxValue = incomeStatement.revenues;

    return Column(
      children: data.entries
          .map((entry) => FunnelStep(
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
