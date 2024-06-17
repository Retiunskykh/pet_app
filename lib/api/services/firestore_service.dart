import 'package:adopt_a_pet/api/dto/pet_dto.dart';
import 'package:adopt_a_pet/api/services/base/firestore_service_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreService implements FirestoreServiceBase {
  @override
  void savePet(PetDto pet) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final uid = prefs.getString('uid');

      final users = FirebaseFirestore.instance.collection('users');

      final userDoc = await users.doc(uid).get();

      if (userDoc.exists) {
        final petsMap = List.from(userDoc.data()!['savedPets']);

        petsMap.add(pet.toJson());

        await users.doc(uid).update({'savedPets': petsMap});
      } else {
        final savedPets = [pet.toJson()];

        await users.doc(uid).set({'savedPets': savedPets});
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<PetDto>> getSavedPets() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final uid = prefs.getString('uid');

      final users = FirebaseFirestore.instance.collection('users');

      final userDoc = await users.doc(uid).get();

      if (userDoc.exists) {
        List<PetDto> savedPets = [];
        final petsMap = List.from(userDoc.data()!['savedPets']);

        for (final pet in petsMap) {
          savedPets.add(PetDto.fromJson(pet));
        }

        return savedPets;
      } else {
        return [];
      }
    } catch (e) {
      print(e);

      return [];
    }
  }
}
