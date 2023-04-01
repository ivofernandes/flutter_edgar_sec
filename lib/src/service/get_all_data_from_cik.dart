import 'dart:convert';

import 'package:flutter_edgar_sec/src/model/r1_company_results.dart';
import 'package:http/http.dart' as http;

class GetAllDataFromCik {
  static Future<CompanyResults> getAllDataFromCik(String cik) async {
    // Get the data from the SEC. Example url:
    // https://data.sec.gov/api/xbrl/companyfacts/CIK0000320193.json
    final Uri uri = Uri.https('data.sec.gov', '/api/xbrl/companyfacts/CIK$cik.json');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final companyFactsJson = json.decode(response.body) as Map<String, dynamic>;

      return CompanyResults.fromJsonList(companyFactsJson);
    }

    return CompanyResults.empty();
  }
}
