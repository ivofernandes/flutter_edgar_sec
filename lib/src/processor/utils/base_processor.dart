import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';

/// Stuff generic to all processors
class BaseProcessor {

  /// Filter the quarters, i.e. rows that are 10-Q
  static List<dynamic> getRows(Map<String, dynamic> facts,
      String field,
      Map<String, FinancialStatement> index, {
        String typeOfForm = '10-Q',
      }) {
    final List<dynamic> quarters = [];

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

    final units = getFactsUnits['USD'] as List;

    for (final row in units) {
      if (row['form'] == typeOfForm) {
        final endDateString = row['end'];

        // Ignore not mapped fields
        if (!index.containsKey(endDateString)) {
          continue;
        }

        quarters.add(row);
      }
    }

    return quarters;
  }
}
