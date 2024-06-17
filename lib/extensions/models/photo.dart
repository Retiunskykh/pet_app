import 'package:adopt_a_pet/api/dto/photo_dto.dart';
import 'package:adopt_a_pet/data/models/photo.dart';

extension PhotoExtensions  on Photo {
  PhotoDto toDto() {
    return PhotoDto(
      small: small,
      medium: medium,
      large: large,
      full: full,
    );
  }
}