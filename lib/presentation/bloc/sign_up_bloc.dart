import 'dart:async';

import 'package:adopt_a_pet/api/login_response.dart';
import 'package:adopt_a_pet/api/services/base/firebase_service_base.dart';
import 'package:adopt_a_pet/ioc/simple_ioc_container.dart';
import 'package:adopt_a_pet/presentation/events/sign_up/next_step_on_credentials_sign_up_event.dart';
import 'package:adopt_a_pet/presentation/events/sign_up/sign_up_event.dart';
import 'package:adopt_a_pet/presentation/events/sign_up/toggle_obscure_password_sign_up_event.dart';
import 'package:adopt_a_pet/presentation/states/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  static const int socketResponseAwaitingDelay = 1;

  bool response = false;

  late FirebaseServiceBase _firebaseService;

  SignUpBloc() : super(SignUpState.createInitial()) {
    _firebaseService = SimpleIoCContainer.resolve<FirebaseServiceBase>();

    on<ToggleObscurePasswordSignUpEvent>(_onToggleObscurePassword);
    on<NextStepOnCredentialsSignUpEvent>(_onNextStepOnCredentials);
  }

  FutureOr<void> _onToggleObscurePassword(
    ToggleObscurePasswordSignUpEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(
      SignUpState.createForToggleObscurePassword(previousState: state),
    );
  }

  FutureOr<void> _onNextStepOnCredentials(
    NextStepOnCredentialsSignUpEvent event,
    Emitter<SignUpState> emit,
  ) async {
    final LoginResponse loginResponse = await _firebaseService.createAccount(
      event.email,
      event.password,
    );
    if (loginResponse.isSuccess) {
      emit(
        SignUpState.createForSuccess(
          previousState: state,
        ),
      );
    } else {
      emit(
        SignUpState.createForError(
          previousState: state,
          errorText: loginResponse.errorText!,
        ),
      );
    }
  }
}
