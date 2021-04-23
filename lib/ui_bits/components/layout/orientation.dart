import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';

abstract class BitOrientation {
  const BitOrientation();

  Widget build(Widget first, Widget second);
}

class BitLeftOrientation implements BitOrientation {
  const BitLeftOrientation();

  @override
  Widget build(Widget first, Widget second) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [first, second],
    );
  }
}

class BitTopOrientation implements BitOrientation {
  const BitTopOrientation();

  @override
  Widget build(Widget first, Widget second) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [first, second],
    );
  }
}
