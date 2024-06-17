class LoginResponse {
  bool isSuccess;
  String? errorText;

  LoginResponse({
    required this.isSuccess,
    this.errorText,
  });
}
