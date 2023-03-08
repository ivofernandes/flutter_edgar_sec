import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/src/model/enums/financial_statment_period.dart';
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

  int selectedStatement = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.companyResults.years.length + 1,
      itemBuilder: (context, i) {
        if (i == 0) {
          // This is the only part that will remain in the end
          return SizedBox(
            height: 200,
            width: 500,
            child: InteractiveViewer(
              boundaryMargin: const EdgeInsets.only(bottom: 750),
              minScale: 0.1,
              maxScale: 5,
              constrained: false,
              child: Column(
                children: [
                  CompanyTableOptions(
                    period: period,
                  ),
                  CompanyDataTable(
                    companyResults: widget.companyResults,
                    period: period,
                    selectedStatement: selectedStatement,
                  ),
                ],
              ),
            ),
          );
        }

        // This part is just for easier logging
        int index = i - 1;

        final int year = widget.companyResults.years[index]!;

        return Card(
          child: Column(
            children: [
              Text(
                year.toString(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(widget.companyResults.yearlyResults[year]!.toString()),
            ],
          ),
        );
      },
    );
  }
}
