import 'package:flutter_edgar_sec/src/model/balance_sheet.dart';
import 'package:flutter_edgar_sec/src/model/cash_flow_statement.dart';
import 'package:flutter_edgar_sec/src/model/financial_statment_period.dart';
import 'package:flutter_edgar_sec/src/model/income_statement.dart';
import 'package:flutter_edgar_sec/src/processor/balance_sheet_processor.dart';
import 'package:flutter_edgar_sec/src/processor/cash_flow_processor.dart';
import 'package:flutter_edgar_sec/src/processor/income_statement_processor.dart';

class FinancialStatement{

  final DateTime date;

  int get year => date.year;
  int get month => date.month;

  final FinancialStatementPeriod period;

  final IncomeStatement incomeStatement;
  final BalanceSheet balanceSheet;
  final CashFlowStatement cashFlowStatement;

  FinancialStatement({
    required this.date,
    required this.period,
    required this.incomeStatement,
    required this.balanceSheet,
    required this.cashFlowStatement,
  });

  String get incomeStatementString => incomeStatement.toString();

  @override
  String toString() {
    return 'date: $year-$month\n incomeStatementString:\n$incomeStatementString';
  }

  static List<FinancialStatement> fromJsonList(companyFactsJson) {

    final Map<String, dynamic> facts = companyFactsJson['facts']['us-gaap'] as Map<String, dynamic>;

    const String referenceField = 'AssetsCurrent';

    final referenceUnits = facts[referenceField]['units']['USD'] as List;

    final Map<String, FinancialStatement> index = {};
    for(final row in referenceUnits){
      if(row['form'] == '10-Q'){
        final endDateString = row['end'] as String;
        // Parse date from string with format yyyy-MM-dd
        final endDate = DateTime.parse(endDateString);

        final financialStatement = FinancialStatement(
          date: endDate,
          period: FinancialStatementPeriod.quarterly,
          incomeStatement: IncomeStatement(),
          balanceSheet: BalanceSheet(),
          cashFlowStatement: CashFlowStatement(),

        );

        index[endDateString] = financialStatement;
      }else{
        //TODO annual
      }
    }

    IncomeStatementProcessor.process(facts, index);
    BalanceSheetProcessor.process(facts, index);
    CashFlowProcessor.process(facts, index);

    return index.values.toList();
  }
}
