import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/src/edgar_sec_service.dart';
import 'package:flutter_edgar_sec/src/model/r1_company_results.dart';
import 'package:flutter_edgar_sec/src/ui/chart/income/income_funnel_ui.dart';

/// A custom widget that displays the income funnel chart for a specified company symbol.
///
/// This widget fetches the financial statements data for the given [symbol] and
/// displays the income funnel chart using the [IncomeFunnelUI] widget.
class CompanyChartUI extends StatefulWidget {
  /// The company symbol for which the financial statements data will be fetched.
  final String symbol;

  /// The color used for positive values in the chart (e.g., revenues,
  /// gross profit, operating income). Defaults to [Colors.green] if not provided.
  final Color positiveColor;

  /// The color used for negative values in the chart (e.g., cost of revenues,
  /// operating expenses, income tax expense). Defaults to [Colors.red] if not provided.
  final Color negativeColor;

  /// The color used for the delivered to holders value in the chart.
  final Color deliveredToHoldersColor;

  /// Creates a [CompanyChartUI] widget.
  ///
  /// The [symbol] parameter is required and must not be null.
  /// The [positiveColor] and [negativeColor] parameters are optional and have
  /// default values of [Colors.green] and [Colors.red], respectively.
  const CompanyChartUI({
    required this.symbol,
    this.positiveColor = const Color(0xff005522),
    this.negativeColor = const Color(0xff550022),
    this.deliveredToHoldersColor = const Color(0xff000066),
    super.key,
  });

  @override
  State<CompanyChartUI> createState() => _CompanyChartUIState();
}

class _CompanyChartUIState extends State<CompanyChartUI> {
  /// Indicates whether the financial data is still being fetched.
  bool loading = true;

  /// The company's financial statements data fetched from the Edgar SEC service.
  CompanyResults _companyResults = CompanyResults.empty();

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    _companyResults =
        await EdgarSecService.getFinancialStatementsForSymbol(widget.symbol);
    loading = false;
    setState(() {});
  }

  /// Builds the widget.
  ///
  /// If the financial data is still being fetched, a [CircularProgressIndicator] is shown.
  /// Once the data is available, an [IncomeFunnelUI] widget is created with the fetched data.
  @override
  Widget build(BuildContext context) => loading
      ? const Center(
          child: CircularProgressIndicator(),
        )
      : IncomeFunnelUI(
          companyResults: _companyResults,
          negativeColor: widget.negativeColor,
          positiveColor: widget.positiveColor,
        );
}
