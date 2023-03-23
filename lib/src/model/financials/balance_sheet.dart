import 'package:flutter_edgar_sec/src/utils/number_utils.dart';

class BalanceSheet {
  static List<String> labels = [
    'Cash & Cash Equivalents',
    'Short Term Investments',
    'Accounts Receivables',
    'Other Receivables',
    'Inventory',
  ];

  String getValueForIndex(int index) {
    if (index >= labels.length) {
      return '';
    }

    final String name = labels[index];

    switch (name) {
      case 'Cash & Cash Equivalents':
        return cashAndCashEquivalents.reportFormat;
      case 'Short Term Investments':
        return shortTermInvestments.reportFormat;
      case 'Accounts Receivables':
        return accountsReceivable.reportFormat;
      case 'Other Receivables':
        return otherReceivables.reportFormat;
      case 'Inventory':
        return inventory.reportFormat;
      default:
        return '';
    }
  }

  // Cash & Short Term Investments division
  double cashAndCashEquivalents = 0;
  double shortTermInvestments = 0;
  double tradingAssetSecurities = 0;

  // Receivables division
  double accountsReceivable = 0;
  double otherReceivables = 0;

  // Current Assets
  double inventory = 0;
  double deferredTaxAssets = 0;
  double restrictedCash = 0;
  double otherCurrentAssets = 0;

  // Total Current Assets
  double currentAssets = 0;

  // Long Term Assets
  double grossPropertyPlantEquipment = 0;
  double accumulatedDepreciation = 0;
  double netPropertyPlantEquipment = 0;
  double longTermInvestments = 0;
  double goodwill = 0;

  // Calculated total cash n cash equivalents
  double get totalCashAndShortTermInvestments =>
      cashAndCashEquivalents + shortTermInvestments + tradingAssetSecurities;

  BalanceSheet();

  set(double otherAssetsCurrent) {}

  @override
  String toString() => '''
  cashAndCashEquivalents: $cashAndCashEquivalents,
  shortTermInvestments: $shortTermInvestments,
  Total Cash Eqs: $totalCashAndShortTermInvestments,
  accountsReceivable: $accountsReceivable,
  otherReceivables: $otherReceivables,
  inventory: $inventory,
  deferredTaxAssets: $deferredTaxAssets,
  restrictedCash: $restrictedCash,
  otherCurrentAssets: $otherCurrentAssets,
  currentAssets: $currentAssets,
  grossPropertyPlantEquipment: $grossPropertyPlantEquipment,
  accumulatedDepreciation: $accumulatedDepreciation,
  netPropertyPlantEquipment: $netPropertyPlantEquipment,
  longTermInvestments: $longTermInvestments,
  goodwill: $goodwill,
  ''';
}
