import 'package:adopt_a_pet/api/login_response.dart';

abstract class FirebaseServiceBase {
  Future<LoginResponse> createAccount(
    String email,
    String password,
  );

  Future<LoginResponse> signInWithEmail(
    String email,
    String password,
  );
}
