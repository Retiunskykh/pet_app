// ignore_for_file: avoid_print

import 'package:adopt_a_pet/api/login_response.dart';
import 'package:adopt_a_pet/api/services/base/firebase_service_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseService implements FirebaseServiceBase {
  @override
  Future<LoginResponse> createAccount(
    String email,
    String password,
  ) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString(
        'uid',
        credential.user != null ? credential.user!.uid : '',
      );

      return LoginResponse(
        isSuccess: true,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return LoginResponse(
          isSuccess: false,
          errorText: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        return LoginResponse(
          isSuccess: false,
          errorText: 'The account already exists for that email.',
        );
      } else {
        return LoginResponse(
          isSuccess: false,
          errorText: 'Uncaught error',
        );
      }
    } catch (e) {
      return LoginResponse(
        isSuccess: false,
        errorText: 'Uncaught error',
      );
    }
  }

  @override
  Future<LoginResponse> signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString(
        'uid',
        credential.user != null ? credential.user!.uid : '',
      );

      return LoginResponse(
        isSuccess: true,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return LoginResponse(
          isSuccess: false,
          errorText: 'No user found for that email.',
        );
      } else if (e.code == 'wrong-password') {
        return LoginResponse(
          isSuccess: false,
          errorText: 'Wrong password provided for that user.',
        );
      } else {
        return LoginResponse(
          isSuccess: false,
          errorText: 'Uncaught error',
        );
      }
    }
  }
}
