import 'package:flutter_edgar_sec/src/model/financial_statement.dart';

class EdgarSecService{

  static Future<List<FinancialStatement>> getFinancialStatementsForSymbol(String symbol){

    return Future.delayed(Duration(seconds: 1),() => <FinancialStatement>[
      FinancialStatement(),
      FinancialStatement(),
      FinancialStatement(),
      FinancialStatement(),
    ]);
  }
}