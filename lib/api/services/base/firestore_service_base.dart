import 'package:adopt_a_pet/api/dto/pet_dto.dart';

abstract class FirestoreServiceBase {
  void savePet(PetDto pet);

  Future<List<PetDto>> getSavedPets();
}
