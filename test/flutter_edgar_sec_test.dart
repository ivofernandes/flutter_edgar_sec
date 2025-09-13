import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Count asserts in test files', () async {
    final testDirectory = Directory('test');
    int totalAsserts = 0;

    await for (final entity
        in testDirectory.list(recursive: true, followLinks: false)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        final content = await entity.readAsString();
        final assertCount = _countAsserts(content);
        debugPrint('${entity.path}: $assertCount asserts');
        totalAsserts += assertCount;
      }
    }

    debugPrint('Total asserts in tests: $totalAsserts');
  });
}

int _countAsserts(String content) {
  final assertRegex = RegExp(r'\bexpect\b|\bassert\b');
  return assertRegex.allMatches(content).length;
}
