import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'FeedbackPage.dart';
import 'LandingPage.dart';
import 'LoginScreenPage.dart';
import 'ScanTheObjectPage.dart';
import 'ShowTheSignPage.dart';
import 'SignUpScreenPage.dart';
import 'SplashScreenPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
// Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const SplashScreen(),
      '/second': (context) => const LoginScreen(),
      '/third': (context) => const SignUpScreen(),
      '/forth': (context) => const LandingPageState(),
      '/fifth': (context) => ScanTheObjectState(camera: firstCamera),
      '/sixth': (context) => ShowTheSignState(className: name),
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
