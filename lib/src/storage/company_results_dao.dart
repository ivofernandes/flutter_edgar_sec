import 'package:flutter_edgar_sec/src/storage/sembast_database.dart';
import 'package:sembast/sembast.dart';

/// Class to manage interactions with local database
class CompanyResultsDAO with SembastDatabase {
  // Singleton
  static final CompanyResultsDAO _singleton = CompanyResultsDAO._internal();

  factory CompanyResultsDAO() => _singleton;

  CompanyResultsDAO._internal();

  // Name of the store
  static const String storeName = 'EDGAR_SEC_COMPANY_RESULTS';

  /// Returns a list of financial statements for a given symbol
  Future<Map<String, dynamic>> getData(String ticker) async {
    final store = intMapStoreFactory.store(storeName);

    final DatabaseClient database = await getDatabase();
    final data = await store.find(
      database,
      finder: Finder(
        filter: Filter.equals('ticker', ticker),
      ),
    );

    Map<String, dynamic> resultsList = {};

    for (final snapshot in data) {
      final map = snapshot.value;

      if (map['data'] != null) {
        resultsList = map['data']! as Map<String, dynamic>;
      }
    }

    return resultsList;
  }

  /// Saves the financial statements data for a given symbol
  Future<void> saveData(String? ticker, Map<String, dynamic> data) async {
    final store = intMapStoreFactory.store(storeName);
    final DatabaseClient database = await getDatabase();

    await store.delete(
      database,
      finder: Finder(
        filter: Filter.equals(
          'ticker',
          ticker,
        ),
      ),
    );

    await store.add(database, {
      'ticker': ticker,
      'data': data,
    });
  }

  /// Removes the financial statements data for a given symbol
  Future<int> removeData(String? ticker) async {
    final store = intMapStoreFactory.store(storeName);
    final DatabaseClient database = await getDatabase();

    final int deletedRecords = await store.delete(
      database,
      finder: Finder(
        filter: Filter.equals('ticker', ticker),
      ),
    );

    return deletedRecords;
  }
}
