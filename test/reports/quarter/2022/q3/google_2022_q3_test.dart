import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_test/flutter_test.dart';

/// Come to this url and select the quarterly period to
/// https://seekingalpha.com/symbol/GOOG/income-statement
void main() {
  test('Test 2022-Q3 Google values for income statement', () async {
    final CompanyResults results =
        await EdgarSecService.getFinancialStatementsForSymbol('GOOG');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.q3 != null);
    final IncomeStatement income2022Q3 = results2022.q3!.incomeStatement;

    final revenueBillions = income2022Q3.revenues.billions;
    final operatingIncomeBillions = income2022Q3.operatingIncome.billions;
    final netIncomeBillions = income2022Q3.netIncome.billions;
    final costOfRevenueBillions = income2022Q3.costOfRevenues.billions;

    assert(revenueBillions == 69.092);
    assert(operatingIncomeBillions == 17.135);
    assert(netIncomeBillions == 13.91);
    assert(costOfRevenueBillions == 31.158);
  });

  /// https://www.sec.gov/Archives/edgar/data/1652044/000165204422000090/goog-20220930.htm
  test('Test 2022-Q3 Google values for income statement', () async {
    final CompanyResults results =
        await EdgarSecService.getFinancialStatementsForSymbol('GOOG');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.q3 != null);
    final IncomeStatement income2022Q3 = results2022.q3!.incomeStatement;

    final revenueBillions = income2022Q3.revenues.billions;
    final operatingIncomeBillions = income2022Q3.operatingIncome.billions;
    final netIncomeBillions = income2022Q3.netIncome.billions;
    final costOfRevenuesBillions = income2022Q3.costOfRevenues.billions;

    //final grossProfitBillions = income2022Q3.grossProfit.billions;
    //final sellingGeneralAdministrativeBillions =
    income2022Q3.generalAndAdministrativeExpenses.billions;
    final researchDevelopmentBillions =
        income2022Q3.researchAndDevelopmentExpenses.billions;
    //final operatingExpenseBillions = income2022Q3.operatingExpenses.billions;

    assert(revenueBillions == 69.092);
    assert(operatingIncomeBillions == 17.135);
    assert(netIncomeBillions == 13.910);
    assert(costOfRevenuesBillions == 31.158);

    assert(researchDevelopmentBillions == 10.273);
    //TODO not sure why is not coming here
    //assert(operatingExpenseBillions == 20.799);
    //assert(grossProfitBillions == 37.934);
    //assert(sellingGeneralAdministrativeBillions == 10.526);

    // Check derived values
    final netMargin = income2022Q3.netMargin;
    final operatingMargin = income2022Q3.operatingMargin;

    assert(netMargin.toStringAsFixed(4) == '0.2013');
    assert(operatingMargin.toStringAsFixed(4) == '0.2480');
    //TODO how to get correct data for this margins?
    // Seeking alpha just gest TTM data
    // https://seekingalpha.com/symbol/AAPL/profitability
  });
}
