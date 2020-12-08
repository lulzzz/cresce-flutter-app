import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';
import 'package:cresce_flutter_app/features/organizations/organizations.dart';

typedef OnFetchSuccessful(List<OrganizationDto> employees);
typedef OnFetchFailure();

class OrganizationServices {
  HttpGet httpGet;

  OrganizationServices(this.httpGet);

  void getUserOrganizations(
    String userId, {
    OnFetchSuccessful onSuccess,
    OnFetchFailure onFailure,
  }) {
    httpGet.get('api/v1/$userId/organization').then((value) {
      if (value.wasSuccess()) {
        onSuccess(value.deserializeList(OrganizationDto()));
      } else {
        onFailure();
      }
    });
  }
}
