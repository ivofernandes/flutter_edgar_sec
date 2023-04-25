import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';

class MissingQuarterValidator {
  // Singleton
  static final MissingQuarterValidator _singleton = MissingQuarterValidator._internal();

  factory MissingQuarterValidator() => _singleton;

  MissingQuarterValidator._internal();

  void validate(Map<int, YearlyResults> yearlyResults) {
    final List<int> years = yearlyResults.keys.toList();

    for (final int year in years) {
      final YearlyResults yearlyResult = yearlyResults[year]!;

      // Check if the year has full year data, and is missing just the q4
      final bool hasFullYear = yearlyResult.fullYear != null;
      final bool hasQ1 = yearlyResult.q1 != null;
      final bool hasQ2 = yearlyResult.q2 != null;
      final bool hasQ3 = yearlyResult.q3 != null;
      final bool hasNoQ4 = yearlyResult.q4 == null;

      if (hasFullYear && hasQ1 && hasQ2 && hasQ3 && hasNoQ4) {
        extrapolateQ4(yearlyResult);
      }
    }
  }

  void extrapolateQ4(YearlyResults yearlyResult) {
    yearlyResult.q4 = FinancialStatement.extrapolate(
      yearlyResult.fullYear!,
      yearlyResult.q1!,
      yearlyResult.q2!,
      yearlyResult.q3!,
    );
  }
}
