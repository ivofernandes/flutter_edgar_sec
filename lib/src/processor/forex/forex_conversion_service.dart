class ForexConversionService {
  // Singleton
  static final ForexConversionService _instance =
      ForexConversionService._internal();

  factory ForexConversionService() => _instance;

  ForexConversionService._internal();

  /// Converts a map of coins to USD
  Future<Map<String, dynamic>> convertToUSD(
      Map<String, dynamic> coinsMap) async {
    //TODO validate if we can map the currency, meaning that the currency is well known

    //TODO use yahoo finance to get the conversion rate for each day

    //TODO convert the value of each coin to USD in the specific time of the report
    return coinsMap;
  }
}
