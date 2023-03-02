import 'package:flutter_edgar_sec/src/model/enums/financial_statment_period.dart';
import 'package:flutter_edgar_sec/src/model/financials/balance_sheet.dart';
import 'package:flutter_edgar_sec/src/model/financials/cash_flow_statement.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';

class FinancialStatement {
  final DateTime date;

  int get year => date.year;

  int get month => date.month;

  int get quarter => date.month ~/ 3;

  final FinancialStatementPeriod period;

  final IncomeStatement incomeStatement;
  final BalanceSheet balanceSheet;
  final CashFlowStatement cashFlowStatement;

  FinancialStatement({
    required this.date,
    required this.period,
    required this.incomeStatement,
    required this.balanceSheet,
    required this.cashFlowStatement,
  });

  String get incomeStatementString => incomeStatement.toString();

  @override
  String toString() => '''
    date: $year-$month
    incomeStatementString:
    $incomeStatementString
    balanceSheet: 
    $balanceSheet
    cashFlowStatement: 
    $cashFlowStatement
    ''';
}
