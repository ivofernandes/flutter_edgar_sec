import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
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

    final revenueBillions = income2022.revenues.billions;
    final operatingIncomeBillions = income2022.operatingIncome.billions;
    final netIncomeBillions = income2022.netIncome.billions;
    final costOfRevenueBillions = income2022.costOfRevenues.billions;

    assert(revenueBillions == 394.328);
    assert(operatingIncomeBillions == 119.437);
    assert(netIncomeBillions == 99.803);
    assert(costOfRevenueBillions == 223.546);

    // Check derivated values
    final netMargin = income2022.netMargin;
    final operatingMargin = income2022.operatingMargin;

    //TODO how to get correct data for this margins?
    // Seeking alpha just gest TTM data
    // https://seekingalpha.com/symbol/AAPL/profitability
  });
}
