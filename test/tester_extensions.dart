import 'package:cresce_flutter_app/app.dart';
import 'package:cresce_flutter_app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_bits/ui_bits.dart';

import 'fake_http_layer.dart';
import 'test_model.dart';

extension TesterExtensions on WidgetTester {
  Future waitForAnimationsToSettle() =>
      this.pumpAndSettle(const Duration(minutes: 1));

  Future pumpApp() async {
    await this.pumpWidget(makeApp(
      overrideDependencies: (locator) {
        useFakeHttpLayer(locator);
      },
    ));
    await this.waitForAnimationsToSettle();
  }

  Future pumpWidgetInApp(Widget widget) async {
    await this.pumpWidget(
      makeApp(
        overrideDependencies: (locator) {
          useFakeHttpLayer(locator);
          locator.registerSingleton<EntityListGateway<TestModel>>(
            TestModelEntityListGateway(),
          );
        },
        home: Scaffold(body: widget),
      ),
    );

    await this.waitForAnimationsToSettle();
  }

  Future tapFirstCard() async {
    await this.tap(find.byType(BitThumbnail).first);
    await this.pump();
  }
}

extension CommonFindersExtensions on CommonFinders {
  Finder byGenericType<T extends Widget>() {
    return this.byType(T);
  }
}

class TestModelEntityListGateway implements EntityListGateway<TestModel> {
  @override
  Future<List<TestModel>> getList() {
    return Future.value([
      TestModel(),
      TestModel(),
    ]);
  }
}

void expectToFind(Finder finder) {
  expect(finder, findsOneWidget);
}

void expectNotToFind(Finder finder) {
  expect(finder, findsNothing);
}
