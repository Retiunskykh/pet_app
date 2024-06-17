import 'package:adopt_a_pet/api/base/request_service.dart';
import 'package:adopt_a_pet/api/dto/organization_dto.dart';
import 'package:adopt_a_pet/api/services/base/oraganization_api_service_base.dart';
import 'package:adopt_a_pet/constants.dart';
import 'package:adopt_a_pet/enum/http_method.dart';
import 'package:adopt_a_pet/exceptions/api_exception.dart';

class OrganizationApiService implements OrganizationApiServiceBase {
  final RequestService _requestService;

  OrganizationApiService(this._requestService);

  @override
  Future<OrganizationDto?> getOrganization(String id) async {
    try {
      final url = '${Constants.petfinderUrl}organizations/$id';
      final headers = {
        "Authorization": "Bearer ${Constants.token}",
      };

      final response = await _requestService.sendAsync(
        method: HttpMethod.get,
        url: url,
        headers: headers,
      );

      return OrganizationDto.fromJson(response["organization"]);
    } on ApiException catch (ex) {
      print(ex.message);
      
      return null;
    }
  }
}
