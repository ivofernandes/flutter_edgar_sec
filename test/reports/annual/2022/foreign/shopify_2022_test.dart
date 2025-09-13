import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_test/flutter_test.dart';

/// Come to this url and select the quarterly period to
/// https://seekingalpha.com/symbol/SHOP/income-statement
/// https://d18rn0p25nwr6d.cloudfront.net/CIK-0001594805/007bace5-ef05-4562-981e-84d927316c28.html#
void main() {
  test('Test 2022 Shopify values for income statement', () async {
    final CompanyResults results =
        await EdgarSecService.getFinancialStatementsForSymbol('SHOP');

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.fullYear != null);

    final IncomeStatement income2022 = results2022.fullYear!.incomeStatement;

    final revenueBillions = income2022.revenues.billions;
    final operatingIncomeBillions = income2022.operatingIncome.billions;
    final netIncomeBillions = income2022.netIncome.billions;
    final costOfRevenueBillions = income2022.costOfRevenues.billions;

    //assert(revenueBillions == 5.599864);
    assert(costOfRevenueBillions == 2.845745);
    assert(operatingIncomeBillions == -0.822299);
    assert(netIncomeBillions == -3.460418);
  });
}
