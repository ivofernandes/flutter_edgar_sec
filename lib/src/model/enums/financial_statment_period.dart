enum FinancialStatementPeriod {
  annual,
  quarterly;

  bool get isQuarter => this == FinancialStatementPeriod.quarterly;
}
