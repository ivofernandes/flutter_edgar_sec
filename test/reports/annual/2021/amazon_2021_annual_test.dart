import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
// ignore: unnecessary_import
import 'package:flutter_edgar_sec/src/model/financials/cash_flow_statement.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Come to this url to get the correct values for the test
  /// https://seekingalpha.com/symbol/AMZN/income-statement
  /// pdf:
  /// https://s2.q4cdn.com/299287126/files/doc_financials/2022/ar/Amazon-2021-Annual-Report.pdf
  ///
  /// html:
  /// https://www.sec.gov/Archives/edgar/data/1018724/000101872422000005/amzn-20211231.htm
  test('Test 2021 Amazon values for income statement', () async {
    final CompanyResults results =
        await EdgarSecService.getFinancialStatementsForSymbol('AMZN');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2021 = results.yearlyResults[2021]!;

    assert(results2021.fullYear != null);

    final IncomeStatement income2021 = results2021.fullYear!.incomeStatement;

    final revenueBillions = income2021.revenues.billions;
    final operatingIncomeBillions = income2021.operatingIncome.billions;
    final netIncomeBillions = income2021.netIncome.billions;
    final costOfRevenueBillions = income2021.costOfRevenues.billions;

    //final grossProfitBillions = income2021.grossProfit.billions;
    //final sellingGeneralAdministrativeBillions = income2021.generalAndAdministrativeExpenses.billions;
    //final researchDevelopmentBillions = income2021.researchAndDevelopmentExpenses.billions;
    //final operatingExpenseBillions = income2021.operatingExpenses.billions;

    // Income Statement's asserts
    final interestExpensesBillions = income2021.interestExpenses.billions;
    //final otherNonOperatingIncomeExpenseBillions = income2021.otherNonOperatingIncomeExpense.billions;
    final incomeTaxExpenseBillions = income2021.incomeTaxExpense.billions;

    final ebitBillions = income2021.EBIT.billions;
    assert(ebitBillions == operatingIncomeBillions);

    assert(revenueBillions == 469.822);
    assert(operatingIncomeBillions == 24.879);
    assert(netIncomeBillions == 33.364);
    assert(costOfRevenueBillions == 272.344);

    // TODO map
    //assert(grossProfitBillions == 197.478);
    //assert(sellingGeneralAdministrativeBillions == 8.823);
    //assert(researchDevelopmentBillions == 56.052);
    //assert(operatingExpenseBillions == 172.599);

    assert(interestExpensesBillions == 1.809);

    //assert(otherNonOperatingIncomeExpenseBillions == -0.019);
    assert(incomeTaxExpenseBillions == 4.791);

    // Check derived values
    final netMargin = income2021.netMargin;
    final operatingMargin = income2021.operatingMargin;

    assert(netMargin.toStringAsFixed(4) == '0.0710');
    assert(operatingMargin.toStringAsFixed(4) == '0.0530');
  });

  /// Come to this url to get the correct values for the test
  /// https://seekingalpha.com/symbol/AMZN/cash-flow-statement
  test('Test 2021 Amazon values for cash flow', () async {
    final CompanyResults results =
        await EdgarSecService.getFinancialStatementsForSymbol('AMZN');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2021 = results.yearlyResults[2021]!;

    assert(results2021.fullYear != null);

    final CashFlowStatement cashFlowStatement2021 =
        results2021.fullYear!.cashFlowStatement;

    final repurchaseofCommonStockBillions =
        cashFlowStatement2021.buyback.billions;

    final dividends = cashFlowStatement2021.dividends.billions;
    assert(repurchaseofCommonStockBillions == 0);
    assert(dividends == 0);
  });
}
