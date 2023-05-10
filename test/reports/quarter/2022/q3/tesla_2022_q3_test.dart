import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_test/flutter_test.dart';

/// Come to this url and select the quarterly period to
/// https://seekingalpha.com/symbol/TSLA/income-statement
/// https://www.sec.gov/ix?doc=/Archives/edgar/data/0001318605/000095017022019867/tsla-20220930.htm
void main() {
  test('Test 2022-Q3 Tesla values for income statement', () async {
    final CompanyResults results = await EdgarSecService.getFinancialStatementsForSymbol('TSLA');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.q3 != null);
    final IncomeStatement income2022Q3 = results2022.q3!.incomeStatement;

    final revenueBillions = income2022Q3.revenues.billions;
    final operatingIncomeBillions = income2022Q3.operatingIncome.billions;
    final netIncomeBillions = income2022Q3.netIncome.billions;
    final costOfRevenueBillions = income2022Q3.costOfRevenues.billions;

    assert(revenueBillions == 21.454);
    assert(operatingIncomeBillions == 3.688);
    assert(netIncomeBillions == 3.292);
    assert(costOfRevenueBillions == 16.072);

    final eps = income2022Q3.eps;
    final epsDiluted = income2022Q3.epsDiluted;
    assert(eps == 1.05);
    assert(epsDiluted == 0.95);
  });

  test('Test 2022-Q3 Tesla values for income statement', () async {
    final CompanyResults results = await EdgarSecService.getFinancialStatementsForSymbol('TSLA');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.q3 != null);
    final BalanceSheet balanceSheet = results2022.q3!.balanceSheet;

    final totalAssetsBillions = balanceSheet.totalAssets.billions;
    final totalLiabilitiesBillions = balanceSheet.totalLiabilities.billions;
  });
}
