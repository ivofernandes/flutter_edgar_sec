import 'package:flutter_edgar_sec/src/model/financials/cash_flow_mixins/cash_flow_extrapolate.dart';
import 'package:flutter_edgar_sec/src/model/financials/cash_flow_mixins/cash_flow_values.dart';
import 'package:flutter_edgar_sec/src/utils/number_utils.dart';

class CashFlowStatement with CashFlowValues {
  static List<String> labels = [
    'Buybacks',
    'Dividends',
    'Share Based Compensation',
    'Accumulated Depreciation',
    'Capital Expenditures',
    'Depreciation & Amortization',
    'Cash from Operations',
    'Cash from Investing',
    'Cash from Financing',
    'Deferred Income Tax',
    'Buy Securities',
    'Sell Securities',
  ];

  CashFlowStatement();

  factory CashFlowStatement.extrapolate(
    CashFlowStatement fullYear,
    CashFlowStatement q1,
    CashFlowStatement q2,
    CashFlowStatement q3,
  ) {
    final CashFlowStatement cashFlowStatement = CashFlowStatement();

    CashFlowExtrapolate.fillMissingQuarter(cashFlowStatement, fullYear, q1, q2, q3);

    return cashFlowStatement;
  }

  double get totalShareholderReturn => buyback + dividends;

  String getValueForIndex(int index) {
    final double? value = getDoubleValueForIndex(index);
    return value?.reportFormat ?? '';
  }

  double? getDoubleValueForIndex(int index) {
    final String name = labels[index];

    return getValueForLabel(name);
  }

  double? getValueForLabel(String name) {
    switch (name) {
      case 'Buybacks':
        return buyback;
      case 'Dividends':
        return dividends;
      case 'Share Based Compensation':
        return shareBasedCompensation;
      case 'Accumulated Depreciation':
        return accumulatedDepreciation;
      case 'Capital Expenditures':
        return capitalExpenditures;
      case 'Depreciation & Amortization':
        return depreciationAndAmortization;
      case 'Cash from Operations':
        return cashFromOperations;
      case 'Cash from Investing':
        return cashFromInvesting;
      case 'Cash from Financing':
        return cashFromFinancing;
      case 'Deferred Income Tax':
        return deferredIncomeTax;
      case 'Buy Securities':
        return buyMarketableSecurities;
      case 'Sell Securities':
        return sellMarketableSecurities;
      default:
        return null;
    }
  }

  factory CashFlowStatement.fromJson(json) {
    //TODO map values
    return CashFlowStatement();
  }

  Map<String, dynamic> toJson() {
    //TODO map values
    return {};
  }
}
