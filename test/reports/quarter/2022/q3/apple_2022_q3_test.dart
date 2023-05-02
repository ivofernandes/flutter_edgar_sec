import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Come to this url and select the quarterly period to
  /// https://seekingalpha.com/symbol/AAPL/income-statement
  test('Test 2022-Q2 apple values for income statement', () async {
    final CompanyResults results = await EdgarSecService.getFinancialStatementsForSymbol('AAPL');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.q3 != null);
    final IncomeStatement income2022Q3 = results2022.q3!.incomeStatement;

    final revenueBillions = income2022Q3.revenues.billions;
    final operatingIncomeBillions = income2022Q3.operatingIncome.billions;
    final netIncomeBillions = income2022Q3.netIncome.billions;
    final costOfRevenueBillions = income2022Q3.costOfRevenues.billions;

    final grossProfitBillions = income2022Q3.grossProfit.billions;
    final sellingGeneralAdministrativeBillions = income2022Q3.generalAndAdministrativeExpenses.billions;
    final researchDevelopmentBillions = income2022Q3.researchAndDevelopmentExpenses.billions;
    final operatingExpenseBillions = income2022Q3.operatingExpenses.billions;

    //assert(revenueBillions == 117.154);
    //assert(operatingIncomeBillions == 36.016);
    //assert(netIncomeBillions == 29.998);
    //assert(costOfRevenueBillions == 66.822);
  });
}
