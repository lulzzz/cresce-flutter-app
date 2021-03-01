import 'package:ui_bits/ui_bits.dart';

extension ImageExtensions on String {
  BitImage toImage() {
    return BitImageBase64(this);
  }
}
