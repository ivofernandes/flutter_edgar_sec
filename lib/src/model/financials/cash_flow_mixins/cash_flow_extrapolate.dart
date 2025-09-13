import 'package:flutter_edgar_sec/src/model/financials/cash_flow_statement.dart';

class CashFlowExtrapolate {
  static void fillMissingQuarter(
    CashFlowStatement cashFlowStatement,
    CashFlowStatement fullYear,
    CashFlowStatement qa,
    CashFlowStatement qb,
    CashFlowStatement qc,
  ) {
    /// Operations
    cashFlowStatement.accumulatedDepreciation =
        fullYear.accumulatedDepreciation -
            qc.accumulatedDepreciation -
            qb.accumulatedDepreciation -
            qa.accumulatedDepreciation;

    cashFlowStatement.shareBasedCompensation = fullYear.shareBasedCompensation -
        qc.shareBasedCompensation -
        qb.shareBasedCompensation -
        qa.shareBasedCompensation;

    cashFlowStatement.depreciationAndAmortization =
        fullYear.depreciationAndAmortization -
            qc.depreciationAndAmortization -
            qb.depreciationAndAmortization -
            qa.depreciationAndAmortization;

    cashFlowStatement.deferredIncomeTax = fullYear.deferredIncomeTax -
        qc.deferredIncomeTax -
        qb.deferredIncomeTax -
        qa.deferredIncomeTax;

    cashFlowStatement.cashFromOperations = fullYear.cashFromOperations -
        qc.cashFromOperations -
        qb.cashFromOperations -
        qa.cashFromOperations;

    /// Financing
    cashFlowStatement.buyback =
        fullYear.buyback - qc.buyback - qb.buyback - qa.buyback;

    cashFlowStatement.dividends =
        fullYear.dividends - qc.dividends - qb.dividends - qa.dividends;

    cashFlowStatement.cashFromFinancing = fullYear.cashFromFinancing -
        qc.cashFromFinancing -
        qb.cashFromFinancing -
        qa.cashFromFinancing;

    /// Investing
    cashFlowStatement.capitalExpenditures = fullYear.capitalExpenditures -
        qc.capitalExpenditures -
        qb.capitalExpenditures -
        qa.capitalExpenditures;

    cashFlowStatement.buyMarketableSecurities =
        fullYear.buyMarketableSecurities -
            qc.buyMarketableSecurities -
            qb.buyMarketableSecurities -
            qa.buyMarketableSecurities;

    cashFlowStatement.sellMarketableSecurities =
        fullYear.sellMarketableSecurities -
            qc.sellMarketableSecurities -
            qb.sellMarketableSecurities -
            qa.sellMarketableSecurities;

    cashFlowStatement.cashFromInvesting = fullYear.cashFromInvesting -
        qc.cashFromInvesting -
        qb.cashFromInvesting -
        qa.cashFromInvesting;
  }
}
