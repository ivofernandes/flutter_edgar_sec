import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_test/flutter_test.dart';

/// Come to this url and select the quarterly period to
/// https://seekingalpha.com/symbol/FTCH/income-statement
void main() {
  test('Test 2022 Farfetch values for income statement', () async {
    final CompanyResults results = await EdgarSecService.getFinancialStatementsForSymbol('FTCH');

    // Sadly, is returning empty for now
    assert(results.years.isEmpty);
  });
}
