import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_edgar_sec/src/model/enums/financial_statment_period.dart';
import 'package:flutter_edgar_sec/src/model/enums/financial_type.dart';
import 'package:flutter_edgar_sec/src/ui/table/company_data_table.dart';

/// Basic company table UI, like the one of most of the stock apps
class CompanyTableUI extends StatefulWidget {
  final CompanyResults companyResults;
  final double width;
  final double height;

  const CompanyTableUI({
    required this.companyResults,
    this.height = 400,
    this.width = 500,
    super.key,
  });

  @override
  State<CompanyTableUI> createState() => _CompanyTableUIState();
}

class _CompanyTableUIState extends State<CompanyTableUI> {
  final FinancialStatementPeriod period = FinancialStatementPeriod.quarterly;

  final FinancialType selectedStatement = FinancialType.incomeStatement;

  int get getLabelsCount {
    switch (selectedStatement) {
      case FinancialType.balanceSheet:
        return BalanceSheet.labels.length;
      case FinancialType.incomeStatement:
        return IncomeStatement.labels.length;
    }

    return CashFlowStatement.labels.length;
  }

  @override
  Widget build(BuildContext context) =>
      SizedBox(
        height: widget.height,
        width: widget.width,
        child: SizedBox(
          height: 1000,
          width: 1000,
          child: CompanyDataTable(
            companyResults: widget.companyResults,
            periodDefault: period,
            financialTypeDefault: selectedStatement,
          ),
        ),
      );
}
