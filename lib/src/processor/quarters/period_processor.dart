import 'package:flutter_edgar_sec/src/model/enums/financial_statment_period.dart';
import 'package:flutter_edgar_sec/src/model/financials/balance_sheet.dart';
import 'package:flutter_edgar_sec/src/model/financials/cash_flow_statement.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/processor/balance_sheet_processor.dart';
import 'package:flutter_edgar_sec/src/processor/cash_flow_processor.dart';
import 'package:flutter_edgar_sec/src/processor/income_statement_processor.dart';

/// Logic related to process 10-Q and 10-K financial statements
class PeriodProcessor {
  /// Returns a map of quarters and a map of annual financial statements for a given symbol
  static Map<String, FinancialStatement> process(Map<String, dynamic> facts) {
    const String referenceField = 'AssetsCurrent';
    final referenceUnits = facts[referenceField]['units']['USD'] as List;
    final Map<String, FinancialStatement> quarters = {};
    final Map<String, FinancialStatement> annuals = {};
    for (final row in referenceUnits) {

      final endDateString = row['end'] as String;
      // Parse date from string with format yyyy-MM-dd
      final endDate = DateTime.parse(endDateString);

      if (row['form'] == '10-Q') {
        final financialStatement = FinancialStatement(
          date: endDate,
          period: FinancialStatementPeriod.quarterly,
          incomeStatement: IncomeStatement(),
          balanceSheet: BalanceSheet(),
          cashFlowStatement: CashFlowStatement(),
        );

        quarters[endDateString] = financialStatement;
      } else if (row['form'] == '10-K') {
        final financialStatement = FinancialStatement(
          date: endDate,
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
    IncomeStatementProcessor.process(facts, quarters);
    BalanceSheetProcessor.process(facts, quarters);
    CashFlowProcessor.process(facts, quarters);

    return quarters;
  }

  /// Distributes the quarters into the yearly results
  static void distributeByQuarter(Map<String, FinancialStatement> quarterStatements, Map<int, YearlyResults> yearlyResults) {
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
}
