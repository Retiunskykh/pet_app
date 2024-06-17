import 'package:adopt_a_pet/data/models/pet.dart';
import 'package:adopt_a_pet/presentation/events/pet_screen/pet_screen_event.dart';

class SavePetScreenEvent implements PetScreenEvent {
  final Pet pet;

  SavePetScreenEvent({
    required this.pet,
  });
}
