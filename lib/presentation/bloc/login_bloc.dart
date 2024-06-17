import 'dart:async';

import 'package:adopt_a_pet/api/services/base/firebase_service_base.dart';
import 'package:adopt_a_pet/ioc/simple_ioc_container.dart';
import 'package:adopt_a_pet/presentation/events/login/login_event.dart';
import 'package:adopt_a_pet/presentation/events/login/login_obscure_password_toggled_event.dart';
import 'package:adopt_a_pet/presentation/events/login/login_performed_event.dart';
import 'package:adopt_a_pet/presentation/states/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  FirebaseServiceBase? _firebaseService;

  LoginBloc() : super(LoginState.createInitial()) {
    _firebaseService = SimpleIoCContainer.resolve<FirebaseServiceBase>();

    on<LoginPerformedEvent>(_onLoginPerformed);
    on<LoginObscurePasswordToggledEvent>(_onObscurePasswordToggled);
  }

  FutureOr<void> _onLoginPerformed(
    LoginPerformedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      LoginState.createForPerformLogin(
        previousState: state,
        isLoggedIn: false,
        isLoading: true,
      ),
    );

    final loginResult = await _firebaseService?.signInWithEmail(
      event.login,
      event.password,
    );

    if (loginResult?.isSuccess == true) {
      emit(
        LoginState.createForPerformLogin(
          previousState: state,
          isLoggedIn: true,
          isLoading: false,
        ),
      );
    } else {
      emit(
        LoginState.createForPerformLogin(
          previousState: state,
          isLoggedIn: false,
          isLoading: false,
          error: loginResult?.errorText,
        ),
      );
    }
  }

  FutureOr<void> _onObscurePasswordToggled(
    LoginObscurePasswordToggledEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(
      LoginState.createForObscurePasswordToggle(
        previousState: state,
      ),
    );
  }
}
