import 'package:adopt_a_pet/extensions/string_extensions.dart';

class SignUpState {
  bool needObscurePassword;
  bool hasError;
  String errorText;
  bool isSuccessfullyFinished;

  SignUpState({
    required this.needObscurePassword,
    required this.hasError,
    required this.errorText,
    required this.isSuccessfullyFinished,
  });

  static createInitial() {
    return SignUpState(
      needObscurePassword: true,
      hasError: false,
      errorText: StringExtensions.empty(),
      isSuccessfullyFinished: false,
    );
  }

  static createForToggleObscurePassword({
    required SignUpState previousState,
  }) {
    return SignUpState(
      needObscurePassword: !previousState.needObscurePassword,
      hasError: previousState.hasError,
      errorText: previousState.errorText,
      isSuccessfullyFinished: previousState.isSuccessfullyFinished,
    );
  }

  static createForError({
    required SignUpState previousState,
    required String errorText,
  }) {
    return SignUpState(
      needObscurePassword: previousState.needObscurePassword,
      hasError: true,
      errorText: errorText,
      isSuccessfullyFinished: false,
    );
  }

  static createForRemoveError({
    required SignUpState previousState,
  }) {
    return SignUpState(
      needObscurePassword: previousState.needObscurePassword,
      hasError: false,
      errorText: StringExtensions.empty(),
      isSuccessfullyFinished: false,
    );
  }

  static createForSuccess({
    required SignUpState previousState,
  }) {
    return SignUpState(
      needObscurePassword: previousState.needObscurePassword,
      hasError: false,
      errorText: StringExtensions.empty(),
      isSuccessfullyFinished: true,
    );
  }
}
