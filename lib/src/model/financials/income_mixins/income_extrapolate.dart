import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';

mixin IncomeExtrapolate {
  static void fillMissingQuarter(
    IncomeStatement incomeStatement,
    IncomeStatement fullYear,
    IncomeStatement qa,
    IncomeStatement qb,
    IncomeStatement qc,
  ) {
    incomeStatement.revenues = fullYear.revenues - qc.revenues - qb.revenues - qa.revenues;
    incomeStatement.costOfRevenues =
        fullYear.costOfRevenues - qc.costOfRevenues - qb.costOfRevenues - qa.costOfRevenues;
    incomeStatement.operatingIncome =
        fullYear.operatingIncome - qc.operatingIncome - qb.operatingIncome - qa.operatingIncome;
    incomeStatement.grossProfit = fullYear.grossProfit - qc.grossProfit - qb.grossProfit - qa.grossProfit;
    incomeStatement.researchAndDevelopmentExpenses = fullYear.researchAndDevelopmentExpenses -
        qc.researchAndDevelopmentExpenses -
        qb.researchAndDevelopmentExpenses -
        qa.researchAndDevelopmentExpenses;
    incomeStatement.generalAndAdministrativeExpenses = fullYear.generalAndAdministrativeExpenses -
        qc.generalAndAdministrativeExpenses -
        qb.generalAndAdministrativeExpenses -
        qa.generalAndAdministrativeExpenses;
    incomeStatement.otherNonOperatingIncomeExpense = fullYear.otherNonOperatingIncomeExpense -
        qc.otherNonOperatingIncomeExpense -
        qb.otherNonOperatingIncomeExpense -
        qa.otherNonOperatingIncomeExpense;

    incomeStatement.foreignCurrencyExchange = fullYear.foreignCurrencyExchange -
        qc.foreignCurrencyExchange -
        qb.foreignCurrencyExchange -
        qa.foreignCurrencyExchange;
    incomeStatement.interestExpenses =
        fullYear.interestExpenses - qc.interestExpenses - qb.interestExpenses - qa.interestExpenses;
    incomeStatement.netIncome = fullYear.netIncome - qc.netIncome - qb.netIncome - qa.netIncome;
    incomeStatement.incomeTaxExpense =
        fullYear.incomeTaxExpense - qc.incomeTaxExpense - qb.incomeTaxExpense - qa.incomeTaxExpense;
  }
}
