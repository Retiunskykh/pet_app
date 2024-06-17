import 'package:adopt_a_pet/api/dto/organization_dto.dart';

abstract class OrganizationApiServiceBase {
  Future<OrganizationDto?> getOrganization(String id);
}