import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Come to this url to get the correct values for the test
  /// https://seekingalpha.com/symbol/CROX/income-statement
  test('Test 2021 Crocs values for income statement', () async {
    final CompanyResults results =
        await EdgarSecService.getFinancialStatementsForSymbol('CROX');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2021 = results.yearlyResults[2021]!;

    assert(results2021.fullYear != null);

    final IncomeStatement income2021 = results2021.fullYear!.incomeStatement;

    final revenueBillions = income2021.revenues.billions;
    final operatingIncomeBillions = income2021.operatingIncome.billions;
    final netIncomeBillions = income2021.netIncome.billions;
    final costOfRevenueBillions = income2021.costOfRevenues.billions;

    final grossProfitBillions = income2021.grossProfit.billions;
    final sellingGeneralAdministrativeBillions =
        income2021.generalAndAdministrativeExpenses.billions;
    final researchDevelopmentBillions =
        income2021.researchAndDevelopmentExpenses.billions;
    final operatingExpenseBillions = income2021.operatingExpenses.billions;

    // Income Statement's asserts
    final interestExpensesBillions = income2021.interestExpenses.billions;
    final totalNonOperatingIncomeExpenseBillions =
        income2021.totalNonOperatingIncomeExpense.billions;
    final incomeTaxExpenseBillions = income2021.incomeTaxExpense.billions;

    final ebitBillions = income2021.EBIT.billions;
    assert(ebitBillions == operatingIncomeBillions);

    assert(revenueBillions == 2.313416);
    assert(operatingIncomeBillions == 0.683064);
    assert(netIncomeBillions == 0.725694);
    assert(costOfRevenueBillions == 0.893196);

    assert(grossProfitBillions == 1.42022);
    assert(sellingGeneralAdministrativeBillions == 0.737156);
    assert(researchDevelopmentBillions == 0.0137);
    //assert(operatingExpenseBillions == 0.750856);

    assert(interestExpensesBillions == 0.021647);
    assert(totalNonOperatingIncomeExpenseBillions == 0.001797);
    assert(incomeTaxExpenseBillions == -0.061845);

    // Check derived values
    final netMargin = income2021.netMargin;
    final operatingMargin = income2021.operatingMargin;

    assert(netMargin.toStringAsFixed(4) == '0.3137');
    assert(operatingMargin.toStringAsFixed(4) == '0.2953');
  });
}
