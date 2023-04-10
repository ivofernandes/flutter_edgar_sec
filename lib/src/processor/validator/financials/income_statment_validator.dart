import 'package:flutter_edgar_sec/src/model/financials/income_statement.dart';
import 'package:flutter_edgar_sec/src/utils/app_logger.dart';

class IncomeStatementValidator {
  static void validate(IncomeStatement incomeStatement) {
    _validateTotalOperatingExpenses(incomeStatement);

    _validateGrossProfit(incomeStatement);

    _validateCostOfRevenue(incomeStatement);
  }

  static void _validateGrossProfit(IncomeStatement incomeStatement) {
    if (incomeStatement.grossProfit == 0) {
      if (incomeStatement.costOfRevenues != 0 && incomeStatement.revenues != 0) {
        incomeStatement.grossProfit = incomeStatement.revenues - incomeStatement.costOfRevenues;
      } else if (incomeStatement.revenues != 0 && incomeStatement.operatingIncome != 0) {
        // Gross Profit = Operating Income + R&D + General & Admin Expenses
        incomeStatement.grossProfit = incomeStatement.operatingIncome + incomeStatement.totalOperatingExpenses;
      } else {
        AppLogger().error('Unable to calculate grossProfit. Because costOfRevenues or revenues are 0');
      }
    }
  }

  static void _validateCostOfRevenue(IncomeStatement incomeStatement) {
    if (incomeStatement.costOfRevenues != 0) {
      // Nothing to validate
      return;
    }

    if (incomeStatement.grossProfit != 0 && incomeStatement.revenues != 0) {
      incomeStatement.costOfRevenues = incomeStatement.revenues - incomeStatement.grossProfit;
    } else {
      AppLogger().error('Unable to calculate costOfRevenues. Because grossProfit or revenues are 0');
    }
  }

  static void _validateTotalOperatingExpenses(IncomeStatement incomeStatement) {
    if (incomeStatement.totalOperatingExpenses != 0) {
      // Nothing to validate
      return;
    }

    if (incomeStatement.grossProfit != 0 && incomeStatement.operatingIncome != 0) {
      incomeStatement.totalOperatingExpenses = incomeStatement.grossProfit - incomeStatement.operatingIncome;
    }
    // Try to sum all the expenses
    if (incomeStatement.researchAndDevelopmentExpenses != 0 || incomeStatement.generalAndAdministrativeExpenses != 0) {
      final double rndAndAdmin =
          incomeStatement.researchAndDevelopmentExpenses + incomeStatement.generalAndAdministrativeExpenses;
      final double otherOperatingExpenses =
          incomeStatement.amortizationOfIntangibles + incomeStatement.acquisitionCosts + incomeStatement.restructuring;
      incomeStatement.totalOperatingExpenses = rndAndAdmin + otherOperatingExpenses;
    } else {
      AppLogger().error('Unable to calculate totalOperatingExpenses. Because grossProfit or operatingIncome are 0');
    }
  }
}
