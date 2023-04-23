import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_test/flutter_test.dart';

/// Come to this url and select the quarterly period to
/// https://seekingalpha.com/symbol/GOOG/income-statement
void main() {
  test('Test 2022-Q1 Google values for income statement', () async {
    final CompanyResults results = await EdgarSecService.getFinancialStatementsForSymbol('GOOG');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.q1 != null);
    final IncomeStatement income2022Q1 = results2022.q1!.incomeStatement;

    final revenueBillions = income2022Q1.revenues.billions;
    final operatingIncomeBillions = income2022Q1.operatingIncome.billions;
    final netIncomeBillions = income2022Q1.netIncome.billions;
    final costOfRevenueBillions = income2022Q1.costOfRevenues.billions;

    assert(revenueBillions == 68.011);
    assert(operatingIncomeBillions == 20.094);
    assert(netIncomeBillions == 16.436);
    assert(costOfRevenueBillions == 29.599);
  });
}
