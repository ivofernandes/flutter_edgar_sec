import 'package:flutter_edgar_sec/src/utils/number_utils.dart';

class CashFlowStatement {
  static List<String> labels = [
    'Buybacks',
    'Dividends',
    'Share Based Compensation',
    'Accumulated Depreciation',
    'Capital Expenditures',
  ];

  String getValueForIndex(int index) {
    final String name = labels[index];
    switch (name) {
      case 'Buybacks':
        return buyback.reportFormat;
      case 'Dividends':
        return dividends.reportFormat;
      case 'Share Based Compensation':
        return shareBasedCompensation.reportFormat;
      case 'Accumulated Depreciation':
        return accumulatedDepreciation.reportFormat;
      case 'Capital Expenditures':
        return capitalExpenditures.reportFormat;
      default:
        return '';
    }
  }

  double buyback = 0;
  double dividends = 0;
  double shareBasedCompensation = 0;
  double accumulatedDepreciation = 0;
  double capitalExpenditures = 0;

  CashFlowStatement();

  @override
  String toString() => '''
  buyBacks: $buyback
  dividends: $dividends
  shareBasedCompensation: $shareBasedCompensation
  accumulatedDepreciation: $accumulatedDepreciation
  capitalExpenditures: $capitalExpenditures
  ''';
}
