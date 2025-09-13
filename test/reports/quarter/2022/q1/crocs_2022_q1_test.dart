import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_test/flutter_test.dart';

/// Come to this url and select the quarterly period to
/// https://seekingalpha.com/symbol/CROX/income-statement
/// https://www.sec.gov/ix?doc=/Archives/edgar/data/0001334036/000133403622000054/crox-20220331.htm
void main() {
  test('Test 2022-Q1 Crocs values for income statement', () async {
    final CompanyResults results =
        await EdgarSecService.getFinancialStatementsForSymbol('CROX');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.q1 != null);
    final IncomeStatement income2022Q1 = results2022.q1!.incomeStatement;

    final revenueBillions = income2022Q1.revenues.billions;
    final operatingIncomeBillions = income2022Q1.operatingIncome.billions;
    final netIncomeBillions = income2022Q1.netIncome.billions;
    final costOfRevenueBillions = income2022Q1.costOfRevenues.billions;

    assert(revenueBillions == 0.660148);
    assert(operatingIncomeBillions == 0.118677);
    assert(netIncomeBillions == 0.07276);
    assert(costOfRevenueBillions == 0.335224);

    final eps = income2022Q1.eps;
    final epsDiluted = income2022Q1.epsDiluted;

    assert(eps == 1.22);
    assert(epsDiluted == 1.19);
  });
}
