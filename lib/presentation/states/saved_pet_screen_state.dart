import 'package:adopt_a_pet/data/models/pet.dart';
import 'package:adopt_a_pet/enum/data_loading_state.dart';

class SavedPetScreenState {
  final DataLoadingState petListLoadingState;
  final List<Pet>? petList;

  SavedPetScreenState({
    required this.petListLoadingState,
    required this.petList,
  });

  static createInitial() {
    return SavedPetScreenState(
      petListLoadingState: DataLoadingState.none,
      petList: null,
    );
  }

  static createForGetList({
    required DataLoadingState petListLoadingState,
    required List<Pet>? petList,
  }) {
    return SavedPetScreenState(
      petListLoadingState: petListLoadingState,
      petList: petList,
    );
  }
}
