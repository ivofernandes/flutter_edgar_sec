import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_test/flutter_test.dart';

/// Come to this url and select the quarterly period to
/// https://seekingalpha.com/symbol/SHOP/income-statement
/// https://investors.shopify.com/financial-reports/default.aspx
void main() {
  test('Test 2022-Q4 Shopify values for income statement', () async {
    final CompanyResults results = await EdgarSecService.getFinancialStatementsForSymbol('SHOP');

    assert(results.yearlyResults.isNotEmpty);
    //TODO add values
  });
}
