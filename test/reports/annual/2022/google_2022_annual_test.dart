import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_edgar_sec/src/model/financials/cash_flow_statement.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Come to this url to get the correct values for the test
  /// https://seekingalpha.com/symbol/GOOG/income-statement
  /// https://www.sec.gov/Archives/edgar/data/1652044/000165204423000016/goog-20221231.htm#ia96e4fb0476549c99dc3a2b2368f643f_343

  test('Test 2022 Google values for income statement', () async {
    final CompanyResults results = await EdgarSecService.getFinancialStatementsForSymbol('GOOG');

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

    // Income Statement's asserts
    final interestExpensesBillions = income2022.interestExpenses.billions;
    final otherNonOperatingIncomeExpenseBillions = income2022.otherNonOperatingIncomeExpense.billions;
    final incomeTaxExpenseBillions = income2022.incomeTaxExpense.billions;

    final ebitBillions = income2022.EBIT.billions;
    assert(ebitBillions == operatingIncomeBillions);

    assert(revenueBillions == 282.836);
    assert(operatingIncomeBillions == 74.842);
    assert(netIncomeBillions == 59.972);
    assert(costOfRevenueBillions == 126.203);

    assert(grossProfitBillions == 156.633);
    assert(sellingGeneralAdministrativeBillions == 42.291);
    assert(researchDevelopmentBillions == 39.5);
    assert(operatingExpenseBillions == 81.791);

    assert(interestExpensesBillions == 0.357);

    assert(otherNonOperatingIncomeExpenseBillions == -3.514);
    assert(incomeTaxExpenseBillions == 11.356);

    // Check derived values
    final netMargin = income2022.netMargin;
    final operatingMargin = income2022.operatingMargin;

    assert(netMargin.toStringAsFixed(4) == '0.2120');
    assert(operatingMargin.toStringAsFixed(4) == '0.2646');
  });

  /// Come to this url to get the correct values for the test
  /// https://seekingalpha.com/symbol/GOOG/cash-flow-statement
  /// https://www.sec.gov/Archives/edgar/data/1652044/000165204423000016/goog-20221231.htm#ia96e4fb0476549c99dc3a2b2368f643f_208
  test('Test 2021 Google values for cash flow', () async {
    final CompanyResults results = await EdgarSecService.getFinancialStatementsForSymbol('GOOG');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.fullYear != null);

    final CashFlowStatement cashFlowStatement2022 = results2022.fullYear!.cashFlowStatement;

    final repurchaseofCommonStockBillions = cashFlowStatement2022.buyback.billions;

    final dividends = cashFlowStatement2022.dividends.billions;

    final sharedBasedCompensationBillions = cashFlowStatement2022.shareBasedCompensation.billions;
    final capitalExpendituresBillions = cashFlowStatement2022.capitalExpenditures.billions;
    final cashFromOperationsBillions = cashFlowStatement2022.cashFromOperations.billions;

    assert(repurchaseofCommonStockBillions == 59.296);
    assert(dividends == 0);
    assert(sharedBasedCompensationBillions == 19.362);
    assert(capitalExpendituresBillions == 31.485);
    assert(cashFromOperationsBillions == 91.495);
  });
}
