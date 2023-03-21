import 'package:http/http.dart' as http;

/// https://www.sec.gov/include/ticker.txt
/// Class that makes use of the sec service to convert a symbol to a CIK
class SymbolToCik {
  // Singleton
  static final SymbolToCik _instance = SymbolToCik._internal();

  factory SymbolToCik() => _instance;

  SymbolToCik._internal();

  // Map from symbol to CIK
  Map<String, String> symbolToCik = {};

  /// Converts a symbol to a CIK
  Future<String> convert(
    String symbolParam, {
    bool leadingZeros: false,
  }) async {
    await ensureConversionIsCreated();

    final String symbol = symbolParam.toLowerCase();

    if (symbolToCik.containsKey(symbol)) {
      return leadingZeros
          ? addLeadingZeros(symbolToCik[symbol]!)
          : symbolToCik[symbol]!;
    }

    return '';
  }

  /// Adds leading zeros to a string
  /// What we know is that SEC likes to receive something like 0000320193 instead of 320193
  String addLeadingZeros(String s) {
    final int leadingZerosMissing = 10 - s.length;

    final String leadingZeros = '0' * leadingZerosMissing;
    return '$leadingZeros$s';
  }

  /// https://www.sec.gov/include/ticker.txt
  Future<void> ensureConversionIsCreated() async {
    if (symbolToCik.isEmpty) {
      final String content =
          await http.read(Uri.https('www.sec.gov', '/include/ticker.txt'));
      final List<String> lines = content.split('\n');

      for (String line in lines) {
        final List<String> parts = line.split('\t');
        symbolToCik[parts[0]] = parts[1];
      }
    }
  }
}
