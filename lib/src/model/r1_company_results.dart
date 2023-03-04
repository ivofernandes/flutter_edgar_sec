import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/processor/quarters/period_processor.dart';

class CompanyResults {
  final Map<int, YearlyResults> yearlyResults;

  const CompanyResults({
    required this.yearlyResults,
  });

  List<int> get years => yearlyResults.keys.toList();

  factory CompanyResults.fromJsonList(Map<String, dynamic> companyFactsJson) {
    final Map<String, dynamic> facts = companyFactsJson['facts']['us-gaap'] as Map<String, dynamic>;

    final Map<String, FinancialStatement> quarters = PeriodProcessor.process(facts);

    // might not be needed
    //final Map<String, FinancialStatement> annual = YearProcessor.process(facts);

    // Get all the years available
    final Map<int, YearlyResults> yearlyResults = {};
    PeriodProcessor.distributeByQuarter(quarters, yearlyResults);

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
