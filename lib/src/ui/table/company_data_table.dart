import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/src/model/enums/financial_statment_period.dart';
import 'package:flutter_edgar_sec/src/model/enums/financial_type.dart';
import 'package:flutter_edgar_sec/src/model/financials/balance_sheet.dart';
import 'package:flutter_edgar_sec/src/model/financials/cash_flow_statement.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r1_company_results.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/ui/table/rows/balance_sheet_rows.dart';
import 'package:flutter_edgar_sec/src/ui/table/rows/cash_flow_statement_rows.dart';
import 'package:flutter_edgar_sec/src/ui/table/rows/income_statement_rows.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

/// Create the data table with the company data
class CompanyDataTable extends StatelessWidget {
  final CompanyResults companyResults;
  final FinancialStatementPeriod period;
  final FinancialType selectedFinancial;
  final double columnWidth;

  const CompanyDataTable({
    required this.companyResults,
    required this.period,
    required this.selectedFinancial,
    this.columnWidth = 100,
  });

  @override
  Widget build(BuildContext context) {
    final List<FinancialStatement> reports = companyResults.quarters;

    if (reports.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    return HorizontalDataTable(
      leftHandSideColumnWidth: 100,
      rightHandSideColumnWidth: columnWidth * reports.length,
      isFixedHeader: true,
      headerWidgets: _getTitleWidget(reports),
      leftSideItemBuilder: (context, index) => _generateFirstColumnRow(reports, index),
      rightSideItemBuilder: (context, index) => _generateRightHandSideColumnRow(reports, index),
      itemCount: 10,
      rowSeparatorWidget: const Divider(
        color: Colors.black38,
        height: 1.0,
        thickness: 0.0,
      ),
      leftHandSideColBackgroundColor: Theme.of(context).canvasColor,
      rightHandSideColBackgroundColor: Theme.of(context).canvasColor,
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

  List<Widget> _getTitleWidget(List<FinancialStatement> reports) {
    return [
      _getTitleItemWidget('', 100),
      ...reports.map(
        (FinancialStatement report) => _getTitleItemWidget(report.quarterPeriod, 100),
      )
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _generateFirstColumnRow(List<FinancialStatement> reports, int index) {
    final List<String> labels = reports.first.getLabelsForFinancialStatement(selectedFinancial);
    final String label = labels[index];
    return Container(
      width: 100,
      height: 52,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Tooltip(
        message: label,
        child: Text(label),
      ),
    );
  }

  Widget _generateRightHandSideColumnRow(List<FinancialStatement> reports, int index) {
    return InteractiveViewer(
      child: Row(
        children: <Widget>[
          Container(
            width: 100,
            height: 52,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[Text('values')],
            ),
          ),
          Container(
            width: 200,
            height: 52,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Text('values'),
          ),
          Container(
            width: 100,
            height: 52,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Text('values'),
          ),
          Container(
            width: 200,
            height: 52,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Text('values'),
          ),
        ],
      ),
    );
  }
}
