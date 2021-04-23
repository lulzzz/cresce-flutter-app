import 'package:flutter/widgets.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';

class BitScaleAnimation extends BitAnimation {
  final AnimationRegistry animateAfter;
  final AnimationStarter onComplete;

  BitScaleAnimation({
    this.animateAfter = const StubRegistry(),
    this.onComplete,
  });

  @override
  Widget wrapWidget({Widget child}) {
    return Builder(builder: (context) {
      return BitScaleAnimationWidget(
        child: child,
        animateAfter: animateAfter,
        onComplete: onComplete,
        duration: context.animation.long,
      );
    });
  }
}

class BitScaleAnimationWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final AnimationRegistry animateAfter;
  final AnimationStarter onComplete;

  const BitScaleAnimationWidget({
    this.child,
    this.duration = const Duration(milliseconds: 1150),
    this.curve = Curves.linearToEaseOut,
    this.animateAfter = const StubRegistry(),
    this.onComplete,
  });

  @override
  _BitScaleAnimationWidgetState createState() =>
      _BitScaleAnimationWidgetState();
}

class _BitScaleAnimationWidgetState extends State<BitScaleAnimationWidget>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    widget.animateAfter.register(() {
      animationController
        ..value = 0.0
        ..forward().whenComplete(() {
          widget.onComplete?.startAnimations();
        });
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animationController,
        curve: widget.curve,
      ),
      child: widget.child,
    );
  }
}
