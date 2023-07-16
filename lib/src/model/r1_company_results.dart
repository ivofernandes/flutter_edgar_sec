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
      yearlyResults.values.map((e) => e.quarters).expand((element) => element).toList()..sort();

  /// Returns a list of all yearly reports that are already reported for this company
  List<FinancialStatement> get yearReports =>
      yearlyResults.values.map((e) => e.yearReport).expand((element) => element).toList()..sort();

  const CompanyResults({
    required this.yearlyResults,
  });

  /// Creates a CompanyResults object from the json object that comes from the SEC
  static Future<CompanyResults> fromJsonList(Map<String, dynamic> companyFactsJson) async {
    try {
      const List<String> referenceFields = [
        'NetIncomeLoss',
        'ProfitLoss',
      ];
      final Map<String, dynamic> factsNode = companyFactsJson['facts'] as Map<String, dynamic>;

      Map<String, dynamic> usGaapFacts = {};
      if (factsNode.containsKey('us-gaap')) {
        usGaapFacts = factsNode['us-gaap'] as Map<String, dynamic>;
      }
      Map<String, dynamic> ifrsFullFacts = {};
      if (factsNode.containsKey('ifrs-full')) {
        ifrsFullFacts = factsNode['ifrs-full'] as Map<String, dynamic>;
      }

      Map<int, YearlyResults> yearlyResults = {};

      try {
        yearlyResults = await PeriodProcessor.process(usGaapFacts, ifrsFullFacts, referenceFields);

        YearlyResultsValidator().validate(yearlyResults);
      } catch (e) {
        debugPrint('Error while processing company results: $e');
      }
      return CompanyResults(
        yearlyResults: yearlyResults,
      );
    } catch (e) {
      debugPrint('Error while processing company results: $e');
      rethrow;
    }
  }

  factory CompanyResults.empty() => const CompanyResults(
        yearlyResults: {},
      );

  /// Creates a CompanyResults object from the json object that comes from the storage
  /// This method is used to create a CompanyResults object from the storage
  factory CompanyResults.fromJsonStorage(Map<String, dynamic> jsonData) {
    final Map<int, YearlyResults> yearlyResults = (jsonData['yearlyResults'] as Map<String, dynamic>).map(
      (key, value) => MapEntry(
        int.parse(key),
        YearlyResults.fromJson(value as Map<String, dynamic>),
      ),
    );

    return CompanyResults(yearlyResults: yearlyResults);
  }

  /// Returns a json object that can be stored in the storage
  /// This method is used to create a json object that can be stored in the storage
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};

    jsonData['yearlyResults'] = yearlyResults.map((key, value) => MapEntry(key.toString(), value.toJson()));

    return jsonData;
  }

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
