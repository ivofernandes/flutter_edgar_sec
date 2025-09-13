import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Come to this url and select the quarterly period to
  /// https://seekingalpha.com/symbol/AAPL/income-statement
  test('Test 2022-Q3 apple values for income statement', () async {
    final CompanyResults results =
        await EdgarSecService.getFinancialStatementsForSymbol('AAPL');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.q2 != null);
    final IncomeStatement income2022Q2 = results2022.q2!.incomeStatement;

    final revenueBillions = income2022Q2.revenues.billions;
    final operatingIncomeBillions = income2022Q2.operatingIncome.billions;
    final netIncomeBillions = income2022Q2.netIncome.billions;
    final costOfRevenueBillions = income2022Q2.costOfRevenues.billions;

    final grossProfitBillions = income2022Q2.grossProfit.billions;
    final sellingGeneralAdministrativeBillions =
        income2022Q2.generalAndAdministrativeExpenses.billions;
    final researchDevelopmentBillions =
        income2022Q2.researchAndDevelopmentExpenses.billions;
    final operatingExpenseBillions = income2022Q2.operatingExpenses.billions;

    assert(revenueBillions == 82.959);
    assert(operatingIncomeBillions == 23.076);
    assert(netIncomeBillions == 19.442);
    assert(costOfRevenueBillions == 47.074);

    assert(grossProfitBillions == 35.885);
    assert(sellingGeneralAdministrativeBillions == 6.012);
    assert(researchDevelopmentBillions == 6.797);
    assert(operatingExpenseBillions == 12.809);
  });
}
