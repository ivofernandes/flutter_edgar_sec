import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_edgar_sec/src/storage/company_results_dao.dart';

class EdgarSecRepository {
  /// Returns a list of financial statements for a given symbol
  static Future<CompanyResults> getFinancialStatementsForSymbol({
    required String symbol,
    bool useStorage = true,
  }) async {
    if (useStorage) {
      final Map<String, dynamic> jsonData =
          await CompanyResultsDAO().getData(symbol);

      if (jsonData.isNotEmpty) {
        return CompanyResults.fromJsonStorage(jsonData);
      }
    }

    // If we arrived here, it means that we don't have the data in the local database
    final CompanyResults companyResults =
        await EdgarSecService.getFinancialStatementsForSymbol(symbol);

    if (useStorage) {
      await CompanyResultsDAO().saveData(symbol, companyResults.toJson());
    }

    return companyResults;
  }
}
