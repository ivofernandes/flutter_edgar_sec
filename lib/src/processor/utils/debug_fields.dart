import 'dart:convert';

import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/utils/app_logger.dart';

class DebugFields {
  static void debugFields(Map<String, dynamic> facts, Map<String, FinancialStatement> index, String typeOfForm,
      Set<String> supportedFields) {
    final List<String> fields = facts.keys.toList();

    final fieldsFacts = json.encode(fields);

    AppLogger().debug('fieldsFacts');
  }
}
