import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';

mixin ValidateAnnualReport {
  static void validate(YearlyResults yearlyResult) {
    final IncomeStatement fullYearIncome =
        yearlyResult.fullYear!.incomeStatement;
    final IncomeStatement q1Income = yearlyResult.q1!.incomeStatement;
    final IncomeStatement q2Income = yearlyResult.q2!.incomeStatement;
    final IncomeStatement q3Income = yearlyResult.q3!.incomeStatement;
    final IncomeStatement q4Income = yearlyResult.q4!.incomeStatement;

    final calculatedYearRevenues = q1Income.revenues +
        q2Income.revenues +
        q3Income.revenues +
        q4Income.revenues;

    if (fullYearIncome.revenues != calculatedYearRevenues) {
      debugPrint(
          '${yearlyResult.fullYear!.year} Yearly revenues do not match the sum of the quarterly revenues');
    }
  }
}
