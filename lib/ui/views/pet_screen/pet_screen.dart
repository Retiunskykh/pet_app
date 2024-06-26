import 'package:adopt_a_pet/data/models/pet.dart';
import 'package:adopt_a_pet/enum/pet_type_enum.dart';
import 'package:adopt_a_pet/extensions/location_extensions.dart';
import 'package:adopt_a_pet/presentation/bloc/pet_screen_bloc.dart';
import 'package:adopt_a_pet/presentation/events/pet_screen/get_list_by_name_pet_screen_event.dart';
import 'package:adopt_a_pet/presentation/events/pet_screen/get_list_pet_screen_event.dart';
import 'package:adopt_a_pet/presentation/events/pet_screen/save_pet_screen_event.dart';
import 'package:adopt_a_pet/presentation/states/pet_screen_state.dart';
import 'package:adopt_a_pet/ui/dialog_service.dart';
import 'package:adopt_a_pet/ui/views/pet_info_screen/pet_info_screen.dart';
import 'package:adopt_a_pet/ui/views/pet_screen/location_dialog.dart';
import 'package:adopt_a_pet/ui/views/pet_screen/location_widget.dart';
import 'package:adopt_a_pet/ui/views/pet_screen/pet_grid/pet_grid.dart';
import 'package:adopt_a_pet/ui/views/pet_screen/pet_search_bar.dart';
import 'package:adopt_a_pet/ui/views/pet_screen/pet_type_list/pet_type_list.dart';
import 'package:adopt_a_pet/ui/widgets/custom_bottom_navigation_bar.dart';
import 'package:adopt_a_pet/ui/widgets/text/body2_text.dart';
import 'package:adopt_a_pet/ui/widgets/text/h2_text.dart';
import 'package:adopt_a_pet/enum/data_loading_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PetScreen extends StatelessWidget {
  late PetScreenBloc _petScreenBloc;

  PetScreen({super.key});

  Widget _createContent(BuildContext context, PetScreenState state) {
    switch (state.petListLoadingState) {
      case DataLoadingState.none:
        return _getClearContainer();
      case DataLoadingState.loading:
        return _getLoadingContent();
      case DataLoadingState.data:
        return _getDataContent(state, context);
      case DataLoadingState.error:
        return _getErrorContent();
      case DataLoadingState.empty:
        return _getEmptyContent();
    }
  }

  Widget _getDataContent(PetScreenState state, BuildContext context) {
    return Expanded(
      child: PetGrid(
        petList: state.petList!,
        onPetTap: (pet) => navigateToPetInfoPage(
          context,
          pet,
        ),
        savePet: (pet) => _petScreenBloc.add(
          SavePetScreenEvent(
            pet: pet,
          ),
        ),
      ),
    );
  }

  Widget _getClearContainer() {
    return const Text("_getClearContainer");
  }

  Widget _getLoadingContent() {
    return Expanded(
      child: Center(
        child: LoadingAnimationWidget.discreteCircle(
          color: const Color(0xFF827397),
          secondRingColor: const Color(0xFFfde3f9),
          thirdRingColor: const Color(0xFFe8effa),
          size: 36,
        ),
      ),
    );
  }

  Widget _getErrorContent() {
    return Expanded(
      child: Center(
        child: Body2Text(
          text: "Nothing found",
          textColor: const Color(0xFF5F5B5B),
        ),
      ),
    );
  }

  Widget _getEmptyContent() {
    return Expanded(
      child: Center(
        child: Body2Text(
          text: "Nothing found",
          textColor: const Color(0xFF5F5B5B),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _petScreenBloc = BlocProvider.of<PetScreenBloc>(context);
    _petScreenBloc.add(
      GetListPetScreenEvent(
        page: 1,
        petType: PetType.dog,
      ),
    );

    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(
        currentPageIndex: 0,
      ),
      body: SafeArea(
        child: BlocBuilder<PetScreenBloc, PetScreenState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: LocationWidget(
                      selectedLocation: state.selectedLocation,
                      onTap: () => DialogService.showAlertDialog(
                        context: context,
                        dialog: LocationDialog(
                          selectedLocation: state.selectedLocation,
                          onLocationSelected: (location) => _petScreenBloc.add(
                            GetListPetScreenEvent(
                              page: 1,
                              location: location,
                            ),
                          ),
                          onSearchButtonTap: (location) => {},
                          locationList: LocationExtensions.locationList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: PetSearchBar(
                      height: 48.0,
                      onSearchButtonTap: (name) => _onSearch(name),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: H2Text(
                      text: "Pet Categories",
                      textColor: const Color(0xFF5F5B5B),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  PetTypeList(
                    categoryList: const [
                      PetType.dog,
                      PetType.cat,
                      PetType.bird,
                      PetType.rabbit,
                      PetType.smallAndFurry,
                    ],
                    onPetTypeTap: (petType) => _petScreenBloc.add(
                      GetListPetScreenEvent(
                        page: 1,
                        petType: petType,
                      ),
                    ),
                    selectedPetType: state.selectedPetType,
                  ),
                  const SizedBox(height: 24.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: H2Text(
                      text: "Adopt a pet",
                      textColor: const Color(0xFF5F5B5B),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  _createContent(context, state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _onSearch(String searchText) {
    _petScreenBloc.add(
      GetListByNamePetScreenEvent(
        page: 1,
        name: searchText,
      ),
    );
  }

  void navigateToPetInfoPage(
    BuildContext context,
    Pet pet,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return PetInfoScreen(pet: pet);
        },
      ),
    );
  }
}
