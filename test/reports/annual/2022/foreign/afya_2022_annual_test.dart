import 'package:flutter/material.dart';
import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Come to this url to get the correct values for the test
  /// https://seekingalpha.com/symbol/AFYA/income-statement
  test('Test 2022 Afya values for income statement', () async {
    final CompanyResults results =
        await EdgarSecService.getFinancialStatementsForSymbol('AFYA');

    debugPrint(results.yearlyResults.toString());
    //assert(results.yearlyResults.isNotEmpty);
  });
}
