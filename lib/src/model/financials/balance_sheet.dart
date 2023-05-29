import 'package:flutter_edgar_sec/src/model/financials/balance_mixins/balance_extrapolate.dart';
import 'package:flutter_edgar_sec/src/utils/number_utils.dart';

class BalanceSheet {
  static List<String> labels = [
    'Cash & Cash Equivalents',
    'Short Term Investments',
    'Accounts Receivables',
    'Other Receivables',
    'Inventory',
    'Deferred Tax Assets',
    'Restricted Cash',
    'Other Current Assets',
    'Current Assets',
    'Gross Property Plant Equipment',
    'Accumulated Depreciation',
    'Net Property Plant Equipment',
    'Goodwill',
    'Other Intangibles',
    'Other Long Term Assets',
    'Total Assets',
    'Accounts Payable',
    'Accrued Expenses',
    'Short Term Borrowings',
    'Total Liabilities',
    'Current Liabilities',
    'Equity',
  ];

  String getValueForIndex(int index) {
    if (index >= labels.length) {
      return '';
    }

    final String name = labels[index];

    return getValueForLabel(name)?.reportFormat ?? '';
  }

  double? getValueForLabel(String name) {
    switch (name) {
      case 'Cash & Cash Equivalents':
        return cashAndCashEquivalents;
      case 'Short Term Investments':
        return shortTermInvestments;
      case 'Accounts Receivables':
        return accountsReceivable;
      case 'Other Receivables':
        return otherReceivables;
      case 'Inventory':
        return inventory;
      case 'Deferred Tax Assets':
        return deferredTaxAssets;
      case 'Restricted Cash':
        return restrictedCash;
      case 'Other Current Assets':
        return otherCurrentAssets;
      case 'Current Assets':
        return currentAssets;
      case 'Gross Property Plant Equipment':
        return grossPropertyPlantEquipment;
      case 'Accumulated Depreciation':
        return accumulatedDepreciation;
      case 'Net Property Plant Equipment':
        return netPropertyPlantEquipment;
      case 'Long Term Investments':
        return longTermInvestments;
      case 'Goodwill':
        return goodwill;
      case 'Other Intangibles':
        return otherIntangibles;
      case 'Other Long Term Assets':
        return otherLongTermAssets;
      case 'Total Assets':
        return totalAssets;
      case 'Accounts Payable':
        return accountsPayable;
      case 'Accrued Expenses':
        return accruedExpenses;
      case 'Short Term Borrowings':
        return shortTermBorrowings;
      case 'Equity':
        return equity;
      case 'Total Liabilities':
        return totalLiabilities;
      case 'Current Liabilities':
        return currentLiabilities;
      default:
        return null;
    }
  }

  BalanceSheet();

  factory BalanceSheet.extrapolate(
    BalanceSheet fullYear,
    BalanceSheet q1,
    BalanceSheet q2,
    BalanceSheet q3,
  ) {
    final BalanceSheet balanceSheet = BalanceSheet();
    BalanceExtrapolate.fillMissingQuarter(balanceSheet, fullYear, q1, q2, q3);
    return balanceSheet;
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
  double otherIntangibles = 0;
  double otherLongTermAssets = 0;

  // Total Assets
  double totalAssets = 0;

  // Current Liabilities
  double accountsPayable = 0;
  double accruedExpenses = 0;
  double shortTermBorrowings = 0;
  double currentPortionLtDebt = 0;
  double unearnedRevenueCurrent = 0;
  double currentLiabilities = 0;

  double totalLiabilities = 0;

  double equity = 0;

  // Calculated total cash n cash equivalents
  double get totalCashAndShortTermInvestments => cashAndCashEquivalents + shortTermInvestments + tradingAssetSecurities;

  double get capitalEmployed => totalAssets - currentLiabilities;

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
  otherIntangibles: $otherIntangibles,
  otherLongTermAssets: $otherCurrentAssets,
  totalAssets: $totalAssets,
  accountsPayable: $accountsPayable,
  accruedExpenses: $accruedExpenses,
  shortTermBorrowings: $shortTermBorrowings,
  currentPortionLtDebt: $currentPortionLtDebt,
  unearnedRevenueCurrent: $unearnedRevenueCurrent,
  ''';

  factory BalanceSheet.fromJson(Map<String, dynamic> json) => BalanceSheet()
    ..equity = json['equity'] as double
    ..cashAndCashEquivalents = json['cashAndCashEquivalents'] as double
    ..shortTermInvestments = json['shortTermInvestments'] as double
    ..tradingAssetSecurities = json['tradingAssetSecurities'] as double
    ..accountsReceivable = json['accountsReceivable'] as double
    ..otherReceivables = json['otherReceivables'] as double
    ..inventory = json['inventory'] as double
    ..deferredTaxAssets = json['deferredTaxAssets'] as double
    ..restrictedCash = json['restrictedCash'] as double
    ..otherCurrentAssets = json['otherCurrentAssets'] as double
    ..currentAssets = json['currentAssets'] as double
    ..grossPropertyPlantEquipment = json['grossPropertyPlantEquipment'] as double
    ..accumulatedDepreciation = json['accumulatedDepreciation'] as double
    ..netPropertyPlantEquipment = json['netPropertyPlantEquipment'] as double
    ..longTermInvestments = json['longTermInvestments'] as double
    ..goodwill = json['goodwill'] as double
    ..otherIntangibles = json['otherIntangibles'] as double
    ..otherLongTermAssets = json['otherLongTermAssets'] as double
    ..totalAssets = json['totalAssets'] as double
    ..accountsPayable = json['accountsPayable'] as double
    ..accruedExpenses = json['accruedExpenses'] as double
    ..shortTermBorrowings = json['shortTermBorrowings'] as double
    ..currentPortionLtDebt = json['currentPortionLtDebt'] as double
    ..unearnedRevenueCurrent = json['unearnedRevenueCurrent'] as double
    ..currentLiabilities = json['currentLiabilities'] as double
    ..totalLiabilities = json['totalLiabilities'] as double;

  Map<String, dynamic> toJson() => {
        'equity': equity,
        'cashAndCashEquivalents': cashAndCashEquivalents,
        'shortTermInvestments': shortTermInvestments,
        'tradingAssetSecurities': tradingAssetSecurities,
        'accountsReceivable': accountsReceivable,
        'otherReceivables': otherReceivables,
        'inventory': inventory,
        'deferredTaxAssets': deferredTaxAssets,
        'restrictedCash': restrictedCash,
        'otherCurrentAssets': otherCurrentAssets,
        'currentAssets': currentAssets,
        'grossPropertyPlantEquipment': grossPropertyPlantEquipment,
        'accumulatedDepreciation': accumulatedDepreciation,
        'netPropertyPlantEquipment': netPropertyPlantEquipment,
        'longTermInvestments': longTermInvestments,
        'goodwill': goodwill,
        'otherIntangibles': otherIntangibles,
        'otherLongTermAssets': otherLongTermAssets,
        'totalAssets': totalAssets,
        'accountsPayable': accountsPayable,
        'accruedExpenses': accruedExpenses,
        'shortTermBorrowings': shortTermBorrowings,
        'currentPortionLtDebt': currentPortionLtDebt,
        'unearnedRevenueCurrent': unearnedRevenueCurrent,
        'currentLiabilities': currentLiabilities,
        'totalLiabilities': totalLiabilities,
      };
}
