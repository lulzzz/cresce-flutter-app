import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';
import 'package:cresce_flutter_app/features/organizations/organizations.dart';
import 'package:cresce_flutter_app/services_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fake_http_layer.dart';

main() {
  EquatableConfig.stringify = true;
  List<OrganizationDto> result;

  void onSuccessHandler(List<OrganizationDto> orgs) {
    result = orgs;
  }

  test('on successful login calls given callback function', () async {
    final services = makeServices();

    services.getUserOrganizations(
      'myUser',
      onSuccess: onSuccessHandler,
    );

    print(
      OrganizationListDto(result).serialize(JsonFormatter()),
    );
  });
}

OrganizationServices makeServices() {
  useFakeHttpLayer();
  return get<OrganizationServices>();
}
