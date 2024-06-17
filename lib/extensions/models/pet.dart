import 'package:adopt_a_pet/api/dto/attributes_dto.dart';
import 'package:adopt_a_pet/api/dto/breeds_dto.dart';
import 'package:adopt_a_pet/api/dto/contact_dto.dart';
import 'package:adopt_a_pet/api/dto/environment_dto.dart';
import 'package:adopt_a_pet/api/dto/pet_colors_dto.dart';
import 'package:adopt_a_pet/api/dto/pet_dto.dart';
import 'package:adopt_a_pet/data/models/pet.dart';
import 'package:adopt_a_pet/extensions/models/address.dart';
import 'package:adopt_a_pet/extensions/models/photo.dart';

extension PetExtensions on Pet {
  PetDto toDto() {
    return PetDto(
      id: id,
      organizationId: organizationId,
      type: type.toString().split('.').last,
      species: species,
      breeds: BreedsDto(
        primary: breeds.primary,
        secondary: breeds.secondary,
        mixed: breeds.mixed,
        unknown: breeds.unknown,
      ),
      colors: PetColorsDto(
        primary: colors.primary,
        secondary: colors.secondary,
        tertiary: colors.tertiary,
      ),
      age: age,
      gender: gender,
      size: size,
      attributes: AttributesDto(
        spayedNeutered: attributes.spayedNeutered,
        houseTrained: attributes.houseTrained,
        declawed: attributes.declawed,
        specialNeeds: attributes.specialNeeds,
        shotsCurrent: attributes.shotsCurrent,
      ),
      environment: EnvironmentDto(
        children: environment.children,
        dogs: environment.dogs,
        cats: environment.cats,
      ),
      name: name,
      description: description,
      primaryPhotoCropped: primaryPhotoCropped!.toDto(),
      publishedAt: publishedAt,
      contact: ContactDto(
        email: contact.email,
        phone: contact.phone,
        address: contact.address.toDto(),
      ),
    );
  }
}
