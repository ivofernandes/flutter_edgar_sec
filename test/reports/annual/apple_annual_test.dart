import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Come to this url to get the correct values for the test
  /// Official source for the financial data -> https://www.apple.com/newsroom/pdfs/FY23_Q1_Consolidated_Financial_Statements.pdf
  /// https://seekingalpha.com/symbol/AAPL/income-statement
  /// https://www.sec.gov/ix?doc=/Archives/edgar/data/320193/000032019322000108/aapl-20220924.htm
  test('Test 2022 apple values for income statement', () async {
    final CompanyResults results =
        await EdgarSecService.getFinancialStatementsForSymbol('AAPL');

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
    final sellingGeneralAdministrativeBillions =
        income2022.generalAndAdministrativeExpenses.billions;
    final researchDevelopmentBillions =
        income2022.researchAndDevelopmentExpenses.billions;
    final operatingExpenseBillions = income2022.operatingExpenses.billions;

    // -------------- BalanceSheet's fields --------------------- //

    // Cash and Equivalents
    final cashAndCashEquivalents = balance2022.cashAndCashEquivalents.billions;
    final shortTermInvestments = balance2022.shortTermInvestments.billions;
    //final tradingAssetSecurities = balance2022.tradingAssetSecurities.billions;
    final totalCashAndCashEquivalents =
        balance2022.totalCashAndShortTermInvestments.billions;

    // Receivables
    final accountsReceivable = balance2022.accountsReceivable.billions;
    final otherReceivables = balance2022.otherReceivables.billions;

    // Current Assets
    final inventory = balance2022.inventory.billions;
    final deferredTaxAssets = balance2022.deferredTaxAssets.billions;
    final restrictedCash = balance2022.restrictedCash.billions;
    final otherCurrentAssets = balance2022.otherCurrentAssets.billions;

    final totalCurrentAssets = balance2022.currentAssets.billions;

    // Long Term Assets
    //final grossPropertyPlantEquipment = balance2022.grossPropertyPlantEquipment.billions;
    final accumulatedDepreciation =
        balance2022.accumulatedDepreciation.billions;
    final netPropertyPlantEquipment =
        balance2022.netPropertyPlantEquipment.billions;
    final longTermInvestments = balance2022.longTermInvestments.billions;
    final goodwill = balance2022.goodwill.billions;
    final otherIntangibles = balance2022.otherIntangibles.billions;
    final otherLongTermAssets = balance2022.otherLongTermAssets.billions;
    final totalAssets = balance2022.totalAssets.billions;

    // Current Liabilities
    final accountsPayable = balance2022.accountsPayable.billions;
    final accruedExpenses = balance2022.accruedExpenses.billions;
    final shortTermBorrowings = balance2022.shortTermBorrowings.billions;
    final currentPortionLtDebt = balance2022.currentPortionLtDebt.billions;
    final unearnedRevenueCurrent = balance2022.unearnedRevenueCurrent.billions;

    // -------------------------------------- //

    // Income Statement's asserts
    final interestExpensesBillions = income2022.interestExpenses.billions;
    //final otherNonOperatingIncomeExpenseBillions = income2022.otherNonOperatingIncomeExpense.billions;
    final incomeTaxExpenseBillions = income2022.incomeTaxExpense.billions;

    final ebitBillions = income2022.EBIT.billions;
    assert(ebitBillions == operatingIncomeBillions);

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
    //FIXME - NF - it will be wrong for the years that have tradingAssetSecurities
    assert(totalCashAndCashEquivalents == 48.304);

    // Receivables
    assert(accountsReceivable == 28.184);
    assert(otherReceivables == 32.748);

    // Current Assets
    assert(inventory == 4.946);
    assert(deferredTaxAssets == 0); // no deferredTaxAssets for the year 2022
    assert(restrictedCash == 0); // no restrictedCash for the year 2022
    assert(otherCurrentAssets == 21.223);
    assert(totalCurrentAssets == 135.405);

    // Long Term Assets
    //assert(grossPropertyPlantEquipment == 124.874);
    assert(accumulatedDepreciation == 72.340);
    assert(netPropertyPlantEquipment == 42.117);
    assert(longTermInvestments == 120.805);
    assert(goodwill == 0);
    assert(otherIntangibles == 0);
    assert(otherLongTermAssets == 54.428);

    // Total Assets
    assert(totalAssets == 352.755);

    // Current Liabilities
    assert(accountsPayable == 64.115);
    assert(accruedExpenses == 0);
    assert(shortTermBorrowings == 9.982);
    assert(currentPortionLtDebt == 11.128);
    assert(unearnedRevenueCurrent == 7.912);

    assert(interestExpensesBillions == 2.931);
    //assert(otherNonOperatingIncomeExpenseBillions == -0.228);
    assert(incomeTaxExpenseBillions == 19.3);

    // Check derived values
    final netMargin = income2022.netMargin;
    final operatingMargin = income2022.operatingMargin;

    assert(netMargin.toStringAsFixed(4) == '0.2531');
    assert(operatingMargin.toStringAsFixed(4) == '0.3029');
  });
}
