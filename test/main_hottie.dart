import 'package:cresce_flutter_app/main.dart' as m;
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hottie/hottie.dart';

import 'app_test.dart' as t1;
import 'authentication/login_widget_test.dart' as t2;
import 'employees/employee_pin_pad_test.dart' as t4;
import 'employees/employees_carousel_test.dart' as t3;

Future<void> main() async {
  runApp(
    TestRunner(main: testAll, child: m.MyApp()),
  );
}

@pragma('vm:entry-point')
void hottie() => hottieInner();

void testAll() {
  t1.main();
  t2.main();
  t3.main();
  t4.main();
}
