import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/processor/validator/mixins/validate_annual_report.dart';

/// Most companies just report the full year data on a specific trimester,
/// and in the full year report, they just report the full year data.
/// And not the quarterly data. That's why we need this logic to extrapolate the data
mixin MissingQuarterValidator {
  void validateMissingQuarter(Map<int, YearlyResults> yearlyResults) {
    final List<int> years = yearlyResults.keys.toList();

    for (final int year in years) {
      final YearlyResults yearlyResult = yearlyResults[year]!;

      // Check if the year has full year data, and is missing just the q4
      final bool hasFullYear = yearlyResult.fullYear != null;
      final bool hasQ1 = yearlyResult.q1 != null;
      final bool hasQ2 = yearlyResult.q2 != null;
      final bool hasQ3 = yearlyResult.q3 != null;
      final bool hasQ4 = yearlyResult.q4 != null;

      if (hasFullYear && hasQ1 && hasQ2 && hasQ3 && hasQ4) {
        ValidateAnnualReport.validate(yearlyResult);
      }
      if (hasFullYear && hasQ1 && hasQ2 && hasQ3 && !hasQ4) {
        extrapolateQ4(yearlyResult);
      } else if (hasFullYear && !hasQ1 && hasQ2 && hasQ3 && hasQ4) {
        extrapolateQ1(yearlyResult);
      } else if (hasFullYear && hasQ1 && !hasQ2 && hasQ3 && hasQ4) {
        extrapolateQ2(yearlyResult);
      } else if (hasFullYear && hasQ1 && hasQ2 && !hasQ3 && hasQ4) {
        extrapolateQ3(yearlyResult);
      }
    }
  }

  void extrapolateQ1(YearlyResults yearlyResult) {
    yearlyResult.q1 = FinancialStatement.extrapolate(
      yearlyResult.fullYear!.startDate,
      yearlyResult.q2!.startDate,
      yearlyResult.fullYear!,
      yearlyResult.q2!,
      yearlyResult.q3!,
      yearlyResult.q4!,
    );
  }

  void extrapolateQ2(YearlyResults yearlyResult) {
    yearlyResult.q2 = FinancialStatement.extrapolate(
      yearlyResult.q1!.endDate,
      yearlyResult.q3!.startDate,
      yearlyResult.fullYear!,
      yearlyResult.q1!,
      yearlyResult.q3!,
      yearlyResult.q4!,
    );
  }

  void extrapolateQ3(YearlyResults yearlyResult) {
    yearlyResult.q3 = FinancialStatement.extrapolate(
      yearlyResult.q2!.endDate,
      yearlyResult.q4!.startDate,
      yearlyResult.fullYear!,
      yearlyResult.q1!,
      yearlyResult.q2!,
      yearlyResult.q4!,
    );
  }

  void extrapolateQ4(YearlyResults yearlyResult) {
    yearlyResult.q4 = FinancialStatement.extrapolate(
      yearlyResult.q3!.endDate,
      yearlyResult.fullYear!.endDate,
      yearlyResult.fullYear!,
      yearlyResult.q1!,
      yearlyResult.q2!,
      yearlyResult.q3!,
    );
  }
}
