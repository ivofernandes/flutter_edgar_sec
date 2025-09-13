import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/processor/quarters/distribute_statements.dart';
import 'package:flutter_edgar_sec/src/processor/quarters/fact_group_processor.dart';

/// Logic related to process 10-Q and 10-K financial statements
abstract class PeriodProcessor {
  /// Returns a map of quarters and a map of annual financial statements for a given symbol
  static Future<Map<int, YearlyResults>> process(
      Map<String, dynamic> usGaapFacts,
      Map<String, dynamic> ifrsFullFacts,
      List<String> referenceFields) async {
    // Create the quarter and annual data indexes
    final Map<String, FinancialStatement> quarters = {};
    final Map<String, FinancialStatement> annuals = {};

    await FactGroupProcessor.processFactsGroup(
        quarters, annuals, usGaapFacts, referenceFields);
    await FactGroupProcessor.processFactsGroup(
        quarters, annuals, ifrsFullFacts, referenceFields);

    //TODO for balance sheet, we don't need to stay inside the boundaries of the quarter
    //TODO we can use 6 months or 9 months reports

    //TODO for cash flow sometimes they report 3 months, then 6 months, then 9 months
    //TODO so we need further computation to get the right values

    // Get all the years available
    final Map<int, YearlyResults> yearlyResults = {};
    DistributeStatements.distributeByQuarter(quarters, yearlyResults);
    DistributeStatements.distributeByYear(annuals, yearlyResults);

    return yearlyResults;
  }
}
