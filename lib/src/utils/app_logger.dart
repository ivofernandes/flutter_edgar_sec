import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  // Singleton
  static final AppLogger _singleton = AppLogger._internal();

  factory AppLogger() => _singleton;

  AppLogger._internal();

  final bool _enableLogging = true;

  final Logger _logger =
      Logger(printer: SimplePrinter(), output: _SplitConsoleOutput());

  void error(dynamic event, [dynamic error, StackTrace? stackTrace]) {
    if (_enableLogging) {
      if (kDebugMode) {
        print('ERROR: $event $error $stackTrace');
      }
    }
  }

  void warning(dynamic event) {
    if (_enableLogging) {
      if (kDebugMode) {
        print('WARNING: $event');
      }
    }
  }

  void debug(dynamic event) {
    if (_enableLogging) {
      if (kDebugMode) {
        print('DEBUG: $event');
      }
    }
  }

  void trace(dynamic event) {
    if (_enableLogging) {
      if (kDebugMode) {
        print('TRACE: $event');
      }
    }
  }
}

class _SplitConsoleOutput extends LogOutput {
  /// Maximum length per line in the log. Any logs larger than this length
  /// will be split into chunks and printed in sequence.
  final int splitLength = 1000;

  /// Set to `false` to disable splitting, or leave `null`/`true` to retain the
  /// default behavior, which is to truncate the text.
  ///
  /// The default is true, so you only need to set it if you prefer to use a
  /// condition to determine whether to split or not per your build
  /// configuration.
  final bool enable = true;

  @override
  void output(OutputEvent event) {
    if (enable && event.lines.any(_isTooLong)) {
      for (final line in event.lines) {
        if (_isTooLong(line)) {
          final split = splitByLength(line, splitLength);
          split.forEach(log);
        } else {
          log(line);
        }
      }
    } else {
      event.lines.forEach(log);
    }
  }

  List<String> splitByLength(String string, int length) {
    final chunks = <String>[];
    final stringLength = string.length;

    for (var i = 0; i < stringLength; i += length) {
      final end = (i + length < stringLength) ? i + length : stringLength;
      chunks.add(string.substring(i, end));
    }

    return chunks;
  }

  bool _isTooLong(String line) => line.length > splitLength;
}
