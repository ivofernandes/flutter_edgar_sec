import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/processor/validator/financials/income_statment_validator.dart';
import 'package:flutter_edgar_sec/src/processor/validator/mixins/missing_quarter_validator.dart';
import 'package:flutter_edgar_sec/src/processor/validator/mixins/validate_annual_report.dart';

/// Class that validates the raw data from SEC and do further processing to extrapolate missing data
class YearlyResultsValidator
    with MissingQuarterValidator, ValidateAnnualReport {
  // Singleton
  static final YearlyResultsValidator _instance =
      YearlyResultsValidator._internal();

  factory YearlyResultsValidator() => _instance;

  YearlyResultsValidator._internal();

  /// Validates the data from SEC
  void validate(Map<int, YearlyResults> yearlyResults) {
    for (final year in yearlyResults.keys) {
      if (year == 2022) {
        debugPrint('year: $year');
      }
      final YearlyResults yearlyResult = yearlyResults[year]!;

      validateMissingQuarter(yearlyResults);

      final List<FinancialStatement> quarters = yearlyResult.quarters;
      final List<FinancialStatement> yearReport = yearlyResult.yearReport;

      /// Validate the year report
      for (final quarterlyReport in quarters) {
        IncomeStatementValidator.validate(quarterlyReport.incomeStatement);
      }

      /// Validate the year report
      for (final yearlyReport in yearReport) {
        IncomeStatementValidator.validate(yearlyReport.incomeStatement);
      }
    }
  }
}
