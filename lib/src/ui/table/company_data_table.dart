import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/src/model/enums/financial_statment_period.dart';
import 'package:flutter_edgar_sec/src/model/enums/financial_type.dart';
import 'package:flutter_edgar_sec/src/model/r1_company_results.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/ui/table/settings/settings_button.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

/// Create the data table with the company data
class CompanyDataTable extends StatefulWidget {
  /// Actual data for the table
  final CompanyResults companyResults;

  /// The period of the financial statement: quarterly or annual
  final FinancialStatementPeriod periodDefault;

  /// The type of the financial statement: income statement, balance sheet or cash flow statement
  final FinancialType financialTypeDefault;

  /// The width of the columns
  final double columnWidth;

  const CompanyDataTable({
    required this.companyResults,
    required this.periodDefault,
    required this.financialTypeDefault,
    this.columnWidth = 100,
  });

  @override
  State<CompanyDataTable> createState() => _CompanyDataTableState();
}

class _CompanyDataTableState extends State<CompanyDataTable> {
  FinancialStatementPeriod period = FinancialStatementPeriod.annual;
  FinancialType financialType = FinancialType.incomeStatement;

  @override
  void initState() {
    super.initState();

    period = widget.periodDefault;
    financialType = widget.financialTypeDefault;
  }

  @override
  Widget build(BuildContext context) {
    final List<FinancialStatement> reports = widget.companyResults.quarters;

    if (reports.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    final firstRow = _getTitleWidget(reports);
    final List<String> labels = reports.first.getLabelsForFinancialStatement(financialType);

    return HorizontalDataTable(
      leftHandSideColumnWidth: 100,
      rightHandSideColumnWidth: widget.columnWidth * reports.length,
      isFixedHeader: true,
      headerWidgets: firstRow,
      leftSideItemBuilder: (context, index) => _generateFirstColumnRow(reports, index),
      rightSideItemBuilder: (context, index) => _generateRightHandSideColumnRow(reports, index),
      itemCount: labels.length,
      rowSeparatorWidget: const Divider(
        color: Colors.black38,
        height: 1,
        thickness: 0,
      ),
      leftHandSideColBackgroundColor: Theme.of(context).canvasColor,
      rightHandSideColBackgroundColor: Theme.of(context).canvasColor,
    );
  }

  List<Widget> _getTitleWidget(List<FinancialStatement> reports) => [
        SizedBox(
          width: 100,
          height: 56,
          child: SettingsButton(
            financialStatementPeriod: period,
            financialType: financialType,
            onFinancialStatementPeriodChanged: (newPeriod) {
              period = newPeriod;
              setState(() {});
              //TODO implement the annual table
            },
            onFinancialTypeChanged: (newType) {
              financialType = newType;
              setState(() {});
            },
          ),
        ),
        ...reports.map(
          (FinancialStatement report) => _getTitleItemWidget(report.quarterPeriod, 100),
        )
      ];

  Widget _getTitleItemWidget(String label, double width) => Container(
        width: width,
        height: 56,
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.centerLeft,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      );

  Widget _generateFirstColumnRow(List<FinancialStatement> reports, int index) {
    final List<String> labels = reports.first.getLabelsForFinancialStatement(financialType);
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

  Widget _generateRightHandSideColumnRow(List<FinancialStatement> reports, int index) => Row(
        children: reports
            .map(
              (report) => Container(
                width: 100,
                height: 52,
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                alignment: Alignment.centerLeft,
                child: Text(getDataForReport(report, index)),
              ),
            )
            .toList(),
      );

  String getDataForReport(FinancialStatement report, int index) {
    if (financialType == FinancialType.incomeStatement) {
      return report.incomeStatement.getValueForIndex(index);
    } else if (financialType == FinancialType.balanceSheet) {
      return report.balanceSheet.getValueForIndex(index);
    } else {
      return report.cashFlowStatement.getValueForIndex(index);
    }
  }
}
