import 'package:cresce_flutter_app/features/organizations/organizations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fake_http_layer.dart';

main() {
  EquatableConfig.stringify = true;

  group(OrganizationServices, () {
    test('on successful login calls given callback function', () async {
      final services = makeService<OrganizationServices>();
      List<Organization> organizations;

      services.fetchOrganizations(
        'myUser',
        onSuccess: (orgs) => organizations = orgs,
      );

      expect(organizations, [Organization(name: 'myOrg')]);
    });

    test('fetching organizations for unknown user calls failure callback', () {
      var service = makeService<OrganizationServices>();
      bool failed = false;

      service.fetchOrganizations(
        'unknownUser',
        onFailure: () => failed = true,
      );

      expect(failed, isTrue);
    });
  });
}
