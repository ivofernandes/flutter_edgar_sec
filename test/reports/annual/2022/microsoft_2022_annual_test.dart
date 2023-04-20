import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_edgar_sec/src/model/financials/cash_flow_statement.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// https://seekingalpha.com/symbol/MSFT/income-statement
  test('Test 2022 Microsoft values for income statement', () async {
    final CompanyResults results = await EdgarSecService.getFinancialStatementsForSymbol('MSFT');

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

    assert(revenueBillions == 198.27);
    assert(operatingIncomeBillions == 83.383);
    assert(netIncomeBillions == 72.738);
    assert(costOfRevenueBillions == 62.65);

    assert(grossProfitBillions == 135.62);
    assert(sellingGeneralAdministrativeBillions == 27.725);
    assert(researchDevelopmentBillions == 24.512);

    assert(interestExpensesBillions == 2.063);
    assert(incomeTaxExpenseBillions == 10.978);

    // Check derived values
    final netMargin = income2022.netMargin;
    final operatingMargin = income2022.operatingMargin;

    assert(netMargin.toStringAsFixed(4) == '0.3669');
    assert(operatingMargin.toStringAsFixed(4) == '0.4206');
  });

  /// Come to this url to get the correct values for the test
  /// https://seekingalpha.com/symbol/MSFT/cash-flow-statement
  test('Test 2022 Microsoft values for cash flow', () async {
    final CompanyResults results = await EdgarSecService.getFinancialStatementsForSymbol('MSFT');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.fullYear != null);

    final CashFlowStatement cashFlowStatement2022 = results2022.fullYear!.cashFlowStatement;

    final repurchaseofCommonStockBillions = cashFlowStatement2022.buyback.billions;

    final dividends = cashFlowStatement2022.dividends.billions;

    final sharedBasedCompensationBillions = cashFlowStatement2022.shareBasedCompensation.billions;
    final capitalExpendituresBillions = cashFlowStatement2022.capitalExpenditures.billions;
    final cashFromOperationsBillions = cashFlowStatement2022.cashFromOperations.billions;
    final cashFromInvestingBillions = cashFlowStatement2022.cashFromInvesting.billions;
    final depreciationBillions = cashFlowStatement2022.depreciationAndAmortization.billions;
    final cashFromFinancingBillions = cashFlowStatement2022.cashFromFinancing.billions;

    assert(repurchaseofCommonStockBillions == 32.696);
    assert(dividends == 18.135);
    assert(sharedBasedCompensationBillions == 7.502);
    assert(capitalExpendituresBillions == 23.886);
    assert(cashFromOperationsBillions == 89.035);
    assert(cashFromInvestingBillions == -30.311);
    assert(cashFromFinancingBillions == -58.876);
  });
}
