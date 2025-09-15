import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';
import 'package:flutter_test/flutter_test.dart';

/// Come to this url and select the quarterly period to
/// https://seekingalpha.com/symbol/FTCH/income-statement
///
/// https://d18rn0p25nwr6d.cloudfront.net/CIK-0001740915/48011e53-ebdd-4c7c-bf13-7f76f9607f49.html#
void main() {
  test('Test 2022 Farfetch values for income statement', () async {
    final CompanyResults results =
        await EdgarSecService.getFinancialStatementsForSymbol('FTCH');

    assert(results.years.isNotEmpty);

    final YearlyResults results2022 = results.yearlyResults[2022]!;

    assert(results2022.fullYear != null);

    final IncomeStatement income2022 = results2022.fullYear!.incomeStatement;

    final revenueBillions = income2022.revenues.billions;
    //final operatingIncomeBillions = income2022.operatingIncome.billions;
    final netIncomeBillions = income2022.netIncome.billions;
    final costOfRevenueBillions = income2022.costOfRevenues.billions;

    assert(revenueBillions == 2.31668);
    assert(costOfRevenueBillions == 1.293505);
    assert(netIncomeBillions == 0.344855);

    final generalAndAdministrativeBillions =
        income2022.generalAndAdministrativeExpenses.billions;
    final researchAndDevelopmentBillions =
        income2022.researchAndDevelopmentExpenses.billions;

    assert(generalAndAdministrativeBillions == 1.733603);
    assert(researchAndDevelopmentBillions == 0.000010307);

    final double eps = income2022.eps;
    final double epsDiluted = income2022.epsDiluted;
    final sharesBillions = income2022.shares.billions;

    assert(eps == 0.93);
    assert(epsDiluted == -1.85);
    assert(sharesBillions == 0.384986092);
  });
}
