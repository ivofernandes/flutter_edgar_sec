import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/processor/quarters/period_processor.dart';

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
      yearlyResults.values.map((e) => e.quarters).expand((element) => element).toList();

  const CompanyResults({
    required this.yearlyResults,
  });

  factory CompanyResults.fromJsonList(Map<String, dynamic> companyFactsJson) {
    final Map<String, dynamic> factsNode = companyFactsJson['facts'] as Map<String, dynamic>;
    final Map<String, dynamic> facts = factsNode['us-gaap'] as Map<String, dynamic>;

    final Map<int, YearlyResults> yearlyResults = PeriodProcessor.process(facts);

    return CompanyResults(
      yearlyResults: yearlyResults,
    );
  }

  static CompanyResults empty() => const CompanyResults(
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
