import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ContextExtensions', () {
    group('not initialized', () {
      testWidgets('getting borders should not be null', (tester) async {
        var _borders;

        await tester.pumpWidget(Builder(
          builder: (context) {
            _borders = context.borders;
            return Container();
          },
        ));

        expect(_borders, isNotNull);
      });
      testWidgets('getting sizes should not be null', (tester) async {
        var _sizes;

        await tester.pumpWidget(Builder(
          builder: (context) {
            _sizes = context.sizes;
            return Container();
          },
        ));

        expect(_sizes, isNotNull);
      });
      testWidgets('getting animation should not be null', (tester) async {
        var _animationDurations;

        await tester.pumpWidget(Builder(
          builder: (context) {
            _animationDurations = context.animation;
            return Container();
          },
        ));

        expect(_animationDurations, isNotNull);
      });
    });
  });
}
