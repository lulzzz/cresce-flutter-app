import 'package:cresce_flutter_app/app.dart';
import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/ui_bits/ui_bits.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

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

  Future pumpWidgetInApp(
    Widget widget, {
    void Function(ServiceLocator locator) override,
  }) async {
    await this.pumpWidget(
      makeApp(
        overrideDependencies: (locator) {
          useFakeHttpLayer(locator);
          locator.registerSingleton<EntityListGateway<TestModel>>(
            TestModelEntityListGateway(),
          );
          locator.registerDataLoader<TestModel>();
          override?.call(locator);
        },
        home: Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: SizedBox(
                  height: constraints.maxHeight + 2,
                  width: constraints.maxWidth,
                  child: widget,
                ),
              );
            },
          ),
        ),
      ),
    );

    await this.waitForAnimationsToSettle();
  }

  Future tapFirstCard<TEntity extends ThumbnailDataFactory>() async {
    var byGenericType = find.byGenericType<EntityCarouselWidget<TEntity>>();

    await this.tap(find
        .descendant(of: byGenericType, matching: find.byType(BitThumbnail))
        .first);

    await this.pumpAndSettle();
  }

  Future tapCard({String label}) async {
    await this.tap(_findCard(label));
    await this.pumpAndSettle();
  }
}

Finder _findCard(String label) => find.descendant(
      of: find.byType(BitThumbnail),
      matching: find.text(label),
    );

extension CommonFindersExtensions on CommonFinders {
  Finder byGenericType<T extends Widget>() => this.byType(T);
}

class TestModelEntityListGateway implements EntityListGateway<TestModel> {
  @override
  Future<List<TestModel>> getList() {
    return SynchronousFuture([TestModel(), TestModel()]);
  }
}

void expectToFind(Finder finder) {
  expect(finder, findsOneWidget);
}

void expectToFindType<T>() {
  expectToFind(find.byType(T));
}

void expectNotToFind(Finder finder) {
  expect(finder, findsNothing);
}
