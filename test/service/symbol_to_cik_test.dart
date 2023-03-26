import 'package:flutter_edgar_sec/src/service/symbol_to_cik.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test the convert from symbol to cik', () async {
    final Map<String, String> symbolToCik = {
      'aapl': '320193',
      'msft': '789019',
      'brk-b': '1067983',
      'unh': '731766',
      'jnj': '200406',
      'v': '1403161',
      'tsm': '1046179',
      'xom': '34088',
      'wmt': '104169',
    };

    for (final String symbol in symbolToCik.keys) {
      final String cik = await SymbolToCik().convert(symbol);
      expect(cik, symbolToCik[symbol]);
    }
  });

  test('Test leading zeros', () async {
    final String cik = await SymbolToCik().convert('aapl', leadingZeros: true);
    expect(cik, '0000320193');
  });
}
