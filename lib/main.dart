import 'package:flutter/material.dart';

import 'FeedbackPage.dart';
import 'LandingPage.dart';
import 'LoginScreenPage.dart';
import 'ShowTheSignPage.dart';
import 'SignUpScreenPage.dart';
import 'SplashScreenPage.dart';
import 'home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();



  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const SplashScreen(),
      '/second': (context) => const LoginScreen(),
      '/third': (context) => const SignUpScreen(),
      '/forth': (context) => const LandingPageState(),
      '/fifth': (context) => const Home(),
      '/sixth': (context) => ShowTheSignState(classLabel: name),
      '/seventh': (context) => const FeedbackPageState(),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
