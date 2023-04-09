import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:intl/intl.dart';

/// Stuff generic to all processors
class BaseProcessor {
  /// Filter the quarters, i.e. rows that are 10-Q
  static List<Map<String, dynamic>> getRows(
    Map<String, dynamic> facts,
    String field,
    Map<String, FinancialStatement> index, {
    String typeOfForm = '10-Q',
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

    if (!getFactsUnits.containsKey('USD')) {
      return [];
    }

    final List<dynamic> units = getFactsUnits['USD'] as List<dynamic>;

    return _getValidPeriods(units, index, typeOfForm);
  }

  /// Validate and finalize periods
  static List<Map<String, dynamic>> _getValidPeriods(
    List<dynamic> units,
    Map<String, FinancialStatement> index,
    String typeOfForm,
  ) {
    final List<Map<String, dynamic>> periods = [];

    for (final period in units) {
      if (period is! Map) {
        continue;
      }

      if (period['form'] == typeOfForm) {
        final String endDateString = period['end'] as String;

        // Ignore not mapped fields
        if (!index.containsKey(endDateString)) {
          continue;
        }

        if (!validPeriod(period as Map<String, dynamic>)) {
          continue;
        }

        periods.add(period);
      }
    }

    return _finallizePeriods(periods);
  }

  /// Prepare the periods to be processed, avoid duplicated periods
  static List<Map<String, dynamic>> _finallizePeriods(List<Map<String, dynamic>> periods) {
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
    if (period['form'] == '10-Q' && period.containsKey('start')) {
      final DateTime startDate = dateFormat.parse(period['start'] as String);
      final DateTime endDate = dateFormat.parse(period['end'] as String);

      final Duration duration = endDate.difference(startDate);

      final days = duration.inDays;
      if (days > 100) {
        return false;
      }
    }

    return true;
  }
}
