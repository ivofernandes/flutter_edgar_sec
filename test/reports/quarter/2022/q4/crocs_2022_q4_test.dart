import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_test/flutter_test.dart';

/// Come to this url and select the quarterly period to
/// https://seekingalpha.com/symbol/CROX/income-statement
void main() {
  test('Test 2022-Q4 Crocs values for income statement', () async {
    final CompanyResults results = await EdgarSecService.getFinancialStatementsForSymbol('CROX');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.q4 != null);
    final IncomeStatement income2022Q4 = results2022.q4!.incomeStatement;

    final revenueBillions = income2022Q4.revenues.billions;
    final operatingIncomeBillions = income2022Q4.operatingIncome.billions;
    final netIncomeBillions = income2022Q4.netIncome.billions;
    final costOfRevenueBillions = income2022Q4.costOfRevenues.billions;

    assert(revenueBillions == 0.945162);
    //assert(operatingIncomeBillions == 0.1845);
    assert(netIncomeBillions == 0.137735);
    assert(costOfRevenueBillions == 0.448839);

    final eps = income2022Q4.eps;
    final epsDiluted = income2022Q4.epsDiluted;

    // Extrapolate from other quarters
    // Full year - q3 - q2 -
    // 8.82 - 2.75 - 2.6 - 1.22 = 2.25
    // No idea why seeking alpha has 2.23 but I assume they made a mistake
    // Is not exactly 2.25 because we divide the net income by the number of shares
    assert(eps == 2.2498366546880106);
    assert(epsDiluted == 2.2213172918749797);
  });
}
