import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';
import 'package:cresce_flutter_app/features/organizations/organizations.dart';

class OrganizationServices {
  HttpGet httpGet;

  OrganizationServices(this.httpGet);

  void getUserOrganizations(
    String userId, {
    void Function(List<OrganizationDto>) onSuccess,
  }) {
    httpGet.get('api/v1/$userId/organization').then((value) {
      onSuccess(value.deserializeList(OrganizationDto()));
    });
  }
}
