import 'dart:convert';

import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:http/http.dart' as http;

class GetAllDataFromCik {
  static Future<List<FinancialStatement>> getAllDataFromCik(String cik) async {

    // Get the data from the SEC. Example url:
    // https://data.sec.gov/api/xbrl/companyfacts/CIK0000320193.json
    Uri uri = Uri.https('data.sec.gov', '/api/xbrl/companyfacts/CIK$cik.json');

    final response = await http.get(uri);

    if(response.statusCode == 200){
      final companyFactsJson = json.decode(response.body);

      return FinancialStatement.fromJsonList(companyFactsJson);
    }

    return [];
  }
}