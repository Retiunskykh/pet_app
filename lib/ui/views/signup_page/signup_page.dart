import 'package:adopt_a_pet/presentation/bloc/sign_up_bloc.dart';
import 'package:adopt_a_pet/presentation/events/sign_up/next_step_on_credentials_sign_up_event.dart';
import 'package:adopt_a_pet/presentation/events/sign_up/toggle_obscure_password_sign_up_event.dart';
import 'package:adopt_a_pet/presentation/states/sign_up_state.dart';
import 'package:adopt_a_pet/ui/views/login_page/login_page.dart';
import 'package:adopt_a_pet/ui/views/login_page/register_row.dart';
import 'package:adopt_a_pet/ui/views/pet_screen/pet_screen.dart';
import 'package:adopt_a_pet/ui/widgets/text/body1_text.dart';
import 'package:adopt_a_pet/ui/widgets/text/body2_text.dart';
import 'package:adopt_a_pet/ui/widgets/text/body3_text.dart';
import 'package:adopt_a_pet/ui/widgets/toolbar/toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:ionicons/ionicons.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            onStateChanged(context, state);
          },
          child: BlocBuilder<SignUpBloc, SignUpState>(
            builder: (context, state) {
              return createContent(context, state);
            },
          ),
        ),
      ),
    );
  }

  Widget createContent(BuildContext context, SignUpState state) {
    final SignUpBloc signUpBloc = BlocProvider.of<SignUpBloc>(context);

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
                          icon: state.needObscurePassword ? Ionicons.eye_outline : Ionicons.eye_off_outline,
                          title: "Пароль",
                          textEditingController: passwordController,
                          obscureText: state.needObscurePassword,
                          keyboardType: TextInputType.text,
                          onPressedAction: () {
                            signUpBloc.add(
                              ToggleObscurePasswordSignUpEvent(),
                            );
                          },
                        ),
                        RegisterRow(
                          title: "Пароль",
                          textEditingController: confirmPasswordController,
                          obscureText: state.needObscurePassword,
                          keyboardType: TextInputType.text,
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    ScaleTap(
                      scaleMinValue: 0.95,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      ),
                      child: Body3Text(
                        text: "Already have an account? Login",
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
                          signUpBloc.add(
                            NextStepOnCredentialsSignUpEvent(
                              email: emailController.text,
                              password: passwordController.text,
                              confirmPassword: confirmPasswordController.text,
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
                            text: 'Signup',
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

  void onStateChanged(BuildContext context, SignUpState state) {
    if (state.isSuccessfullyFinished) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PetScreen()),
      );
    }
  }
}
