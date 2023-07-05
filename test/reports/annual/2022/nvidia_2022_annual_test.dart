import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Come to this url to get the correct values for the test
  /// https://seekingalpha.com/symbol/NVDA/income-statement
  test('Test 2022 Nvidia values for income statement', () async {
    final CompanyResults results = await EdgarSecService.getFinancialStatementsForSymbol('NVDA');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.fullYear != null);

    final IncomeStatement income2022 = results2022.fullYear!.incomeStatement;

    final revenueBillions = income2022.revenues.billions;
    final operatingIncomeBillions = income2022.operatingIncome.billions;
    final netIncomeBillions = income2022.netIncome.billions;
    final costOfRevenueBillions = income2022.costOfRevenues.billions;

    final grossProfitBillions = income2022.grossProfit.billions;
    final sellingGeneralAdministrativeBillions = income2022.generalAndAdministrativeExpenses.billions;
    final researchDevelopmentBillions = income2022.researchAndDevelopmentExpenses.billions;
    final operatingExpenseBillions = income2022.operatingExpenses.billions;
    final otherOperatingExpensesBillions = income2022.otherOperatingExpenses.billions;

    // Income Statement's asserts
    final interestExpensesBillions = income2022.interestExpenses.billions;
    final otherNonOperatingIncomeExpenseBillions = income2022.otherNonOperatingIncomeExpense.billions;
    final incomeTaxExpenseBillions = income2022.incomeTaxExpense.billions;

    final ebitBillions = income2022.EBIT.billions;
    assert(ebitBillions == operatingIncomeBillions);

    assert(revenueBillions == 26.914);
    assert(operatingIncomeBillions == 10.041);
    assert(netIncomeBillions == 9.752);
    assert(costOfRevenueBillions == 9.439);

    assert(grossProfitBillions == 17.475);
    assert(sellingGeneralAdministrativeBillions == 2.166);
    assert(researchDevelopmentBillions == 5.268);
    assert(otherOperatingExpensesBillions == 0);
    assert(operatingExpenseBillions == 7.434);

    assert(interestExpensesBillions == 0.236);
    assert(otherNonOperatingIncomeExpenseBillions == -0.1);
    assert(incomeTaxExpenseBillions == 0.189);

    // Check derived values
    final netMargin = income2022.netMargin;
    final operatingMargin = income2022.operatingMargin;

    assert(netMargin.toStringAsFixed(4) == '0.3623');
    assert(operatingMargin.toStringAsFixed(4) == '0.3731');

    // Check eps and shares
    final eps = income2022.eps;
    final epsDiluted = income2022.epsDiluted;

    assert(eps == 3.91);
    assert(epsDiluted == 3.85);
  });
}
