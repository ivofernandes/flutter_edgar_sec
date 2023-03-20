import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Come to this url to get the correct values for the test
  /// https://seekingalpha.com/symbol/GOOG/income-statement
  test('Test 2021 Google values for income statement', () async {
    final CompanyResults results = await EdgarSecService.getFinancialStatementsForSymbol('GOOG');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2021 = results.yearlyResults[2021]!;

    assert(results2021.fullYear != null);

    final IncomeStatement income2021 = results2021.fullYear!.incomeStatement!;

    final revenueBillions = income2021.revenues.billions;
    final operatingIncomeBillions = income2021.operatingIncome.billions;
    final netIncomeBillions = income2021.netIncome.billions;
    final costOfRevenueBillions = income2021.costOfRevenues.billions;

    final grossProfitBillions = income2021.grossProfit.billions;
    final sellingGeneralAdministrativeBillions = income2021.sellingGeneralAndAdministrativeExpenses.billions;
    final researchDevelopmentBillions = income2021.researchAndDevelopmentExpenses.billions;
    final operatingExpenseBillions = income2021.operatingExpenses.billions;

    // Income Statement's asserts
    final interestExpensesBillions = income2021.interestExpenses.billions;
    final otherNonOperatingIncomeExpenseBillions = income2021.otherNonOperatingIncomeExpense.billions;
    final incomeTaxExpenseBillions = income2021.incomeTaxExpense.billions;

    final ebitBillions = income2021.EBIT.billions;
    assert(ebitBillions == operatingIncomeBillions);

    assert(revenueBillions == 257.637);
    assert(operatingIncomeBillions == 78.714);
    assert(netIncomeBillions == 76.033);
    assert(costOfRevenueBillions == 110.939);

    // TODO map
    //assert(grossProfitBillions == 146.698);
    //assert(sellingGeneralAdministrativeBillions == 36.422);
    assert(researchDevelopmentBillions == 31.562);
    //assert(operatingExpenseBillions == 67.984);

    //assert(interestExpensesBillions == 0.346);

    //TODO why is wrong?
    // assert(otherNonOperatingIncomeExpenseBillions == -1.497);
    //assert(incomeTaxExpenseBillions == 14.701);

    // Check derivated values
    final netMargin = income2021.netMargin;
    final operatingMargin = income2021.operatingMargin;

    assert(netMargin.toStringAsFixed(4) == '0.2951');
    assert(operatingMargin.toStringAsFixed(4) == '0.3055');
  });
}
