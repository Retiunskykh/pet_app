import 'package:adopt_a_pet/data/models/pet.dart';
import 'package:adopt_a_pet/enum/pet_type_enum.dart';
import 'package:adopt_a_pet/presentation/bloc/saved_pet_screen_bloc.dart';
import 'package:adopt_a_pet/presentation/events/saved_pet_screen/get_list_saved_pet_screen_event.dart';
import 'package:adopt_a_pet/presentation/states/saved_pet_screen_state.dart';
import 'package:adopt_a_pet/ui/views/pet_info_screen/pet_info_screen.dart';
import 'package:adopt_a_pet/ui/views/pet_screen/pet_grid/pet_grid.dart';
import 'package:adopt_a_pet/ui/widgets/custom_bottom_navigation_bar.dart';
import 'package:adopt_a_pet/ui/widgets/text/body2_text.dart';
import 'package:adopt_a_pet/ui/widgets/text/h2_text.dart';
import 'package:adopt_a_pet/enum/data_loading_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SavedPets extends StatelessWidget {
  late SavedPetScreenBloc _petScreenBloc;

  SavedPets({super.key});

  Widget _createContent(BuildContext context, SavedPetScreenState state) {
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

  Widget _getDataContent(SavedPetScreenState state, BuildContext context) {
    return Expanded(
      child: PetGrid(
        petList: state.petList!,
        onPetTap: (pet) => navigateToPetInfoPage(context, pet),
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
    _petScreenBloc = BlocProvider.of<SavedPetScreenBloc>(context);
    _petScreenBloc.add(GetListSavedPetScreenEvent());

    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(
        currentPageIndex: 1,
      ),
      body: SafeArea(
        child: BlocBuilder<SavedPetScreenBloc, SavedPetScreenState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: H2Text(
                      text: "Saved Pets",
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
