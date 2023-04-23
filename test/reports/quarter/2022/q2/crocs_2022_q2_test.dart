import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_test/flutter_test.dart';

/// Come to this url and select the quarterly period to
/// https://seekingalpha.com/symbol/CROX/income-statement
/// https://www.sec.gov/ix?doc=/Archives/edgar/data/0001334036/000133403622000117/crox-20220630.htm
void main() {
  test('Test 2022-Q2 Google values for income statement', () async {
    final CompanyResults results = await EdgarSecService.getFinancialStatementsForSymbol('CROX');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.q2 != null);
    final IncomeStatement income2022Q2 = results2022.q2!.incomeStatement;

    final revenueBillions = income2022Q2.revenues.billions;
    final operatingIncomeBillions = income2022Q2.operatingIncome.billions;
    final netIncomeBillions = income2022Q2.netIncome.billions;
    final costOfRevenueBillions = income2022Q2.costOfRevenues.billions;

    final foreignCurrencyTransactionGainLoss = income2022Q2.foreignCurrencyExchange.billions;

    assert(revenueBillions == 0.964581);
    assert(operatingIncomeBillions == 0.247964);
    assert(netIncomeBillions == 0.160315);
    // It's wrong on seeking alpha, check in the 10-Q of SEC
    assert(costOfRevenueBillions == 0.466848);

    assert(foreignCurrencyTransactionGainLoss == -0.001202);
  });
}
