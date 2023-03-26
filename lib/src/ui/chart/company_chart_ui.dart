import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/src/edgar_sec_service.dart';
import 'package:flutter_edgar_sec/src/model/r1_company_results.dart';
import 'package:flutter_edgar_sec/src/ui/chart/income/income_funnel_ui.dart';

class CompanyChartUI extends StatefulWidget {
  final String symbol;

  const CompanyChartUI({
    required this.symbol,
    super.key,
  });

  @override
  State<CompanyChartUI> createState() => _CompanyChartUIState();
}

class _CompanyChartUIState extends State<CompanyChartUI> {
  bool loading = true;
  CompanyResults _companyResults = CompanyResults.empty();

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    _companyResults = await EdgarSecService.getFinancialStatementsForSymbol(widget.symbol);
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => loading
      ? const Center(
          child: CircularProgressIndicator(),
        )
      : IncomeFunnelUI(
          companyResults: _companyResults,
        );
}
