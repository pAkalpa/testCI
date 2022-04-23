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
      '/': (context) => SplashScreen(),
      '/second': (context) => LoginScreen(),
      '/third': (context) => SignUpScreen(),
      '/forth': (context) => LandingPageState(),
      '/fifth': (context) => ScanTheObjectState(camera: firstCamera),
      '/sixth': (context) => ShowTheSignState(className: name),
      '/seventh': (context) => FeedbackPageState(),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
