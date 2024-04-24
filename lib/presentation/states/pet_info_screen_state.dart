import 'package:adopt_a_pet/data/models/organization.dart';
import 'package:adopt_a_pet/enum/data_loading_state.dart';

class PetInfoScreenState {
  final DataLoadingState organizationLoadingState;
  final Organization? organization;

  PetInfoScreenState({
    required this.organizationLoadingState,
    required this.organization,
  });

  static createInitial() {
    return PetInfoScreenState(
      organizationLoadingState: DataLoadingState.none,
      organization: null,
    );
  }

  static createForGetOrganization({
    required DataLoadingState petListLoadingState,
    required Organization? organization,
  }) {
    return PetInfoScreenState(
      organizationLoadingState: petListLoadingState,
      organization: organization,
    );
  }
}
