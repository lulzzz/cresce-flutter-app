import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';
import 'package:cresce_flutter_app/features/organizations/organizations.dart';

typedef OnFetchSuccessful(List<Organization> employees);
typedef OnFetchFailure();

class OrganizationServices {
  HttpGet httpGet;

  OrganizationServices(this.httpGet);

  void fetchOrganizations(
    String userId, {
    OnFetchSuccessful onSuccess,
    OnFetchFailure onFailure,
  }) {
    httpGet.fetchList(
      url: 'api/v1/$userId/organization',
      onSuccess: onSuccess,
      onFailure: onFailure,
      deserialize: Organization(),
    );
  }
}
