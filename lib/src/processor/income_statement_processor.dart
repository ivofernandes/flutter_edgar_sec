import 'package:flutter_edgar_sec/src/model/financial_statement.dart';
import 'package:flutter_edgar_sec/src/model/income_statement.dart';

/// Processes the income statement from the json response
/// https://seekingalpha.com/symbol/AAPL/income-statement
///
/// To add a new field we need to add it to the supportedFields list and add a new case to the _mapValue method
class IncomeStatementProcessor{
  static void process(Map<String,dynamic> facts, Map<String, FinancialStatement> index) {

    final List<String> supportedFields = ['RevenueFromContractWithCustomerExcludingAssessedTax'];

    for(final field in supportedFields){
      final units = facts[field]['units']['USD'] as List;

      for(final row in units){
        if(row['form'] == '10-Q'){
          final endDateString = row['end'];

          // Ignore not mapped fields
          if(!index.containsKey(endDateString)){
            continue;
          }

          final value = row['val'] as num;

          final financialStatement = index[endDateString]!;
          final incomeStatement = financialStatement.incomeStatement;

          _mapValue(field, value.toDouble(), incomeStatement);
        }
      }
    }

  }

  static void _mapValue(String field, double value, IncomeStatement incomeStatement) {
    switch(field){
      case 'RevenueFromContractWithCustomerExcludingAssessedTax':
        incomeStatement.revenues = value;
        break;
    }
  }
  
}