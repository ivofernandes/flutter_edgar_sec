import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_edgar_sec/src/model/financials/cash_flow_statement.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Come to this url to get the correct values for the test
  /// https://seekingalpha.com/symbol/GOOG/income-statement
  /// https://www.sec.gov/Archives/edgar/data/1652044/000165204423000016/goog-20221231.htm#ia96e4fb0476549c99dc3a2b2368f643f_343

  test('Test 2021 Google values for income statement', () async {
    final CompanyResults results =
        await EdgarSecService.getFinancialStatementsForSymbol('GOOG');

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
    final otherNonOperatingIncomeExpenseBillions =
        income2021.otherNonOperatingIncomeExpense.billions;
    final incomeTaxExpenseBillions = income2021.incomeTaxExpense.billions;

    final ebitBillions = income2021.EBIT.billions;
    assert(ebitBillions == operatingIncomeBillions);

    assert(revenueBillions == 257.637);
    assert(operatingIncomeBillions == 78.714);
    assert(netIncomeBillions == 76.033);
    assert(costOfRevenueBillions == 110.939);

    assert(grossProfitBillions == 146.698);
    assert(sellingGeneralAdministrativeBillions == 36.422);
    assert(researchDevelopmentBillions == 31.562);
    assert(operatingExpenseBillions == 67.984);

    assert(interestExpensesBillions == 0.346);

    //TODO why is wrong?
    // assert(otherNonOperatingIncomeExpenseBillions == -1.497);
    assert(incomeTaxExpenseBillions == 14.701);

    // Check derived values
    final netMargin = income2021.netMargin;
    final operatingMargin = income2021.operatingMargin;

    assert(netMargin.toStringAsFixed(4) == '0.2951');
    assert(operatingMargin.toStringAsFixed(4) == '0.3055');
  });

  /// Come to this url to get the correct values for the test
  /// https://seekingalpha.com/symbol/GOOG/cash-flow-statement
  /// https://www.sec.gov/Archives/edgar/data/1652044/000165204423000016/goog-20221231.htm#ia96e4fb0476549c99dc3a2b2368f643f_343
  test('Test 2021 Google values for cash flow', () async {
    final CompanyResults results =
        await EdgarSecService.getFinancialStatementsForSymbol('GOOG');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2021 = results.yearlyResults[2021]!;

    assert(results2021.fullYear != null);

    final CashFlowStatement cashFlowStatement2021 =
        results2021.fullYear!.cashFlowStatement;

    final repurchaseofCommonStockBillions =
        cashFlowStatement2021.buyback.billions;

    final dividends = cashFlowStatement2021.dividends.billions;

    final sharedBasedCompensationBillions =
        cashFlowStatement2021.shareBasedCompensation.billions;
    final capitalExpendituresBillions =
        cashFlowStatement2021.capitalExpenditures.billions;
    final cashFromOperationsBillions =
        cashFlowStatement2021.cashFromOperations.billions;

    assert(repurchaseofCommonStockBillions == 50.274);
    assert(dividends == 0);
    assert(sharedBasedCompensationBillions == 15.376);
    assert(capitalExpendituresBillions == 24.64);
    assert(cashFromOperationsBillions == 91.652);
  });
}
