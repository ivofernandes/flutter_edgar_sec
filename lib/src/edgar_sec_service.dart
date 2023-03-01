import 'package:flutter_edgar_sec/src/model/financial_statement.dart';
import 'package:flutter_edgar_sec/src/service/get_all_data_from_cik.dart';
import 'package:flutter_edgar_sec/src/service/symbol_to_cik.dart';

class EdgarSecService{

  /// Returns a list of financial statements for a given symbol
  static Future<List<FinancialStatement>> getFinancialStatementsForSymbol(String symbol){

    String cik = SymbolToCik.convert(symbol,leadingZeros: true);

    return GetAllDataFromCik.getAllDataFromCik(cik);
  }
}
