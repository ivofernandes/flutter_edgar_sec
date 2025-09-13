import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';

abstract class DistributeStatements {
  /// Distributes the quarters into the yearly results
  static void distributeByQuarter(
      Map<String, FinancialStatement> quarterStatements,
      Map<int, YearlyResults> yearlyResults) {
    for (final quarterStatement in quarterStatements.values) {
      final int year = quarterStatement.year;

      if (!yearlyResults.containsKey(year)) {
        yearlyResults[year] = YearlyResults();
      }

      final int quarterNum = quarterStatement.quarter;
      switch (quarterNum) {
        case 1:
          yearlyResults[year]!.q1 = quarterStatement;
          break;
        case 2:
          yearlyResults[year]!.q2 = quarterStatement;
          break;
        case 3:
          yearlyResults[year]!.q3 = quarterStatement;
          break;
        case 4:
          yearlyResults[year]!.q4 = quarterStatement;
          break;
      }
    }
  }

  static void distributeByYear(Map<String, FinancialStatement> annuals,
      Map<int, YearlyResults> yearlyResults) {
    for (final annualStatement in annuals.values) {
      final int year = annualStatement.year;

      if (!yearlyResults.containsKey(year)) {
        yearlyResults[year] = YearlyResults();
      }

      yearlyResults[year]!.fullYear = annualStatement;
    }
  }
}
