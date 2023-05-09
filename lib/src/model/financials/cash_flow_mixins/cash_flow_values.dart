mixin CashFlowValues {
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
  double buyMarketableSecurities = 0;
  double sellMarketableSecurities = 0;
  double cashFromInvesting = 0;

  double get freeCashFlow => cashFromOperations - capitalExpenditures;

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
