import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/model/r2_yearly_results.dart';
import 'package:flutter_test/flutter_test.dart';

/// Come to this url and select the quarterly period to
/// https://seekingalpha.com/symbol/CROX/income-statement
void main() {
  test('Test 2022-Q3 Crocs values for income statement', () async {
    final CompanyResults results = await EdgarSecService.getFinancialStatementsForSymbol('CROX');

    assert(results.yearlyResults.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.q3 != null);
    final IncomeStatement income2022Q3 = results2022.q3!.incomeStatement;

    final revenueBillions = income2022Q3.revenues.billions;
    final operatingIncomeBillions = income2022Q3.operatingIncome.billions;
    final netIncomeBillions = income2022Q3.netIncome.billions;
    final costOfRevenueBillions = income2022Q3.costOfRevenues.billions;

    assert(revenueBillions == 0.985094);
    assert(operatingIncomeBillions == 0.264063);
    assert(netIncomeBillions == 0.169349);
    assert(costOfRevenueBillions == 0.443792);
  });
}
