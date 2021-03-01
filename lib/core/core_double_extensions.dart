extension DynamicExtensions on dynamic {
  double toDouble() {
    return double.tryParse(this.toString()) ?? 0.0;
  }
}
