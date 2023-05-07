import 'package:flutter_edgar_sec/src/model/enums/financial_statment_period.dart';
import 'package:flutter_edgar_sec/src/model/enums/financial_type.dart';
import 'package:flutter_edgar_sec/src/model/financials/balance_sheet.dart';
import 'package:flutter_edgar_sec/src/model/financials/cash_flow_statement.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';

class FinancialStatement implements Comparable<FinancialStatement> {

  /// The start date of the period reported
  final DateTime startDate;

  /// The end date of the period reported
  final DateTime endDate;

  /// Date of the reporting of the financial statement
  final DateTime filedDate;

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
  int get year => endDate.year;

  /// Calculates the month of the financial statement
  int get month => endDate.month;

  /// Calculates the quarter of the financial statement
  int get quarter => endDate.month ~/ 3;

  /// Calculates the title of the quarter financial statement
  String get quarterPeriod => '$year-Q$quarter';

  /// Calculates the title of the annual financial statement
  String get annualPeriod => year.toString();

  /// https://gocardless.com/guides/posts/return-on-capital-employed-formula
  double get ROCE => incomeStatement.EBIT / balanceSheet.capitalEmployed;

  /// https://www.investopedia.com/terms/p/payoutratio.asp
  double get payoutRatio => cashFlowStatement.dividends / incomeStatement.netIncome;

  /// Buybacks plus dividends divided by net income
  double get totalShareholderReturn => cashFlowStatement.shareBasedCompensation / incomeStatement.netIncome;

  FinancialStatement({
    required this.startDate,
    required this.endDate,
    required this.filedDate,
    required this.period,
    required this.incomeStatement,
    required this.balanceSheet,
    required this.cashFlowStatement,
  });

  /// If we have a full year report,and just one missing quarter, we can extrapolate the missing quarter report
  factory FinancialStatement.extrapolate(DateTime startDate,
      DateTime endDate,
      FinancialStatement fullYear,
      FinancialStatement q1,
      FinancialStatement q2,
      FinancialStatement q3,) =>
      FinancialStatement(
        startDate: startDate,
        endDate: endDate,
        filedDate: fullYear.filedDate,
        period: FinancialStatementPeriod.quarterly,
        incomeStatement: IncomeStatement.extrapolate(
          fullYear.incomeStatement,
          q1.incomeStatement,
          q2.incomeStatement,
          q3.incomeStatement,
        ),
        balanceSheet: BalanceSheet.extrapolate(
          fullYear.balanceSheet,
          q1.balanceSheet,
          q2.balanceSheet,
          q3.balanceSheet,
        ),
        cashFlowStatement: CashFlowStatement.extrapolate(
          fullYear.cashFlowStatement,
          q1.cashFlowStatement,
          q2.cashFlowStatement,
          q3.cashFlowStatement,
        ),
      );

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

  /// Get the correct list of labels for the financial statement
  List<String> getLabelsForFinancialStatement(FinancialType selectedFinancial) {
    switch (selectedFinancial) {
      case FinancialType.incomeStatement:
        return IncomeStatement.labels;
      case FinancialType.balanceSheet:
        return BalanceSheet.labels;
      case FinancialType.cashFlowStatement:
        return CashFlowStatement.labels;
    }
  }

  @override
  int compareTo(FinancialStatement other) => endDate.compareTo(other.endDate);
}
