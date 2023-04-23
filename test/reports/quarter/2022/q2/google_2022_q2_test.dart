import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_test/flutter_test.dart';

/// Come to this url and select the quarterly period to
/// https://seekingalpha.com/symbol/GOOG/income-statement
void main() {
  test('Test 2022-Q2 Google values for income statement', () async {
    final CompanyResults results = await EdgarSecService.getFinancialStatementsForSymbol('GOOG');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.q2 != null);
    final IncomeStatement income2022Q2 = results2022.q2!.incomeStatement;

    final revenueBillions = income2022Q2.revenues.billions;
    final operatingIncomeBillions = income2022Q2.operatingIncome.billions;
    final netIncomeBillions = income2022Q2.netIncome.billions;
    final costOfRevenueBillions = income2022Q2.costOfRevenues.billions;

    assert(revenueBillions == 69.685);
    assert(operatingIncomeBillions == 19.453);
    assert(netIncomeBillions == 16.002);
    assert(costOfRevenueBillions == 30.104);
  });
}
