import 'package:adopt_a_pet/api/services/dto/organization_dto.dart';
import 'package:adopt_a_pet/api/services/dto/pet_dto.dart';

abstract class OrganizationApiServiceBase {
  Future<OrganizationDto?> getOrganization(String id);
}