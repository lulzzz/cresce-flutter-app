import 'package:flutter/widgets.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';

import 'animations_orchestrator.dart';

class BitWidthAnimation implements BitAnimation {
  final AnimationRegistry animateAfter;
  final AnimationStarter onComplete;

  BitWidthAnimation({
    this.animateAfter = const StubRegistry(),
    this.onComplete,
  });

  @override
  Widget wrapWidget({Widget child}) {
    return Builder(builder: (context) {
      return BitWidthAnimationWidget(
        duration: context.animation.long,
        animateAfter: animateAfter,
        onComplete: onComplete,
        width: context.calculateCardWidth(),
        child: child,
      );
    });
  }
}

class TimeInterval {
  final double begin;
  final double end;

  const TimeInterval.first()
      : begin = 0.0,
        end = 1.0;

  Interval toInterval(Curve curve) {
    final from = Interval(0.0, 1.0);

    return Interval(
      from.begin + (from.end - from.begin) * begin,
      from.begin + (from.end - from.begin) * end,
      curve: curve,
    );
  }
}

class BitWidthAnimationWidget extends StatefulWidget {
  final TimeInterval interval;
  final Widget child;
  final double width;
  final double startWidth;
  final Curve curve;
  final Duration duration;
  final AnimationRegistry animateAfter;
  final AnimationStarter onComplete;

  const BitWidthAnimationWidget({
    this.child,
    this.width,
    this.interval = const TimeInterval.first(),
    this.curve = Curves.linearToEaseOut,
    this.duration = const Duration(milliseconds: 1150),
    this.startWidth = 48.0,
    this.animateAfter = const StubRegistry(),
    this.onComplete,
  });

  @override
  _BitWidthAnimationWidgetState createState() =>
      _BitWidthAnimationWidgetState();
}

class _BitWidthAnimationWidgetState extends State<BitWidthAnimationWidget> {
  var targetWidget = 0.0;

  @override
  void initState() {
    super.initState();
    targetWidget = widget.startWidth;
    widget.animateAfter.register(() {
      setState(() => targetWidget = widget.width);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: targetWidget,
      duration: widget.duration,
      curve: widget.interval.toInterval(widget.curve),
      child: widget.child,
      onEnd: () => widget.onComplete?.startAnimations(),
    );
  }
}
