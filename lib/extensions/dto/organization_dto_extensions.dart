import 'package:adopt_a_pet/api/services/dto/organization_dto.dart';
import 'package:adopt_a_pet/data/models/organization.dart';

extension OrganizationDtoExtensions on OrganizationDto {
  Organization toModel() {
    return Organization(
      id: id,
      name: name,
      email: email,
      phone: phone,
    );
  }
}
