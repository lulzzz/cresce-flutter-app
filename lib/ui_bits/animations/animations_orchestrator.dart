import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:flutter/material.dart';

abstract class AnimationStarter {
  void startAnimations();
  void startAnimationsDelayed(Duration duration);
}

abstract class AnimationRegistry {
  void register(VoidCallback startAnimation);
}

class StubRegistry implements AnimationRegistry {
  const StubRegistry();

  @override
  void register(startAnimation) {
    startAnimation();
  }
}

class AnimationOrchestrator extends InheritedWidget
    implements AnimationRegistry, AnimationStarter {
  final double speedFactor;
  final List<VoidCallback> _callbacks;

  AnimationOrchestrator({
    this.speedFactor = 1.0,
  }) : _callbacks = <VoidCallback>[];

  Duration apply(Duration duration) {
    return duration * speedFactor;
  }

  @override
  void startAnimations() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _callbacks.forEach((startAnimation) {
        startAnimation();
      });
    });
  }

  @override
  void register(VoidCallback startAnimation) {
    _callbacks.add(startAnimation);
  }

  static AnimationOrchestrator of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AnimationOrchestrator>() ??
      AnimationOrchestrator(speedFactor: 1.0);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    var orchestrator = oldWidget as AnimationOrchestrator;
    return orchestrator.speedFactor != speedFactor;
  }

  @override
  void startAnimationsDelayed(Duration duration) {
    Future.delayed(duration).then((value) {
      startAnimations();
    });
  }
}

extension AnimationRegistryExtensions on AnimationRegistry {
  AnimationRegistry delayed(Duration delay) => DelayedAnimation(this, delay);
  AnimationRegistry delayedInMillis(int delay) =>
      this.delayed(Duration(milliseconds: delay));
  AnimationRegistry delayedShort(BuildContext context) =>
      this.delayed(context.animation.short);
  AnimationRegistry delayedExtraShort(BuildContext context) =>
      this.delayed(context.animation.extraShort);
}

class DelayedAnimation implements AnimationRegistry {
  final AnimationRegistry _animationTag;
  final Duration _delay;

  const DelayedAnimation(
    AnimationRegistry animationTag,
    Duration delay,
  )   : _animationTag = animationTag,
        _delay = delay;

  @override
  void register(startAnimation) {
    _animationTag.register(() {
      Future.delayed(_delay).then((value) => startAnimation());
    });
  }
}

abstract class BitAnimation {
  AnimationRegistry get animateAfter;
  Widget wrapWidget({Widget child});
}

class BitNoAnimation implements BitAnimation {
  const BitNoAnimation();

  @override
  Widget wrapWidget({Widget child}) => child;

  @override
  AnimationRegistry get animateAfter => const StubRegistry();
}
