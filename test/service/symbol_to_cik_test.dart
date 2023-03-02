import 'package:flutter_edgar_sec/src/service/symbol_to_cik.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_edgar_sec/flutter_edgar_sec.dart';

void main() {
  test('Test the convert from symbol to cik', () {
    Map<String, String> symbolToCik = {
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

    for (String symbol in symbolToCik.keys) {
      expect(SymbolToCik.convert(symbol), symbolToCik[symbol]);
    }
  });
}
