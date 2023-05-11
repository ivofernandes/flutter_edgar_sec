import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_test/flutter_test.dart';

/// Come to this url and select the quarterly period to
/// https://seekingalpha.com/symbol/BIDU/income-statement
/// https://ir.baidu.com/node/13451/html
///
void main() {
  test('Test 2021 Baidu values for income statement', () async {
    final CompanyResults results = await EdgarSecService.getFinancialStatementsForSymbol('BIDU');

    final YearlyResults results2021 = results.yearlyResults[2021]!;

    assert(results2021.fullYear != null);

    final IncomeStatement income2022 = results2021.fullYear!.incomeStatement;

    final revenueBillions = income2022.revenues.billions;
    final operatingIncomeBillions = income2022.operatingIncome.billions;
    final netIncomeBillions = income2022.netIncome.billions;
    final costOfRevenueBillions = income2022.costOfRevenues.billions;

    assert(revenueBillions == 19.536);
    assert(costOfRevenueBillions == 10.092);
    assert(operatingIncomeBillions == 1.651);
    assert(netIncomeBillions == 1.605);

    final researchAndDevelopmentBillions = income2022.researchAndDevelopmentExpenses.billions;
    final sellingGeneralAndAdminBillions = income2022.generalAndAdministrativeExpenses.billions;

    assert(researchAndDevelopmentBillions == 3.914);
    assert(sellingGeneralAndAdminBillions == 3.879);
  });
}
