import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';

class YearlyResults {
  FinancialStatement? q1;
  FinancialStatement? q2;
  FinancialStatement? q3;
  FinancialStatement? q4;

  FinancialStatement? fullYear;

  YearlyResults({
    this.q1,
    this.q2,
    this.q3,
    this.q4,
    this.fullYear,
  });

  @override
  String toString() => '''
    q1: $q1\n
    q2: $q2\n
    q3: $q3\n
    q4: $q4\n
    fullYear: $fullYear\n
    ''';
}
