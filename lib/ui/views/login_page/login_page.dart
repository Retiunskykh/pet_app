import 'package:adopt_a_pet/presentation/bloc/login_bloc.dart';
import 'package:adopt_a_pet/presentation/events/login/login_obscure_password_toggled_event.dart';
import 'package:adopt_a_pet/presentation/events/login/login_performed_event.dart';
import 'package:adopt_a_pet/presentation/states/login_state.dart';
import 'package:adopt_a_pet/ui/views/login_page/register_row.dart';
import 'package:adopt_a_pet/ui/views/pet_screen/pet_screen.dart';
import 'package:adopt_a_pet/ui/views/signup_page/signup_page.dart';
import 'package:adopt_a_pet/ui/widgets/text/body1_text.dart';
import 'package:adopt_a_pet/ui/widgets/text/body2_text.dart';
import 'package:adopt_a_pet/ui/widgets/text/body3_text.dart';
import 'package:adopt_a_pet/ui/widgets/text/h2_text.dart';
import 'package:adopt_a_pet/ui/widgets/toolbar/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:ionicons/ionicons.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            onStateChanged(context, state);
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return createContent(context, state);
            },
          ),
        ),
      ),
    );
  }

  Widget createContent(BuildContext context, LoginState state) {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);

    return Container(
        color: Colors.white,
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Toolbar(
              title: '',
            ),
            const SizedBox(height: 144),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 64),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RegisterRow(
                          icon: Ionicons.mail_outline,
                          title: "Пошта",
                          textEditingController: emailController,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        RegisterRow(
                          icon: state.isPasswordObscured ? Ionicons.eye_outline : Ionicons.eye_off_outline,
                          title: "Пароль",
                          textEditingController: passwordController,
                          obscureText: state.isPasswordObscured,
                          keyboardType: TextInputType.text,
                          onPressedAction: () {
                            loginBloc.add(
                              LoginObscurePasswordToggledEvent(),
                            );
                          },
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    ScaleTap(
                      scaleMinValue: 0.95,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      ),
                      child: Body3Text(
                        text: "Dont have account? Register",
                        textColor: Colors.black,
                        textDecoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      alignment: Alignment.center,
                      child: ScaleTap(
                        scaleMinValue: 0.95,
                        onPressed: () {
                          loginBloc.add(
                            LoginPerformedEvent(
                              login: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.purple,
                          ),
                          child: Body2Text(
                            text: 'Login',
                            textColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  void onStateChanged(BuildContext context, LoginState state) {
    if (state.isLoggedIn) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PetScreen()),
      );
    }
  }
}
