import 'package:flutter_edgar_sec/src/model/enums/financial_statment_period.dart';
import 'package:flutter_edgar_sec/src/model/financials/balance_sheet.dart';
import 'package:flutter_edgar_sec/src/model/financials/cash_flow_statement.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';

class FinancialStatement {
  /// The date of the financial statement
  final DateTime date;

  /// The period of the financial statement: quarterly or annual
  final FinancialStatementPeriod period;

  /// The income statement of the financial statement
  final IncomeStatement incomeStatement;

  /// The balance sheet of the financial statement
  final BalanceSheet balanceSheet;

  /// The cash flow statement of the financial statement
  final CashFlowStatement cashFlowStatement;

  /// Calculated fields
  /// Calculates the year of the financial statement
  int get year => date.year;

  /// Calculates the month of the financial statement
  int get month => date.month;

  /// Calculates the quarter of the financial statement
  int get quarter => date.month ~/ 3;

  /// Calculates the title of the quarter financial statement
  String get quarterPeriod => '$year-Q$quarter';

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
