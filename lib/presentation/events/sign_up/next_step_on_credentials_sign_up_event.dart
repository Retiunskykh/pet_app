import 'package:adopt_a_pet/presentation/events/sign_up/sign_up_event.dart';

class NextStepOnCredentialsSignUpEvent extends SignUpEvent {
  final String email;
  final String password;
  final String confirmPassword;

  NextStepOnCredentialsSignUpEvent({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
