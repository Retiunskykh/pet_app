import 'dart:async';
import 'package:adopt_a_pet/data/managers/base/firestore_manager_base.dart';
import 'package:adopt_a_pet/data/managers/base/pet_manager_base.dart';
import 'package:adopt_a_pet/ioc/simple_ioc_container.dart';
import 'package:adopt_a_pet/presentation/events/pet_screen/get_list_by_name_pet_screen_event.dart';
import 'package:adopt_a_pet/presentation/events/pet_screen/get_list_pet_screen_event.dart';
import 'package:adopt_a_pet/presentation/events/pet_screen/pet_screen_event.dart';
import 'package:adopt_a_pet/presentation/events/pet_screen/save_pet_screen_event.dart';
import 'package:adopt_a_pet/presentation/states/pet_screen_state.dart';
import 'package:adopt_a_pet/enum/data_loading_state.dart';
import 'package:bloc/bloc.dart';

class PetScreenBloc extends Bloc<PetScreenEvent, PetScreenState> {
  late PetManagerBase _petManager;
  late FirestoreManagerBase _firestoreManagerBase;

  PetScreenBloc() : super(PetScreenState.createInitial()) {
    _petManager = SimpleIoCContainer.resolve<PetManagerBase>();
    _firestoreManagerBase = SimpleIoCContainer.resolve<FirestoreManagerBase>();

    on<GetListPetScreenEvent>(_onGetListPetScreenEvent);
    on<GetListByNamePetScreenEvent>(_onGetListByNamePetScreenEvent);
    on<SavePetScreenEvent>(_onSavePetScreenEvent);
  }

  FutureOr<void> _onSavePetScreenEvent(
    SavePetScreenEvent event,
    Emitter<PetScreenState> emit,
  ) {
    _firestoreManagerBase.savePet(event.pet);
  }

  FutureOr<void> _onGetListPetScreenEvent(
    GetListPetScreenEvent event,
    Emitter<PetScreenState> emit,
  ) async {
    emit(
      PetScreenState.createForGetList(
        petListLoadingState: DataLoadingState.loading,
        petList: null,
        selectedPetType: event.petType ?? state.selectedPetType,
        selectedLocation: event.location ?? state.selectedLocation,
      ),
    );

    try {
      final petList = await _petManager.getPetList(
        event.petType?.name ?? state.selectedPetType.name,
        event.page,
        null,
      );

      if (petList.isNotEmpty) {
        emit(
          PetScreenState.createForGetList(
            petListLoadingState: DataLoadingState.data,
            petList: petList,
            selectedPetType: event.petType ?? state.selectedPetType,
            selectedLocation: event.location ?? state.selectedLocation,
          ),
        );
      } else {
        emit(
          PetScreenState.createForGetList(
            petListLoadingState: DataLoadingState.empty,
            petList: petList,
            selectedPetType: event.petType ?? state.selectedPetType,
            selectedLocation: event.location ?? state.selectedLocation,
          ),
        );
      }
    } catch (ex) {
      print(ex.toString());

      emit(
        PetScreenState.createForGetList(
          petListLoadingState: DataLoadingState.error,
          petList: null,
          selectedPetType: event.petType ?? state.selectedPetType,
          selectedLocation: event.location ?? state.selectedLocation,
        ),
      );
    }
  }

  FutureOr<void> _onGetListByNamePetScreenEvent(
    GetListByNamePetScreenEvent event,
    Emitter<PetScreenState> emit,
  ) async {
    emit(
      PetScreenState.createForGetList(
        petListLoadingState: DataLoadingState.loading,
        petList: null,
        selectedPetType: state.selectedPetType,
        selectedLocation: state.selectedLocation,
      ),
    );
    try {
      // await Future.delayed(const Duration(seconds: 5));
      final petList =
          await _petManager.getPetList(state.selectedPetType.name, event.page, event.name.isEmpty ? null : event.name);

      if (petList.isNotEmpty) {
        emit(
          PetScreenState.createForGetList(
            petListLoadingState: DataLoadingState.data,
            petList: petList,
            selectedPetType: state.selectedPetType,
            selectedLocation: state.selectedLocation,
          ),
        );
      } else {
        emit(
          PetScreenState.createForGetList(
            petListLoadingState: DataLoadingState.empty,
            petList: petList,
            selectedPetType: state.selectedPetType,
            selectedLocation: state.selectedLocation,
          ),
        );
      }
    } catch (ex) {
      print(ex.toString());
      emit(
        PetScreenState.createForGetList(
          petListLoadingState: DataLoadingState.error,
          petList: null,
          selectedPetType: state.selectedPetType,
          selectedLocation: state.selectedLocation,
        ),
      );
    }
  }
}
