import 'package:flutter/widgets.dart';

import 'animations_orchestrator.dart';

class BitToggleAnimation extends StatelessWidget {
  final bool toggle;
  final Widget topChild;
  final Widget bottomChild;
  final Duration duration;

  const BitToggleAnimation(
    this.toggle,
    this.topChild,
    this.bottomChild, {
    this.duration = const Duration(milliseconds: 250),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: AnimationOrchestrator.of(context).apply(duration),
      firstCurve: Curves.easeInOutSine,
      secondCurve: Curves.easeInOutSine,
      alignment: Alignment.center,
      layoutBuilder: (Widget topChild, _, Widget bottomChild, __) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[bottomChild, topChild],
        );
      },
      firstChild: topChild,
      secondChild: bottomChild,
      crossFadeState:
          toggle ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }
}
