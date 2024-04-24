import 'package:adopt_a_pet/presentation/events/pet_screen/pet_screen_event.dart';

class GetListByNamePetScreenEvent implements PetScreenEvent {
  int page;
  String name;

  GetListByNamePetScreenEvent({
    required this.page,
    required this.name,
  });
}
