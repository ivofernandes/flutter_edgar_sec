import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_test/flutter_test.dart';

/// Come to this url and select the quarterly period to
/// https://seekingalpha.com/symbol/BIDU/income-statement
/// https://ir.baidu.com/node/13451/html
/// More baidu reports:
/// https://ir.baidu.com/financial-information/sec-filings
void main() {
  test('Test 2022 Baidu values for income statement', () async {
    final CompanyResults results =
        await EdgarSecService.getFinancialStatementsForSymbol('BIDU');

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.fullYear != null);

    final IncomeStatement income2022 = results2022.fullYear!.incomeStatement;

    final revenueBillions = income2022.revenues.billions;
    final operatingIncomeBillions = income2022.operatingIncome.billions;
    final netIncomeBillions = income2022.netIncome.billions;
    final costOfRevenueBillions = income2022.costOfRevenues.billions;

    assert(revenueBillions == 17.931);
    assert(costOfRevenueBillions == 9.269);
    assert(operatingIncomeBillions == 2.307);
    assert(netIncomeBillions == 1.096);
  });
}
