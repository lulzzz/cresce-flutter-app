double convertToDouble(dynamic value) {
  return double.tryParse(value.toString()) ?? 0.0;
}
