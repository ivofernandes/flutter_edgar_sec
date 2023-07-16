import 'package:flutter_edgar_sec/src/model/enums/financial_statment_period.dart';
import 'package:flutter_edgar_sec/src/model/financials/balance_sheet.dart';
import 'package:flutter_edgar_sec/src/model/financials/cash_flow_statement.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r3_financial_statement.dart';
import 'package:flutter_edgar_sec/src/processor/balance_sheet_processor.dart';
import 'package:flutter_edgar_sec/src/processor/cash_flow_processor.dart';
import 'package:flutter_edgar_sec/src/processor/forex/forex_conversion_service.dart';
import 'package:flutter_edgar_sec/src/processor/income_statement_processor.dart';
import 'package:flutter_edgar_sec/src/processor/utils/base_processor.dart';

abstract class FactGroupProcessor {
  static Future<void> processFactsGroup(Map<String, FinancialStatement> quarters,
      Map<String, FinancialStatement> annuals, Map<String, dynamic> facts, List<String> referenceFields) async {
    String referenceField = referenceFields.first;
    for (int i = 0; i < referenceFields.length; i++) {
      if (facts.containsKey(referenceFields[i])) {
        referenceField = referenceFields[i];
        break;
      }
    }

    // We might only have us-gaap or ifrs-full and need to abort for the type of facts we don't have
    if (!facts.containsKey(referenceField)) {
      return;
    }
    final Map<String, dynamic> referenceFieldMap = facts[referenceField] as Map<String, dynamic>;
    Map<String, dynamic> coinsMap = referenceFieldMap['units'] as Map<String, dynamic>;
    coinsMap = await ForexConversionService().convertToUSD(coinsMap);

    final referenceUnits = coinsMap['USD'] as List;

    final quartersRawData = <Map<String, dynamic>>[];
    for (final period in referenceUnits) {
      if (period is! Map<String, dynamic>) {
        continue;
      }

      // Validate if the reports have the right amount of time between start and end dates
      if (!BaseProcessor.validPeriod(period)) {
        continue;
      }

      _processPeriod(quarters, annuals, quartersRawData, period);
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
  }

  static void _processPeriod(Map<String, FinancialStatement> quarters, Map<String, FinancialStatement> annuals,
      List<Map<String, dynamic>> quartersRawData, Map<String, dynamic> period) {
    final startDateString = period['start'] as String;
    final endDateString = period['end'] as String;
    final filedDateString = period['filed'] as String;

    // Parse date from string with format yyyy-MM-dd
    final DateTime endDate = DateTime.parse(endDateString);
    final DateTime startDate = DateTime.parse(startDateString);
    final filedDate = DateTime.parse(filedDateString);
    if (BaseProcessor.calculateIsQuarterReport(period)) {
      final financialStatement = _createFinancialStatement(
        startDate,
        endDate,
        filedDate,
        FinancialStatementPeriod.quarterly,
      );

      quarters[endDateString] = financialStatement;
      quartersRawData.add(period);
    } else if (BaseProcessor.calculateIsAnnualReport(period)) {
      final financialStatement = _createFinancialStatement(
        startDate,
        endDate,
        filedDate,
        FinancialStatementPeriod.annual,
      );

      annuals[endDateString] = financialStatement;
    }
  }

  static FinancialStatement _createFinancialStatement(DateTime startDate,
      DateTime endDate,
      DateTime filedDate,
      FinancialStatementPeriod period,) =>
      FinancialStatement(
        startDate: startDate,
        endDate: endDate,
        filedDate: filedDate,
        period: period,
        incomeStatement: IncomeStatement(),
        balanceSheet: BalanceSheet(),
        cashFlowStatement: CashFlowStatement(),
      );
}
