import 'package:cresce_flutter_app/main.dart';
import 'package:cresce_flutter_features/cresce_flutter_features.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

extension TesterExtensions on WidgetTester {
  Future waitForAnimationsToSettle() =>
      this.pumpAndSettle(const Duration(minutes: 1));

  Future pumpApp() async {
    overrideDependency(makeLoginServices());

    await this.pumpWidget(MyApp());
    await this.waitForAnimationsToSettle();
  }
}

class LoginServicesFake extends Mock implements LoginServices {}

LoginServices makeLoginServices() {
  var loginServices = LoginServicesFake();

  when(loginServices.login(
    CredentialsDto(user: 'myUser', password: 'myPass'),
    successCallback: anyNamed('successCallback'),
    failureCallback: anyNamed('failureCallback'),
  )).thenAnswer((_) {
    _.namedArguments[Symbol('successCallback')](LoginResultDto(
      token: 'token',
      organizationUrl: 'organizationUrl',
    ));
  });

  return loginServices;
}
