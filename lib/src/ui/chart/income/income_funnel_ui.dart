import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r1_company_results.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/ui/chart/income/funnel_step.dart';

class IncomeFunnelUI extends StatelessWidget {
  final CompanyResults companyResults;

  const IncomeFunnelUI({
    required this.companyResults,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FinancialStatement financialStatement = companyResults.yearReports.last;
    final IncomeStatement incomeStatement = financialStatement.incomeStatement;

    final revenues = incomeStatement.revenues;
    final costOfRevenue = incomeStatement.costOfRevenues;
    final grossProfit = incomeStatement.grossProfit;
    final operatingExpenses = incomeStatement.operatingExpenses;
    final operatingIncome = incomeStatement.operatingIncome;
    final incomeTaxExpense = incomeStatement.incomeTaxExpense;
    final netIncome = incomeStatement.netIncome;

    final maxValue = revenues;

    return Container(
      height: 300,
      child: Stack(
        children: [
          FunnelStep(
            label: 'Revenues',
            value: revenues,
            maxValue: maxValue,
            color: Colors.green,
            top: 0,
          ),
          FunnelStep(
            label: 'Cost of Revenue',
            value: costOfRevenue,
            maxValue: maxValue,
            color: Colors.red,
            top: 40,
          ),
          FunnelStep(
            label: 'Gross Profit',
            value: grossProfit,
            maxValue: maxValue,
            color: Colors.green,
            top: 80,
          ),
          FunnelStep(
            label: 'Operating Expenses',
            value: operatingExpenses,
            maxValue: maxValue,
            color: Colors.red,
            top: 120,
          ),
          FunnelStep(
            label: 'Operating Income',
            value: operatingIncome,
            maxValue: maxValue,
            color: Colors.green,
            top: 160,
          ),
          FunnelStep(
            label: 'Income Tax Expense',
            value: incomeTaxExpense,
            maxValue: maxValue,
            color: Colors.red,
            top: 200,
          ),
          FunnelStep(
            label: 'Net Income',
            value: netIncome,
            maxValue: maxValue,
            color: Colors.green,
            top: 240,
          ),
        ],
      ),
    );
  }
}
