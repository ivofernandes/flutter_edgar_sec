import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/src/model/enums/financial_statment_period.dart';
import 'package:flutter_edgar_sec/src/model/r1_company_results.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/ui/chart/income/funnel/single_report_funnel.dart';

/// A custom widget that represents an income funnel chart.
///
/// This widget takes a [CompanyResults] object and displays the income
/// statement data in a funnel chart. The chart shows the following financial
/// data: revenues, cost of revenues, gross profit, operating expenses,
/// operating income, income tax expense, and net income.
///
/// The [positiveColor] parameter is used for positive values (e.g., revenues,
/// gross profit, operating income) and defaults to [Colors.green] if not provided.
///
/// The [negativeColor] parameter is used for negative values (e.g., cost of revenues,
/// operating expenses, income tax expense) and defaults to [Colors.red] if not provided.
class IncomeFunnelUI extends StatefulWidget {
  final CompanyResults companyResults;

  /// The color used for positive values (e.g., revenues, gross profit, operating income)
  final Color positiveColor;

  /// The color used for negative values (e.g., cost of revenues, operating expenses, income tax expense)
  final Color negativeColor;

  /// The color used to represent the dividends and buybacks, the direct to holders payments
  final Color deliveredToHolders;

  /// The period for which the financial statements data will be displayed
  final FinancialStatementPeriod period;

  /// Creates an [IncomeFunnelUI] widget.
  ///
  /// The [companyResults] parameter is required and must not be null.
  /// The [positiveColor] and [negativeColor] parameters are optional
  const IncomeFunnelUI({
    required this.companyResults,
    this.period = FinancialStatementPeriod.quarterly,
    this.positiveColor = const Color(0xff005500),
    this.negativeColor = Colors.red,
    this.deliveredToHolders = const Color(0xff000088),
    super.key,
  });

  @override
  State<IncomeFunnelUI> createState() => _IncomeFunnelUIState();
}

class _IncomeFunnelUIState extends State<IncomeFunnelUI> {
  int selectedStatementIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FinancialStatement financialStatement = getCurrentStatement();

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: getStatements()
                .map(
                  (String statementName) => Container(
                    margin: const EdgeInsets.all(10),
                    child: MaterialButton(
                      child: Text(statementName),
                      onPressed: () {
                        setState(() {
                          selectedStatementIndex = getStatements().indexOf(statementName);
                        });
                      },
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        SingleReportFunnel(
          financialStatement: financialStatement,
          positiveColor: widget.positiveColor,
          negativeColor: widget.negativeColor,
          deliveredToHolders: widget.deliveredToHolders,
        ),
      ],
    );
  }

  List<String> getStatements() {
    if (widget.period.isQuarter) {
      return widget.companyResults.quarters.map((e) => e.quarterPeriod).toList().reversed.toList();
    } else {
      return widget.companyResults.yearReports.map((e) => e.year.toString()).toList().reversed.toList();
    }
  }

  /// Returns the current financial statement based on the [period] parameter
  FinancialStatement getCurrentStatement() {
    if (widget.period.isQuarter) {
      return widget.companyResults.quarters.reversed.toList()[selectedStatementIndex];
    } else {
      return widget.companyResults.yearReports.reversed.toList()[selectedStatementIndex];
    }
  }
}
