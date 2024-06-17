class LoginState {
  bool isLoggedIn;
  bool isLoading;
  bool isPasswordObscured;
  String? error;

  LoginState({
    required this.isLoggedIn,
    required this.isLoading,
    required this.isPasswordObscured,
    this.error,
  });

  static createInitial() {
    return LoginState(
      isLoggedIn: false,
      isLoading: false,
      isPasswordObscured: true,
    );
  }

  static createForPerformLogin({
    required LoginState previousState,
    required bool isLoggedIn,
    required bool isLoading,
    String? error,
  }) {
    return LoginState(
      isLoggedIn: isLoggedIn,
      isLoading: isLoading,
      isPasswordObscured: previousState.isPasswordObscured,
      error: error,
    );
  }

  static createForObscurePasswordToggle({
    required LoginState previousState,
  }) {
    return LoginState(
      isLoggedIn: previousState.isLoggedIn,
      isLoading: previousState.isLoading,
      isPasswordObscured: !previousState.isPasswordObscured,
      error: previousState.error,
    );
  }

  static createForThemeUpdate({
    required LoginState previousState,
  }) {
    return LoginState(
      isLoggedIn: previousState.isLoggedIn,
      isLoading: previousState.isLoading,
      isPasswordObscured: previousState.isPasswordObscured,
      error: previousState.error,
    );
  }
}
