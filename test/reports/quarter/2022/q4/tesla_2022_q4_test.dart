import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_test/flutter_test.dart';

/// Come to this url and select the quarterly period to
/// https://seekingalpha.com/symbol/TSLA/income-statement
void main() {
  test('Test 2022-Q4 Tesla values for income statement', () async {
    final CompanyResults results =
        await EdgarSecService.getFinancialStatementsForSymbol('TSLA');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.q4 != null);
    final IncomeStatement income2022Q4 = results2022.q4!.incomeStatement;

    final revenueBillions = income2022Q4.revenues.billions;
    final operatingIncomeBillions = income2022Q4.operatingIncome.billions;
    final netIncomeBillions = income2022Q4.netIncome.billions;
    final costOfRevenueBillions = income2022Q4.costOfRevenues.billions;

    assert(revenueBillions == 24.318);
    assert(operatingIncomeBillions == 3.901);
    assert(netIncomeBillions == 3.687);
    assert(costOfRevenueBillions == 18.541);

    final eps = income2022Q4.eps;
    final epsDiluted = income2022Q4.epsDiluted;
    assert(eps == 1.1779552715654953);
    assert(epsDiluted == 1.0610071942446042);
  });
}
