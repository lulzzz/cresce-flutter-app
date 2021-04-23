import 'dart:math';

import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';
import 'package:flutter/rendering.dart';

class BitFlipAnimation implements BitAnimation {
  final AnimationRegistry animateAfter;
  final AnimationStarter onComplete;

  BitFlipAnimation({
    this.onComplete,
    this.animateAfter = const StubRegistry(),
  });

  @override
  Widget wrapWidget({Widget child}) {
    return Builder(builder: (context) {
      return BitFlipAnimationWidget(
        duration: context.animation.long,
        onComplete: onComplete,
        animateAfter: animateAfter,
        child: child,
      );
    });
  }
}

class Matrix {
  /// Perspective makes objects that are farther away appear smaller
  ///
  /// the [weight] parameter increases and decreases the amount of perspective,
  /// something like zooming in and out with a zoom lens on a camera. The bigger
  /// this number, the more pronounced is the perspective, which makes it look
  /// like you are closer to the viewed object
  ///
  /// https://medium.com/flutter/perspective-on-flutter-6f832f4d912e
  static Matrix4 perspective([double weight = .001]) =>
      Matrix4.identity()..setEntry(3, 2, weight);
}

class BitFlipAnimationWidget extends StatefulWidget {
  final Widget child;
  final AnimationStarter onComplete;
  final AnimationRegistry animateAfter;
  final Duration duration;

  const BitFlipAnimationWidget({
    this.child,
    this.onComplete,
    this.animateAfter = const StubRegistry(),
    this.duration = const Duration(milliseconds: 700),
  });

  @override
  _BitFlipAnimationWidgetState createState() => _BitFlipAnimationWidgetState();
}

class _BitFlipAnimationWidgetState extends State<BitFlipAnimationWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> _flipAnimation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _flipAnimation = Tween<double>(begin: pi / 2.0, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOutCubic,
        reverseCurve: Curves.easeIn,
      ),
    );

    widget.animateAfter.register(() {
      controller
        ..value = 0.0
        ..forward().whenComplete(
          () => widget.onComplete?.startAnimations(),
        );
    });
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _flipAnimation,
      builder: (context, child) => Transform(
        transform: Matrix.perspective(.001)..rotateX(_flipAnimation.value),
        alignment: Alignment.center,
        child: child,
      ),
      child: widget.child,
    );
  }
}
