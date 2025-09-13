import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/src/edgar_sec_repository.dart';
import 'package:flutter_edgar_sec/src/edgar_sec_service.dart';
import 'package:flutter_edgar_sec/src/model/r1_company_results.dart';
import 'package:flutter_edgar_sec/src/ui/company_table_ui.dart';

/// Widget to load a table directly from the symbol
class EdgarTableUI extends StatefulWidget {
  /// Symbol to load the table
  final String symbol;

  /// Width of the table
  final double width;

  /// Height of the table
  final double height;

  /// Use cache
  final bool useCache;

  const EdgarTableUI({
    required this.symbol,
    this.height = 400,
    this.width = 500,
    this.useCache = false,
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
    if (widget.useCache) {
      _companyResults =
          await EdgarSecRepository.getFinancialStatementsForSymbol(
              symbol: widget.symbol);
    } else {
      _companyResults =
          await EdgarSecService.getFinancialStatementsForSymbol(widget.symbol);
    }
    loading = false;

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) => loading
      ? const Center(
          child: CircularProgressIndicator(),
        )
      : CompanyTableUI(
          companyResults: _companyResults,
          height: widget.height,
          width: widget.width,
        );
}
