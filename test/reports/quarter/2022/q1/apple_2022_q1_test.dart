import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Come to this url and select the quarterly period to
  /// https://seekingalpha.com/symbol/AAPL/income-statement
  test('Test 2022-Q1 apple values for income statement', () async {
    final CompanyResults results =
        await EdgarSecService.getFinancialStatementsForSymbol('AAPL');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.q1 != null);
    final IncomeStatement income2022Q1 = results2022.q1!.incomeStatement;

    final revenueBillions = income2022Q1.revenues.billions;
    final operatingIncomeBillions = income2022Q1.operatingIncome.billions;
    final netIncomeBillions = income2022Q1.netIncome.billions;
    final costOfRevenueBillions = income2022Q1.costOfRevenues.billions;

    //final grossProfitBillions = income2022Q1.grossProfit.billions;
    //final sellingGeneralAdministrativeBillions = income2022Q1.generalAndAdministrativeExpenses.billions;
    //final researchDevelopmentBillions = income2022Q1.researchAndDevelopmentExpenses.billions;
    //final operatingExpenseBillions = income2022Q1.operatingExpenses.billions;

    assert(revenueBillions == 97.278);
    assert(operatingIncomeBillions == 29.979);
    assert(netIncomeBillions == 25.01);
    assert(costOfRevenueBillions == 54.719);
  });
}
