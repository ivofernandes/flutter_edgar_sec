import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_edgar_sec/src/model/financials/cash_flow_statement.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Come to this url to get the correct values for the test
  /// https://seekingalpha.com/symbol/CROX/income-statement
  /// https://d18rn0p25nwr6d.cloudfront.net/CIK-0001334036/f61c8670-c9e2-4aab-bf47-374a5ab5092b.html#
  test('Test 2022 Crocs values for income statement', () async {
    final CompanyResults results = await EdgarSecService.getFinancialStatementsForSymbol('CROX');

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

    assert(revenueBillions == 3.554985);
    assert(operatingIncomeBillions == 0.850756);
    assert(netIncomeBillions == 0.540159);
    assert(costOfRevenueBillions == 1.694703);

    assert(grossProfitBillions == 1.860282);
    assert(sellingGeneralAdministrativeBillions == 1.009526);
    assert(researchDevelopmentBillions == 0.0);
    assert(operatingExpenseBillions == 1.009526);

    assert(interestExpensesBillions == 0.136158);
    assert(otherNonOperatingIncomeExpenseBillions == -0.000338);
    assert(incomeTaxExpenseBillions == 0.178349);

    // Check derivated values
    final netMargin = income2022.netMargin;
    final operatingMargin = income2022.operatingMargin;

    assert(netMargin.toStringAsFixed(4) == '0.1519');
    assert(operatingMargin.toStringAsFixed(4) == '0.2393');
  });

  /// Come to this url to get the correct values for the test
  /// https://seekingalpha.com/symbol/CROX/cash-flow-statement
  test('Test 2022 Crocs values for cash flow', () async {
    final CompanyResults results = await EdgarSecService.getFinancialStatementsForSymbol('CROX');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2021 = results.yearlyResults[2022]!;

    assert(results2021.fullYear != null);

    final CashFlowStatement cashFlowStatement2021 = results2021.fullYear!.cashFlowStatement;

    final repurchaseofCommonStockBillions = cashFlowStatement2021.buyback.billions;

    final dividends = cashFlowStatement2021.dividends.billions;

    final sharedBasedCompensationBillions = cashFlowStatement2021.shareBasedCompensation.billions;
    final accumulatedDepreciationBillions = cashFlowStatement2021.accumulatedDepreciation.billions;
    final capitalExpendituresBillions = cashFlowStatement2021.capitalExpenditures.billions;

    //assert(repurchaseofCommonStockBillions == 0.0115);
    assert(dividends == 0);
    assert(sharedBasedCompensationBillions == 0.031303);
    assert(capitalExpendituresBillions == 0.10419);
  });
}
