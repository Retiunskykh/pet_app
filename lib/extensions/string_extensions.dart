import 'package:adopt_a_pet/enum/pet_type_enum.dart';

extension StringExtensions on String {
  static const String _empty = '';

  static String empty() {
    return _empty;
  }

  PetType toPetTypeEnum() {
    switch (this) {
      case "Dog":
        return PetType.dog;
      case 'Cat':
        return PetType.cat;
      case 'Bird':
        return PetType.bird;
      case 'Small & Furry':
        return PetType.smallAndFurry;
      case 'Rabbit':
        return PetType.rabbit;
      default:
        return PetType.dog;
    }
  }
}
