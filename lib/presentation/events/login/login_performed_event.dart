import 'package:adopt_a_pet/presentation/events/login/login_event.dart';

class LoginPerformedEvent implements LoginEvent {
  final String login;
  final String password;

  LoginPerformedEvent({
    required this.login,
    required this.password,
  });
}
