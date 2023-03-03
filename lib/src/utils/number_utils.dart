extension NumberUtils on double {
  double get millions => this / (1000 * 1000);

  double get billions => this / (1000 * 1000 * 1000);
}
