import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';
import 'package:flutter/widgets.dart';

class BitFadeInAnimation extends BitAnimation {
  final AnimationRegistry animateAfter;
  final AnimationStarter onComplete;

  BitFadeInAnimation({
    this.animateAfter,
    this.onComplete,
  });

  @override
  Widget wrapWidget({Widget child}) {
    return Builder(builder: (context) {
      return BitFadeInAnimationWidget(
        child: child,
        animateAfter: animateAfter,
        onComplete: onComplete,
        duration: context.animation.extraShort,
      );
    });
  }
}

class BitFadeInAnimationWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final AnimationRegistry animateAfter;
  final AnimationStarter onComplete;

  const BitFadeInAnimationWidget({
    this.child,
    this.duration = const Duration(milliseconds: 150),
    this.animateAfter = const StubRegistry(),
    this.onComplete,
  });

  @override
  _BitFadeInAnimationWidgetState createState() =>
      _BitFadeInAnimationWidgetState();
}

class _BitFadeInAnimationWidgetState extends State<BitFadeInAnimationWidget> {
  var opacity = 0.0;

  @override
  void initState() {
    super.initState();

    widget.animateAfter.register(() {
      setState(() => opacity = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: widget.duration,
      child: widget.child,
      curve: Curves.easeIn,
      onEnd: () => widget.onComplete?.startAnimations(),
    );
  }
}
