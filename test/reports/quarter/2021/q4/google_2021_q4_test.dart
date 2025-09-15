import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_test/flutter_test.dart';

/// Come to this url and select the quarterly period to
/// https://seekingalpha.com/symbol/GOOG/income-statement
void main() {
  test('Test 2022-Q1 Google values for income statement', () async {
    final CompanyResults results =
        await EdgarSecService.getFinancialStatementsForSymbol('GOOG');

    assert(results.yearlyResults.isNotEmpty);

    //final YearlyResults results2021 = results.yearlyResults[2021]!;
  });
}
