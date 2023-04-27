import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/ui/chart/income/funnel/funnel_step.dart';

class SingleReportFunnel extends StatelessWidget {

  final FinancialStatement financialStatement;

  final Color positiveColor;
  final Color negativeColor;
  final Color deliveredToHolders;

  const SingleReportFunnel({
    required this.financialStatement,
    required this.positiveColor,
    required this.negativeColor,
    required this.deliveredToHolders,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final IncomeStatement incomeStatement = financialStatement.incomeStatement;
    final cashFlowStatement = financialStatement.cashFlowStatement;

    final LinkedHashMap<String, Tuple<double, Color>> data = LinkedHashMap.from({
      'Revenues': Tuple(incomeStatement.revenues, positiveColor),
      'Cost of Revenue': Tuple(incomeStatement.costOfRevenues, negativeColor),
      'Gross Profit': Tuple(incomeStatement.grossProfit, positiveColor),
      'R&D': Tuple(incomeStatement.researchAndDevelopmentExpenses, negativeColor),
      'General & Admin': Tuple(incomeStatement.generalAndAdministrativeExpenses, negativeColor),
      'Operating Expenses': Tuple(incomeStatement.totalOperatingExpenses, negativeColor),
      'Operating Income': Tuple(incomeStatement.operatingIncome, positiveColor),
      'Interest Expense': Tuple(incomeStatement.interestExpenses, negativeColor),
      'Income Tax Expense': Tuple(incomeStatement.incomeTaxExpense, negativeColor),
      'Other Expenses': Tuple(incomeStatement.otherNonOperatingIncomeExpense.abs(), negativeColor),
      'Net Income': Tuple(incomeStatement.netIncome, positiveColor),
      'Total shareholder return': Tuple(cashFlowStatement.totalShareholderReturn, deliveredToHolders),
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
