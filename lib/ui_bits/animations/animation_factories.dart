import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';

class BitAnimations {
  static BitAnimation none() => const BitNoAnimation();

  static BitAnimation width({
    AnimationRegistry animateAfter = const StubRegistry(),
    AnimationStarter onComplete,
  }) =>
      BitWidthAnimation(
        animateAfter: animateAfter,
        onComplete: onComplete,
      );

  static BitAnimation scale({
    AnimationRegistry animateAfter = const StubRegistry(),
    AnimationStarter onComplete,
  }) =>
      BitScaleAnimation(
        animateAfter: animateAfter,
        onComplete: onComplete,
      );

  static BitAnimation fadeIn({
    AnimationRegistry animateAfter = const StubRegistry(),
    AnimationStarter onComplete,
  }) =>
      BitFadeInAnimation(
        animateAfter: animateAfter,
        onComplete: onComplete,
      );

  static BitAnimation flip({
    AnimationRegistry animateAfter = const StubRegistry(),
    AnimationStarter onComplete,
  }) =>
      BitFlipAnimation(
        animateAfter: animateAfter,
        onComplete: onComplete,
      );
}
