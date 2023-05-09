import 'package:flutter_edgar_sec/src/model/enums/financial_statment_period.dart';
import 'package:flutter_edgar_sec/src/model/financials/balance_sheet.dart';
import 'package:flutter_edgar_sec/src/model/financials/cash_flow_statement.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/processor/balance_sheet_processor.dart';
import 'package:flutter_edgar_sec/src/processor/cash_flow_processor.dart';
import 'package:flutter_edgar_sec/src/processor/income_statement_processor.dart';
import 'package:flutter_edgar_sec/src/processor/utils/base_processor.dart';

/// Logic related to process 10-Q and 10-K financial statements
class PeriodProcessor {
  /// Returns a map of quarters and a map of annual financial statements for a given symbol
  static Map<int, YearlyResults> process(Map<String, dynamic> facts) {
    const String referenceField = 'NetIncomeLoss';
    final Map<String, dynamic> referenceFieldMap = facts[referenceField] as Map<String, dynamic>;
    final Map<String, dynamic> coinsMap = referenceFieldMap['units'] as Map<String, dynamic>;
    final referenceUnits = coinsMap['USD'] as List;

    // Create the quarter and annual data indexes
    final Map<String, FinancialStatement> quarters = {};
    final Map<String, FinancialStatement> annuals = {};

    final quartersRawData = <Map<String, dynamic>>[];
    for (final period in referenceUnits) {
      if (period is! Map<String, dynamic>) {
        continue;
      }

      // Validate if the reports have the right amount of time between start and end dates
      if (!BaseProcessor.validPeriod(period)) {
        continue;
      }

      final startDateString = period['start'] as String;
      final endDateString = period['end'] as String;
      final filedDateString = period['filed'] as String;

      // Parse date from string with format yyyy-MM-dd
      final DateTime endDate = DateTime.parse(endDateString);
      final DateTime startDate = DateTime.parse(startDateString);
      final filedDate = DateTime.parse(filedDateString);

      if (BaseProcessor.calculateIsQuarterReport(period)) {
        final financialStatement = FinancialStatement(
          startDate: startDate,
          endDate: endDate,
          filedDate: filedDate,
          period: FinancialStatementPeriod.quarterly,
          incomeStatement: IncomeStatement(),
          balanceSheet: BalanceSheet(),
          cashFlowStatement: CashFlowStatement(),
        );

        quarters[endDateString] = financialStatement;
        quartersRawData.add(period);
      } else if (BaseProcessor.calculateIsAnnualReport(period)) {
        final financialStatement = FinancialStatement(
          startDate: startDate,
          endDate: endDate,
          filedDate: filedDate,
          period: FinancialStatementPeriod.annual,
          incomeStatement: IncomeStatement(),
          balanceSheet: BalanceSheet(),
          cashFlowStatement: CashFlowStatement(),
        );

        // fill an annual data structure
        annuals[endDateString] = financialStatement;
      }
    }

    // these should be changed to quarters and annual
    // so we can iterate only 1 time
    IncomeStatementProcessor.process(facts, quarters, FinancialStatementPeriod.quarterly);
    BalanceSheetProcessor.process(facts, quarters, FinancialStatementPeriod.quarterly);
    CashFlowProcessor.process(facts, quarters, FinancialStatementPeriod.quarterly);

    // Process the annuals
    IncomeStatementProcessor.process(facts, annuals, FinancialStatementPeriod.annual);
    BalanceSheetProcessor.process(facts, annuals, FinancialStatementPeriod.annual);
    CashFlowProcessor.process(facts, annuals, FinancialStatementPeriod.annual);

    // might not be needed
    //final Map<String, FinancialStatement> annual = YearProcessor.process(facts);

    // Get all the years available
    final Map<int, YearlyResults> yearlyResults = {};
    PeriodProcessor._distributeByQuarter(quarters, yearlyResults);
    PeriodProcessor.distributeByYear(annuals, yearlyResults);

    return yearlyResults;
  }

  /// Distributes the quarters into the yearly results
  static void _distributeByQuarter(
      Map<String, FinancialStatement> quarterStatements, Map<int, YearlyResults> yearlyResults) {
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

  static void distributeByYear(Map<String, FinancialStatement> annuals, Map<int, YearlyResults> yearlyResults) {
    for (final annualStatement in annuals.values) {
      final int year = annualStatement.year;

      if (!yearlyResults.containsKey(year)) {
        yearlyResults[year] = YearlyResults();
      }

      yearlyResults[year]!.fullYear = annualStatement;
    }
  }
}
