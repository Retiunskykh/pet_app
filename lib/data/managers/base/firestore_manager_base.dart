import 'package:adopt_a_pet/data/models/pet.dart';

abstract class FirestoreManagerBase {
  void savePet(Pet pet);

  Future<List<Pet>> getSavedPets();
}
