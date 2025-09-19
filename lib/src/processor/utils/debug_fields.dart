import 'package:flutter_edgar_sec/src/model/enums/financial_statment_period.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/utils/app_logger.dart';

class DebugFields {
  static void debugFields(
    Map<String, dynamic> facts,
    Map<String, FinancialStatement> index,
    FinancialStatementPeriod typeOfForm,
    Set<String> supportedFields,
  ) {
    final List<String> fields = facts.keys.toList();

    final int currentYear = DateTime.now().year;

    final Map<String, num> fieldToCurrentValue = {};

    for (final String field in fields) {
      final Map<String, dynamic> fieldFacts =
          facts[field] as Map<String, dynamic>;
      final Map<String, dynamic> fieldUnits =
          fieldFacts['units'] as Map<String, dynamic>;
      final String unit = fieldUnits.keys.first;
      final List<dynamic> reports = fieldUnits[unit] as List<dynamic>;
      final Map<String, dynamic> lastReport =
          reports.last as Map<String, dynamic>;

      final String lastDate = lastReport['end'] as String;
      final int lastYear = DateTime.parse(lastDate).year;
      if (lastYear < currentYear - 1) {
        continue;
      }

      fieldToCurrentValue[field] = lastReport['val'] as num;
    }

    final Map<String, num> fieldToBillions =
        fieldToCurrentValue.map((key, value) => MapEntry(key, value / (1000 * 1000 * 1000)));

    final Map<String, num> fieldOverOneBillion = Map.from(fieldToBillions);
    fieldOverOneBillion.removeWhere((key, value) => value < 1);

    AppLogger().debug('fieldsFacts');
  }
}
