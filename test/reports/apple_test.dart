import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Come to this url and select the quarterly period to
  /// https://seekingalpha.com/symbol/AAPL/income-statement
  test('Test 2022-Q4 apple values for income statement', () async {
    final CompanyResults results = await EdgarSecService.getFinancialStatementsForSymbol('AAPL');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.q4 != null);
    final IncomeStatement income2022Q4 = results2022.q4!.incomeStatement;

    final revenueBillions = income2022Q4.revenues.billions;
    final operatingIncomeBillions = income2022Q4.operatingIncome.billions;
    final netIncomeBillions = income2022Q4.netIncome.billions;
    final costOfRevenueBillions = income2022Q4.costOfRevenues.billions;

    assert(revenueBillions == 117.154);
    assert(operatingIncomeBillions == 36.016);
    assert(netIncomeBillions == 29.998);
    assert(costOfRevenueBillions == 66.822);

    // Check derivated values
    final netMargin = income2022Q4.netMargin;
    final operatingMargin = income2022Q4.operatingMargin;

    //TODO how to get correct data for this margins?
    // Seeking alpha just gest TTM data
    // https://seekingalpha.com/symbol/AAPL/profitability
  });
}
