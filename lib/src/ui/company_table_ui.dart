import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/src/model/enums/financial_statment_period.dart';
import 'package:flutter_edgar_sec/src/model/enums/financial_type.dart';
import 'package:flutter_edgar_sec/src/model/r1_company_results.dart';
import 'package:flutter_edgar_sec/src/ui/options/company_table_options.dart';
import 'package:flutter_edgar_sec/src/ui/table/company_data_table.dart';

/// Basic company table UI, like the one of most of the stock apps
class CompanyTableUI extends StatefulWidget {
  final CompanyResults companyResults;

  CompanyTableUI({
    required this.companyResults,
  });

  @override
  State<CompanyTableUI> createState() => _CompanyTableUIState();
}

class _CompanyTableUIState extends State<CompanyTableUI> {
  FinancialStatementPeriod period = FinancialStatementPeriod.quarterly;

  FinancialType selectedStatement = FinancialType.incomeStatement;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 400,
        width: 500,
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
