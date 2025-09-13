import 'package:flutter_edgar_sec/src/model/enums/financial_statment_period.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:intl/intl.dart';

/// Stuff generic to all processors
class BaseProcessor {
  /// Filter the quarters, i.e. rows that are 10-Q
  static List<Map<String, dynamic>> getRows(
    Map<String, dynamic> facts,
    String field,
    Map<String, FinancialStatement> index, {
    FinancialStatementPeriod typeOfForm = FinancialStatementPeriod.quarterly,
  }) {
    // Ignore not mapped fields
    if (!facts.containsKey(field)) {
      return [];
    }

    // Get all units of 10-Q or 10-K
    final factsField = facts[field];
    if (factsField == null || factsField is! Map) {
      return [];
    }

    final getFactsUnits = factsField['units'];
    if (getFactsUnits == null || getFactsUnits is! Map) {
      return [];
    }

    final List<String> factsUnitsKeys = [
      'USD',
      'USD/shares',
      'shares',
    ];
    for (final key in factsUnitsKeys) {
      if (getFactsUnits.containsKey(key)) {
        final List<dynamic> units = getFactsUnits[key] as List<dynamic>;
        return _getValidPeriods(units, index, typeOfForm);
      }
    }

    return [];
  }

  /// Validate and finalize periods
  static List<Map<String, dynamic>> _getValidPeriods(
    List<dynamic> units,
    Map<String, FinancialStatement> index,
    FinancialStatementPeriod typeOfForm,
  ) {
    final List<Map<String, dynamic>> periods = [];

    for (final period in units) {
      if (period is! Map<String, dynamic>) {
        continue;
      }

      bool isValidPeriod = false;
      if (typeOfForm == FinancialStatementPeriod.quarterly) {
        isValidPeriod = calculateIsQuarterReport(period);
      } else if (typeOfForm == FinancialStatementPeriod.annual) {
        isValidPeriod = calculateIsAnnualReport(period);
      }

      if (isValidPeriod) {
        final String endDateString = period['end'] as String;

        // Ignore not mapped fields
        if (!index.containsKey(endDateString)) {
          continue;
        }

        if (!validPeriod(period)) {
          continue;
        }

        periods.add(period);
      }
    }

    return _finallizePeriods(periods);
  }

  /// Prepare the periods to be processed, avoid duplicated periods
  static List<Map<String, dynamic>> _finallizePeriods(
      List<Map<String, dynamic>> periods) {
    // Reverse so the last periods are processed first
    final periodsReversed = periods.reversed.toList();

    final List<Map<String, dynamic>> filteredPeriods = [];
    // Avoid duplicated fields
    final Set<String> processed = {};
    for (final period in periodsReversed) {
      final key = '${period['fy']}_${period['fp']}';

      if (processed.contains(key)) {
        continue;
      }

      processed.add(key);

      filteredPeriods.add(period);
    }

    return periodsReversed;
  }

  /// Check if the period is valid
  /// There are a lot of periods of 10-Q like 6 months or 9 months that we don't really want to process
  static bool validPeriod(Map<String, dynamic> period) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    if (!period.containsKey('start')) {
      return true;
    }

    final DateTime startDate = dateFormat.parse(period['start'] as String);
    final DateTime endDate = dateFormat.parse(period['end'] as String);

    final Duration duration = endDate.difference(startDate);
    final days = duration.inDays;

    final bool isQuarter = days > 20 && days < 100;
    final bool isYear = days > 300 && days < 400;

    // Report type
    final bool isQuarterReport = calculateIsQuarterReport(period);
    final bool isAnnualReport = calculateIsAnnualReport(period);

    // Invalidate 10-Q that are not 3 months
    if (isQuarterReport && !isQuarter) {
      return false;
    }

    if (isAnnualReport && !isYear) {
      // Invalidate 10-K that are not 12 months
      return false;
    }

    return true;
  }

  /// Calculate if the report is a quarter report
  static bool calculateIsQuarterReport(Map<String, dynamic> period) {
    final bool is10Q = period['form'] == '10-Q';
    final bool is6K = period['form'] == '6-K';
    return is10Q || is6K;
  }

  /// Calculate if the report is an annual report
  static bool calculateIsAnnualReport(Map<String, dynamic> period) {
    final bool is10K = period['form'] == '10-K';
    final bool is40F = period['form'] == '40-F';
    final bool is20F = period['form'] == '20-F';

    return is10K || is20F || is40F;
  }
}
