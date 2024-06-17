import 'package:adopt_a_pet/ioc/bootstrapper.dart';
import 'package:adopt_a_pet/presentation/bloc/login_bloc.dart';
import 'package:adopt_a_pet/presentation/bloc/pet_info_screen_bloc.dart';
import 'package:adopt_a_pet/presentation/bloc/pet_screen_bloc.dart';
import 'package:adopt_a_pet/presentation/bloc/saved_pet_screen_bloc.dart';
import 'package:adopt_a_pet/presentation/bloc/sign_up_bloc.dart';
import 'package:adopt_a_pet/ui/views/login_page/login_page.dart';
import 'package:adopt_a_pet/ui/views/pet_screen/pet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  Bootstrapper.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PetInfoScreenBloc>(
          create: (BuildContext context) => PetInfoScreenBloc(),
        ),
        BlocProvider<PetScreenBloc>(
          create: (BuildContext context) => PetScreenBloc(),
        ),
        BlocProvider<SignUpBloc>(
          create: (BuildContext context) => SignUpBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(),
        ),
        BlocProvider<SavedPetScreenBloc>(
          create: (BuildContext context) => SavedPetScreenBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: LoginPage(),
      ),
    );
  }
}
