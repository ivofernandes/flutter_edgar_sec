import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';

class YearlyResults {

  /// The report for the  first quarter of the year
  FinancialStatement? q1;

  /// The report for the  second quarter of the year
  FinancialStatement? q2;

  /// The report for the  third quarter of the year
  FinancialStatement? q3;

  /// The report for the fourth quarter of the year
  FinancialStatement? q4;

  /// The report for the full year
  FinancialStatement? fullYear;

  /// Constructor
  YearlyResults({
    this.q1,
    this.q2,
    this.q3,
    this.q4,
    this.fullYear,
  });

  /// Returns a list of all the quarters that are already reported
  List<FinancialStatement> get quarters {
    final List<FinancialStatement> result = [];
    if (q1 != null) {
      result.add(q1!);
    }
    if (q2 != null) {
      result.add(q2!);
    }
    if (q3 != null) {
      result.add(q3!);
    }
    if (q4 != null) {
      result.add(q4!);
    }
    return result;
  }

  /// Returns a list of all yearly reports that are already reported
  List<FinancialStatement> get yearReport {
    final List<FinancialStatement> result = [];
    if (fullYear != null) {
      result.add(fullYear!);
    }
    return result;
  }
  
  @override
  String toString() => '''
    q1: $q1\n
    q2: $q2\n
    q3: $q3\n
    q4: $q4\n
    fullYear: $fullYear\n
    ''';
}
