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

  factory CashFlowStatement.fromJson(Map<String, dynamic> json) => CashFlowStatement()
    ..buyback = json['buyback'] as double
    ..dividends = json['dividends'] as double
    ..shareBasedCompensation = json['shareBasedCompensation'] as double
    ..accumulatedDepreciation = json['accumulatedDepreciation'] as double
    ..capitalExpenditures = json['capitalExpenditures'] as double
    ..depreciationAndAmortization = json['depreciationAndAmortization'] as double
    ..cashFromOperations = json['cashFromOperations'] as double
    ..cashFromInvesting = json['cashFromInvesting'] as double
    ..cashFromFinancing = json['cashFromFinancing'] as double
    ..deferredIncomeTax = json['deferredIncomeTax'] as double
    ..buyMarketableSecurities = json['buyMarketableSecurities'] as double
    ..sellMarketableSecurities = json['sellMarketableSecurities'] as double;

  Map<String, dynamic> toJson() => {
        'buyback': buyback,
        'dividends': dividends,
        'shareBasedCompensation': shareBasedCompensation,
        'accumulatedDepreciation': accumulatedDepreciation,
        'capitalExpenditures': capitalExpenditures,
        'depreciationAndAmortization': depreciationAndAmortization,
        'cashFromOperations': cashFromOperations,
        'cashFromInvesting': cashFromInvesting,
        'cashFromFinancing': cashFromFinancing,
        'deferredIncomeTax': deferredIncomeTax,
        'buyMarketableSecurities': buyMarketableSecurities,
        'sellMarketableSecurities': sellMarketableSecurities,
      };
}
