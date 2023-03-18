extension NumberUtils on double {
  double get millions => this / (1000 * 1000);

  double get billions => this / (1000 * 1000 * 1000);

  String get reportFormat {
    // Default is millions
    double value = millions;
    String suffix = 'M';

    // Check if we should use billions
    final double absolute = millions.abs();
    if (absolute > 1000) {
      value = billions;
      suffix = 'B';
    }

    // Pick the number of decimal places
    int decimalPlaces = 2;
    if (value % 10 == 0) {
      decimalPlaces = 1;
    }
    if (value % 100 == 0) {
      decimalPlaces = 0;
    }

    return '${value.toStringAsFixed(decimalPlaces)}$suffix';
  }
}
