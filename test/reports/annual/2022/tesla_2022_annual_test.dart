import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Come to this url to get the correct values for the test
  /// https://seekingalpha.com/symbol/TSLA/income-statement
  /// SEC
  /// https://www.sec.gov/ix?doc=/Archives/edgar/data/1318605/000095017023001409/tsla-20221231.htm
  test('Test 2022 Tesla values for income statement', () async {
    final CompanyResults results =
        await EdgarSecService.getFinancialStatementsForSymbol('TSLA');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.fullYear != null);

    final IncomeStatement income2022 = results2022.fullYear!.incomeStatement;

    final revenueBillions = income2022.revenues.billions;
    final operatingIncomeBillions = income2022.operatingIncome.billions;
    final netIncomeBillions = income2022.netIncome.billions;
    final costOfRevenueBillions = income2022.costOfRevenues.billions;

    final grossProfitBillions = income2022.grossProfit.billions;
    final sellingGeneralAdministrativeBillions =
        income2022.generalAndAdministrativeExpenses.billions;
    final researchDevelopmentBillions =
        income2022.researchAndDevelopmentExpenses.billions;
    final operatingExpenseBillions = income2022.operatingExpenses.billions;
    final otherOperatingExpensesBillions =
        income2022.otherOperatingExpenses.billions;

    // Income Statement's asserts
    final interestExpensesBillions = income2022.interestExpenses.billions;
    final otherNonOperatingIncomeExpenseBillions =
        income2022.otherNonOperatingIncomeExpense.billions;
    final incomeTaxExpenseBillions = income2022.incomeTaxExpense.billions;

    final ebitBillions = income2022.EBIT.billions;
    assert(ebitBillions == operatingIncomeBillions);

    assert(revenueBillions == 81.462);
    assert(operatingIncomeBillions == 13.656);
    assert(netIncomeBillions == 12.556);
    assert(costOfRevenueBillions == 60.609);

    assert(grossProfitBillions == 20.853);
    assert(sellingGeneralAdministrativeBillions == 3.946);
    assert(researchDevelopmentBillions == 3.075);
    assert(otherOperatingExpensesBillions == 0.176);
    assert(operatingExpenseBillions == 7.197);

    assert(interestExpensesBillions == 0.191);
    assert(otherNonOperatingIncomeExpenseBillions == 0);
    assert(incomeTaxExpenseBillions == 1.132);

    // Check derived values
    final netMargin = income2022.netMargin;
    final operatingMargin = income2022.operatingMargin;

    assert(netMargin.toStringAsFixed(4) == '0.1541');
    assert(operatingMargin.toStringAsFixed(4) == '0.1676');

    // Check eps and shares
    final eps = income2022.eps;
    final epsDiluted = income2022.epsDiluted;

    assert(eps == 4.02);
    assert(epsDiluted == 3.62);
  });
}
