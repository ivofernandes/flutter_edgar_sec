import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_test/flutter_test.dart';

/// Come to this url and select the quarterly period to
/// https://seekingalpha.com/symbol/TSM/income-statement
void main() {
  test('Test 2022 TSMC values for income statement', () async {
    final CompanyResults results =
        await EdgarSecService.getFinancialStatementsForSymbol('TSM');

    assert(results.years.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;
    assert(results2022.fullYear != null);

    final IncomeStatement income2022 = results2022.fullYear!.incomeStatement;

    final revenueBillions = income2022.revenues.billions;
    //final operatingIncomeBillions = income2022.operatingIncome.billions;
    //final netIncomeBillions = income2022.netIncome.billions;
    //final costOfRevenueBillions = income2022.costOfRevenues.billions;

    assert(revenueBillions == 73.6704);
  });
}
