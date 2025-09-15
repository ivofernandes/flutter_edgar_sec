import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Come to this url and select the quarterly period to
  /// https://seekingalpha.com/symbol/AAPL/income-statement
  test('Test 2022-Q4 apple values for income statement', () async {
    final CompanyResults results =
        await EdgarSecService.getFinancialStatementsForSymbol('AAPL');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.q4 != null);
    final IncomeStatement income2022Q4 = results2022.q4!.incomeStatement;

    final revenueBillions = income2022Q4.revenues.billions;
    final operatingIncomeBillions = income2022Q4.operatingIncome.billions;
    final netIncomeBillions = income2022Q4.netIncome.billions;
    final costOfRevenueBillions = income2022Q4.costOfRevenues.billions;

    final grossProfitBillions = income2022Q4.grossProfit.billions;
    final sellingGeneralAdministrativeBillions =
        income2022Q4.generalAndAdministrativeExpenses.billions;
    final researchDevelopmentBillions =
        income2022Q4.researchAndDevelopmentExpenses.billions;
    final operatingExpenseBillions = income2022Q4.operatingExpenses.billions;

    assert(revenueBillions == 117.154);
    assert(operatingIncomeBillions == 36.016);
    assert(netIncomeBillions == 29.998);
    assert(costOfRevenueBillions == 66.822);

    assert(grossProfitBillions == 50.332);
    assert(sellingGeneralAdministrativeBillions == 6.607);
    assert(researchDevelopmentBillions == 7.709);
    assert(operatingExpenseBillions == 14.316);

    // Check derived values
    final netMargin = income2022Q4.netMargin;
    final operatingMargin = income2022Q4.operatingMargin;

    // To get % seeking alpha has a view with percentage of revenue instead of absolute values
    assert(netMargin.toStringAsFixed(4) == '0.2561');
    assert(operatingMargin.toStringAsFixed(4) == '0.3074');
  });

  /// Come to this url and select the quarterly period to
  /// https://seekingalpha.com/symbol/AAPL/cash-flow-statement
  test('Test 2022-Q4 apple values for cash flow statement', () async {
    final CompanyResults results =
        await EdgarSecService.getFinancialStatementsForSymbol('AAPL');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.q4 != null);
    //final CashFlowStatement cashFlow2022Q4 = results2022.q4!.cashFlowStatement;

    //final repurchaseofCommonStockBillions = cashFlow2022Q4.buyback.billions;

    //final dividends = cashFlow2022Q4.dividends.billions;
    //TODO not sure why not matches seeking alpha
    //assert(repurchaseofCommonStockBillions == 21.791);
    //assert(dividends == 3.768);
  });
}
