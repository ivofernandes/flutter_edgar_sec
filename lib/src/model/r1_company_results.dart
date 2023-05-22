import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/processor/quarters/period_processor.dart';
import 'package:flutter_edgar_sec/src/processor/validator/yearly_results_validator.dart';

/// A class that represents all the financial statements for a given company
class CompanyResults {
  /// A map of all the financial statements for this company, organized by year
  final Map<int, YearlyResults> yearlyResults;

  /// Returns a list of all the years that have financial data on this company
  List<int> get years {
    final List<int> years = yearlyResults.keys.toList();
    years.sort();
    return years;
  }

  /// Returns a list of all the quarters that are already reported for this company
  List<FinancialStatement> get quarters =>
      yearlyResults.values.map((e) => e.quarters).expand((element) => element).toList()
        ..sort();

  /// Returns a list of all yearly reports that are already reported for this company
  List<FinancialStatement> get yearReports =>
      yearlyResults.values.map((e) => e.yearReport).expand((element) => element).toList()
        ..sort();

  const CompanyResults({
    required this.yearlyResults,
  });

  /// Creates a CompanyResults object from the json object that comes from the SEC
  factory CompanyResults.fromJsonList(Map<String, dynamic> companyFactsJson) {
    final Map<String, dynamic> factsNode = companyFactsJson['facts'] as Map<String, dynamic>;
    final Map<String, dynamic> facts = _getFacts(factsNode);

    Map<int, YearlyResults> yearlyResults = {};

    try {
      yearlyResults = PeriodProcessor.process(facts);

      YearlyResultsValidator().validate(yearlyResults);
    } catch (e) {
      debugPrint('Error while processing company results: $e');
    }
    return CompanyResults(
      yearlyResults: yearlyResults,
    );
  }

  /// Returns the facts node that has the most data
  static Map<String, dynamic> _getFacts(Map<String, dynamic> factsNode) {
    int usGaapCount = 0;
    int ifrsFullCount = 0;

    if (factsNode.containsKey('us-gaap')) {
      usGaapCount = (factsNode['us-gaap'] as Map<String, dynamic>).length;
    }
    if (factsNode.containsKey('ifrs-full')) {
      ifrsFullCount = (factsNode['ifrs-full'] as Map<String, dynamic>).length;
    }

    if (usGaapCount > ifrsFullCount) {
      return factsNode['us-gaap'] as Map<String, dynamic>;
    } else {
      return factsNode['ifrs-full'] as Map<String, dynamic>;
    }
  }

  factory CompanyResults.empty() =>
      const CompanyResults(
        yearlyResults: {},
      );

  @override
  String toString() {
    final StringBuffer result = StringBuffer();

    for (final year in yearlyResults.keys) {
      result.write('\nYear: $year\n');
      result.write(yearlyResults[year]!.toString());
    }

    return result.toString();
  }
}
