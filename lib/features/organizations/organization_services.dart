import 'package:cresce_flutter_app/core/http_requests/http_requests.dart';
import 'package:cresce_flutter_app/features/organizations/organizations.dart';

class OrganizationServices {
  HttpGet _httpGet;

  OrganizationServices(this._httpGet);

  Future<List<Organization>> getOrganizations(String userId) {
    return _httpGet.getList<Organization>(
      url: 'api/v1/$userId/organization/',
      deserialize: Organization(),
    );
  }
}
