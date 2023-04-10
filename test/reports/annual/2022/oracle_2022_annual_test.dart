import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Come to this url to get the correct values for the test
  /// https://seekingalpha.com/symbol/ORCL/income-statement
  /// Seeking alpha have a wrong operating income
  /// https://www.sec.gov/ix?doc=/Archives/edgar/data/1341439/000156459022023675/orcl-10k_20220531.htm
  test('Test 2022 Oracle values for income statement', () async {
    final CompanyResults results = await EdgarSecService.getFinancialStatementsForSymbol('ORCL');

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

    assert(revenueBillions == 42.44);
    assert(operatingIncomeBillions == 10.926);
    assert(netIncomeBillions == 6.717);
    assert(costOfRevenueBillions == 8.877);

    assert(grossProfitBillions == 33.563);
    assert(sellingGeneralAdministrativeBillions == 9.364);
    assert(researchDevelopmentBillions == 7.219);
    assert(otherOperatingExpensesBillions == 6.054);
    assert(operatingExpenseBillions == 22.637);

    assert(interestExpensesBillions == 2.755);
    //assert(otherNonOperatingIncomeExpenseBillions == -0.000338);
    assert(incomeTaxExpenseBillions == 0.932);

    // Check derived values
    final netMargin = income2022.netMargin;
    final operatingMargin = income2022.operatingMargin;

    assert(netMargin.toStringAsFixed(4) == '0.1583');
    assert(operatingMargin.toStringAsFixed(4) == '0.2574');
  });
}
