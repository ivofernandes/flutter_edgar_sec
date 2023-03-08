import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/src/model/enums/financial_statment_period.dart';
import 'package:flutter_edgar_sec/src/model/financials/balance_sheet.dart';
import 'package:flutter_edgar_sec/src/model/financials/cash_flow_statement.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r1_company_results.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/ui/table/rows/balance_sheet_rows.dart';
import 'package:flutter_edgar_sec/src/ui/table/rows/cash_flow_statement_rows.dart';
import 'package:flutter_edgar_sec/src/ui/table/rows/income_statement_rows.dart';

/// Create the data table with the company data
class CompanyDataTable extends StatelessWidget {
  final CompanyResults companyResults;
  final FinancialStatementPeriod period;
  final int selectedStatement;

  const CompanyDataTable({
    required this.companyResults,
    required this.period,
    required this.selectedStatement,
  });

  @override
  Widget build(BuildContext context) {
    final List<FinancialStatement> reports = companyResults.quarters;

    if (reports.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    return DataTable(
      columns: [
        // Empty column for the labels
        DataColumn(
          label: const Text(''),
        ),
        // Columns with the time period
        ...reports
            .map(
              (FinancialStatement report) => DataColumn(
                label: Text(report.quarterPeriod),
              ),
            )
            .toList()
      ],
      rows: getRowsForReports(reports, selectedStatement),
    );
  }

  /// Create the rows for the data table, depending on the selected statement
  /// For 0: Income Statement
  /// For 1: Balance Sheet
  /// For 2: Cash Flow Statement
  List<DataRow> getRowsForReports(List<FinancialStatement> reports, int selectedStatement) {
    if (selectedStatement == 0) {
      final List<IncomeStatement> incomeStatements =
          reports.map((FinancialStatement report) => report.incomeStatement).toList();

      return IncomeStatementRows.getRows(incomeStatements);
    }
    if (selectedStatement == 1) {
      final List<BalanceSheet> balanceSheets = reports.map((FinancialStatement report) => report.balanceSheet).toList();

      return BalanceSheetRows.getRows(balanceSheets);
    } else {
      final List<CashFlowStatement> cashFlowStatements =
          reports.map((FinancialStatement report) => report.cashFlowStatement).toList();

      return CashFlowStatementRows.getRows(cashFlowStatements);
    }
  }
}
