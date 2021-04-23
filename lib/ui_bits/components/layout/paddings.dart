import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';

class BitSmallPadding extends StatelessWidget {
  final Widget child;
  final BitEdgeInsets options;

  const BitSmallPadding({
    Key key,
    this.child,
    this.options = BitEdgeInsetsOptions.all,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: options.getEdgeInsets(context.sizes.small),
      child: child,
    );
  }
}

class BitMediumPadding extends StatelessWidget {
  final Widget child;
  final BitEdgeInsets options;

  const BitMediumPadding({
    Key key,
    this.child,
    this.options = BitEdgeInsetsOptions.all,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: options.getEdgeInsets(context.sizes.medium),
      child: child,
    );
  }
}

class BitEdgeInsetsOptions {
  static const BitEdgeInsets none = _NoneEdgeInsets();
  static const BitEdgeInsets all = _AllEdgeInsets();
  static const BitEdgeInsets top = _TopOnlyEdgeInsets();
  static const BitEdgeInsets bottom = _BottomOnlyEdgeInsets();
  static const BitEdgeInsets left = _LeftOnlyEdgeInsets();
  static const BitEdgeInsets right = _RightOnlyEdgeInsets();
  static BitEdgeInsets combine(List<BitEdgeInsets> insets) {
    return _EdgeInsetsComposite(insets);
  }
}

abstract class BitEdgeInsets {
  EdgeInsets getEdgeInsets(double size);
  double getTop(double size);
  double getBottom(double size);
  double getLeft(double size);
  double getRight(double size);
}

class _NoneEdgeInsets implements BitEdgeInsets {
  const _NoneEdgeInsets();
  @override
  double getBottom(double size) => 0.0;

  @override
  EdgeInsets getEdgeInsets(double size) => const EdgeInsets.all(0.0);

  @override
  double getLeft(double size) => 0.0;

  @override
  double getRight(double size) => 0.0;

  @override
  double getTop(double size) => 0.0;
}

class _EdgeInsetsComposite implements BitEdgeInsets {
  final List<BitEdgeInsets> insets;

  _EdgeInsetsComposite(this.insets);

  @override
  EdgeInsets getEdgeInsets(double size) {
    return EdgeInsets.only(
      top: getTop(size),
      bottom: getBottom(size),
      left: getLeft(size),
      right: getRight(size),
    );
  }

  @override
  double getTop(double size) => _sumEdgeInsets((e) => e.getTop(size));

  @override
  double getBottom(double size) => _sumEdgeInsets((e) => e.getBottom(size));

  @override
  double getLeft(double size) => _sumEdgeInsets((e) => e.getLeft(size));

  @override
  double getRight(double size) => _sumEdgeInsets((e) => e.getRight(size));

  double _sumEdgeInsets(double Function(BitEdgeInsets) getSize) {
    return insets.map(getSize).reduce((value, element) => value + element);
  }
}

class _AllEdgeInsets implements BitEdgeInsets {
  const _AllEdgeInsets();
  @override
  EdgeInsets getEdgeInsets(double size) => EdgeInsets.all(size);

  @override
  double getTop(double size) => size;

  @override
  double getBottom(double size) => size;

  @override
  double getLeft(double size) => size;

  @override
  double getRight(double size) => size;
}

class _TopOnlyEdgeInsets implements BitEdgeInsets {
  const _TopOnlyEdgeInsets();
  @override
  EdgeInsets getEdgeInsets(double size) => EdgeInsets.only(top: size);

  @override
  double getTop(double size) => size;

  @override
  double getBottom(double size) => 0.0;

  @override
  double getLeft(double size) => 0.0;

  @override
  double getRight(double size) => 0.0;
}

class _BottomOnlyEdgeInsets implements BitEdgeInsets {
  const _BottomOnlyEdgeInsets();
  @override
  EdgeInsets getEdgeInsets(double size) => EdgeInsets.only(bottom: size);

  @override
  double getTop(double size) => 0.0;

  @override
  double getBottom(double size) => size;

  @override
  double getLeft(double size) => 0.0;

  @override
  double getRight(double size) => 0.0;
}

class _LeftOnlyEdgeInsets implements BitEdgeInsets {
  const _LeftOnlyEdgeInsets();
  @override
  EdgeInsets getEdgeInsets(double size) => EdgeInsets.only(bottom: size);

  @override
  double getTop(double size) => 0.0;

  @override
  double getBottom(double size) => 0.0;

  @override
  double getLeft(double size) => size;

  @override
  double getRight(double size) => 0.0;
}

class _RightOnlyEdgeInsets implements BitEdgeInsets {
  const _RightOnlyEdgeInsets();
  @override
  EdgeInsets getEdgeInsets(double size) => EdgeInsets.only(bottom: size);

  @override
  double getTop(double size) => 0.0;

  @override
  double getBottom(double size) => 0.0;

  @override
  double getLeft(double size) => 0.0;

  @override
  double getRight(double size) => size;
}
