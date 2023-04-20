import 'package:flutter_edgar_sec/src/utils/number_utils.dart';

class CashFlowStatement {
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
  ];

  double get totalShareholderReturn => buyback + dividends;

  String getValueForIndex(int index) {
    final double value = getDoubleValueForIndex(index);
    return value.reportFormat;
  }

  double getDoubleValueForIndex(int index) {
    final String name = labels[index];
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
      default:
        return 0;
    }
  }

  /// Operations
  double accumulatedDepreciation = 0;
  double shareBasedCompensation = 0;
  double depreciationAndAmortization = 0;
  double deferredIncomeTax = 0;
  double cashFromOperations = 0;

  /// Financing
  double buyback = 0;
  double dividends = 0;
  double cashFromFinancing = 0;

  /// Investing
  double capitalExpenditures = 0;
  double cashFromInvesting = 0;

  CashFlowStatement();

  @override
  String toString() => '''
  buyBacks: $buyback
  dividends: $dividends
  shareBasedCompensation: $shareBasedCompensation
  accumulatedDepreciation: $accumulatedDepreciation
  capitalExpenditures: $capitalExpenditures
  depreciationAndAmortization: $depreciationAndAmortization
  cashFromOperations: $cashFromOperations
  cashFromInvesting: $cashFromInvesting
  cashFromFinancing: $cashFromFinancing
  deferredIncomeTax: $deferredIncomeTax
  ''';
}
