import 'dart:async';
import 'package:adopt_a_pet/data/managers/base/firestore_manager_base.dart';
import 'package:adopt_a_pet/ioc/simple_ioc_container.dart';
import 'package:adopt_a_pet/presentation/events/saved_pet_screen/get_list_saved_pet_screen_event.dart';
import 'package:adopt_a_pet/presentation/events/saved_pet_screen/saved_pet_screen_event.dart';
import 'package:adopt_a_pet/enum/data_loading_state.dart';
import 'package:adopt_a_pet/presentation/states/saved_pet_screen_state.dart';
import 'package:bloc/bloc.dart';

class SavedPetScreenBloc extends Bloc<SavedPetScreenEvent, SavedPetScreenState> {
  late FirestoreManagerBase _firestoreManager;

  SavedPetScreenBloc() : super(SavedPetScreenState.createInitial()) {
    _firestoreManager = SimpleIoCContainer.resolve<FirestoreManagerBase>();

    on<GetListSavedPetScreenEvent>(_onGetListSavedPetScreenEvent);
  }

  FutureOr<void> _onGetListSavedPetScreenEvent(
    GetListSavedPetScreenEvent event,
    Emitter<SavedPetScreenState> emit,
  ) async {
    emit(
      SavedPetScreenState.createForGetList(
        petListLoadingState: DataLoadingState.loading,
        petList: null,
      ),
    );

    try {
      final petList = await _firestoreManager.getSavedPets();

      if (petList.isNotEmpty) {
        emit(
          SavedPetScreenState.createForGetList(
            petListLoadingState: DataLoadingState.data,
            petList: petList,
          ),
        );
      } else {
        emit(
          SavedPetScreenState.createForGetList(
            petListLoadingState: DataLoadingState.empty,
            petList: petList,
          ),
        );
      }
    } catch (ex) {
      emit(
        SavedPetScreenState.createForGetList(
          petListLoadingState: DataLoadingState.error,
          petList: null,
        ),
      );
    }
  }
}
