import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var incomingValue;
  setUp(() {
    incomingValue = null;
  });

  void assertValueChange<T>(Field<T> field, T value) {
    expect(incomingValue, field.getValue());
    expect(incomingValue, value);
  }

  Future pumpObservable<T>(WidgetTester tester, Field<T> field) async {
    await tester.pumpWidget(BitObservable<T>(
      field: field,
      builder: (value) {
        incomingValue = value;
        return Container();
      },
    ));
  }

  group(Field, () {
    testWidgets('changing a int field triggers the observable build',
        (tester) async {
      var field = Field.asInt();
      await tester.pumpWidget(BitObservable<int>(
        field: field,
        buildByState: {
          0: Container(key: Key("0")),
        },
      ));

      field.setValue(1);
      await tester.pump();

      expect(find.byType(Container), findsOneWidget);
      expect(find.byKey(Key("0")), findsNothing);
    });

    testWidgets('changing a int field triggers the observable build',
        (tester) async {
      var field = Field.asInt();
      await pumpObservable(tester, field);

      field.setValue(1);
      await tester.pump();

      assertValueChange(field, 1);
    });
    testWidgets('changing a TModel field triggers the observable build',
        (tester) async {
      var field = Field.as<TestModel>();
      await pumpObservable(tester, field);

      field.setValue(TestModel(1, 'test'));
      await tester.pump();

      assertValueChange(field, TestModel(1, 'test'));
    });
    testWidgets(
        'changing a TModel field triggers the observable build on HasValue',
        (tester) async {
      var field = Field.as<TestModel>();
      await tester.pumpWidget(BitObservable<TestModel>(
        field: field,
        hasValue: (value) {
          incomingValue = value;
          return Container();
        },
      ));

      field.setValue(TestModel(1, 'test'));
      await tester.pump();

      assertValueChange(field, TestModel(1, 'test'));
    });
    testWidgets(
        'changing a TModel field triggers the observable build on nullValue',
        (tester) async {
      var wasNullCalled = false;
      var field = Field.as<TestModel>();
      await tester.pumpWidget(BitObservable<TestModel>(
        field: field,
        nullValue: () {
          wasNullCalled = true;
          return Container();
        },
        hasValue: (value) {
          incomingValue = value;
          return Container();
        },
      ));

      field.setValue(TestModel(1, 'test'));
      await tester.pump();

      expect(wasNullCalled, isTrue);
      assertValueChange(field, TestModel(1, 'test'));
    });
  });
}

class TestModel extends Equatable {
  final int id;
  final String name;

  TestModel(this.id, this.name);

  @override
  List<Object> get props => [id, name];
}
