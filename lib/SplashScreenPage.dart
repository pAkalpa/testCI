import 'dart:async';

import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';

import 'LoginScreenPage.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => LoginScreen()
    ));
  }
  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }
  Widget initWidget(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Colors.cyan, Colors.blueGrey],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                )
            ),
          ),
          Center(
            child: Container(
              child: Image.asset('assets/logo/logo_transparent.png'),
              height: 125,
              width: 125,
            ),
          )
        ],
      ),
    );
  }
}