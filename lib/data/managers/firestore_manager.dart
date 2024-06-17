import 'package:adopt_a_pet/api/services/base/firestore_service_base.dart';
import 'package:adopt_a_pet/data/managers/base/firestore_manager_base.dart';
import 'package:adopt_a_pet/data/models/pet.dart';
import 'package:adopt_a_pet/extensions/dto/pet_dto_extensions.dart';
import 'package:adopt_a_pet/extensions/models/pet.dart';

class FirestoreManager implements FirestoreManagerBase {
  final FirestoreServiceBase _service;

  FirestoreManager(this._service);

  @override
  void savePet(Pet pet) {
    _service.savePet(pet.toDto());
  }

  @override
  Future<List<Pet>> getSavedPets() async {
    final savedPetsDto = await _service.getSavedPets();

    List<Pet> savedPets = [];

    for (final pet in savedPetsDto) {
      savedPets.add(pet.toModel());
    }

    return savedPets;
  }
}
