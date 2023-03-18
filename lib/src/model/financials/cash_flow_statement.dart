import 'package:flutter_edgar_sec/src/utils/number_utils.dart';

class CashFlowStatement {
  static List<String> labels = [
    'Buybacks',
    'Dividends',
  ];

  String getValueForIndex(int index) {
    final String name = labels[index];
    switch (name) {
      case 'Buybacks':
        return buyback.reportFormat;
      case 'Dividends':
        return dividends.reportFormat;
      default:
        return '';
    }
  }

  double buyback = 0;
  double dividends = 0;

  CashFlowStatement();

  @override
  String toString() => '''
  buyBacks: $buyback
  dividends: $dividends
  ''';
}
