import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_edgar_sec/src/model/financials/cash_flow_statement.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Come to this url to get the correct values for the test
  /// https://seekingalpha.com/symbol/META/income-statement
  ///
  /// SEC:
  /// https://www.sec.gov/Archives/edgar/data/1326801/000132680122000018/fb-20211231.htm
  test('Test 2021 Meta values for income statement', () async {
    final CompanyResults results =
        await EdgarSecService.getFinancialStatementsForSymbol('META');

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

    assert(revenueBillions == 117.929);
    assert(operatingIncomeBillions == 46.753);
    assert(netIncomeBillions == 39.37);
    assert(costOfRevenueBillions == 22.649);

    assert(grossProfitBillions == 95.280);
    assert(sellingGeneralAdministrativeBillions == 23.872);
    assert(researchDevelopmentBillions == 24.655);
    assert(operatingExpenseBillions == 48.934);

    //assert(interestExpensesBillions == 0);

    //TODO why is wrong?
    // assert(otherNonOperatingIncomeExpenseBillions == -1.497);
    //assert(incomeTaxExpenseBillions == 7.914);

    // Check derived values
    final netMargin = income2021.netMargin;
    final operatingMargin = income2021.operatingMargin;

    assert(netMargin.toStringAsFixed(4) == '0.3338');
    assert(operatingMargin.toStringAsFixed(4) == '0.3965');
  });

  /// Come to this url to get the correct values for the test
  /// https://seekingalpha.com/symbol/META/cash-flow-statement
  /// https://www.sec.gov/Archives/edgar/data/1326801/000132680122000018/fb-20211231.htm#i0e2f35c4e2f2407493e331b6cc85a047_97
  test('Test 2021 Meta values for cash flow', () async {
    final CompanyResults results =
        await EdgarSecService.getFinancialStatementsForSymbol('META');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2021 = results.yearlyResults[2021]!;

    assert(results2021.fullYear != null);

    final CashFlowStatement cashFlowStatement2021 =
        results2021.fullYear!.cashFlowStatement;

    final repurchaseofCommonStockBillions =
        cashFlowStatement2021.buyback.billions;
    final capitalExpendituresBillions =
        cashFlowStatement2021.capitalExpenditures.billions;
    final shareBasedCompensationBillions =
        cashFlowStatement2021.shareBasedCompensation.billions;
    final depreciationAndAmortizationBillions =
        cashFlowStatement2021.depreciationAndAmortization.billions;

    final dividends = cashFlowStatement2021.dividends.billions;
    assert(repurchaseofCommonStockBillions == 44.537);
    assert(capitalExpendituresBillions == 18.567);
    assert(shareBasedCompensationBillions == 9.164);
    assert(depreciationAndAmortizationBillions == 7.967);

    assert(dividends == 0);
  });
}
