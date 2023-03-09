import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_edgar_sec/src/model/financials/balance_sheet.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Come to this url to get the correct values for the test
  /// https://seekingalpha.com/symbol/AAPL/income-statement
  test('Test 2022 apple values for income statement', () async {
    final CompanyResults results = await EdgarSecService.getFinancialStatementsForSymbol('AAPL');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.fullYear != null);
    final IncomeStatement income2022 = results2022.fullYear!.incomeStatement;
    final BalanceSheet balance2022 = results2022.fullYear!.balanceSheet;

    final revenueBillions = income2022.revenues.billions;
    final operatingIncomeBillions = income2022.operatingIncome.billions;
    final netIncomeBillions = income2022.netIncome.billions;
    final costOfRevenueBillions = income2022.costOfRevenues.billions;

    final grossProfitBillions = income2022.grossProfit.billions;
    final sellingGeneralAdministrativeBillions = income2022.sellingGeneralAndAdministrativeExpenses.billions;
    final researchDevelopmentBillions = income2022.researchAndDevelopmentExpenses.billions;
    final operatingExpenseBillions = income2022.operatingExpenses.billions;

    // BalanceSheet's fields
    final cashAndCashEquivalents = balance2022.cashAndCashEquivalents.billions;
    final shortTermInvestments = balance2022.shortTermInvestments.billions;
    final tradingAssetSecurities = balance2022.tradingAssetSecurities.billions;

    final accountsReceivable = balance2022.accountsReceivable.billions;


    // Income Statement's asserts
    assert(revenueBillions == 394.328);
    assert(operatingIncomeBillions == 119.437);
    assert(netIncomeBillions == 99.803);
    assert(costOfRevenueBillions == 223.546);

    assert(grossProfitBillions == 170.782);
    assert(sellingGeneralAdministrativeBillions == 25.094);
    assert(researchDevelopmentBillions == 26.251);
    assert(operatingExpenseBillions == 51.345);

    // BalanceSheet's asserts
    // Cash n Equivalents
    assert(cashAndCashEquivalents == 23.646);
    assert(shortTermInvestments == 24.658);
    // assert(tradingAssetSecurities == ????);

    // Receivables
    assert(accountsReceivable == 28.184);

    // Check derivated values
    final netMargin = income2022.netMargin;
    final operatingMargin = income2022.operatingMargin;

    //TODO how to get correct data for this margins?
    // Seeking alpha just gest TTM data
    // https://seekingalpha.com/symbol/AAPL/profitability
  });
}
