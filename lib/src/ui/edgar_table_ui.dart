import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/src/edgar_sec_service.dart';
import 'package:flutter_edgar_sec/src/model/r1_company_results.dart';
import 'package:flutter_edgar_sec/src/ui/company_table_ui.dart';

/// Widget to load a table directly from the symbol
class EdgarTableUI extends StatefulWidget {
  final String symbol;

  const EdgarTableUI({
    required this.symbol,
    super.key,
  });

  @override
  State<EdgarTableUI> createState() => _EdgarTableUIState();
}

class _EdgarTableUIState extends State<EdgarTableUI> {
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
      : CompanyTableUI(
          companyResults: _companyResults,
        );
}
