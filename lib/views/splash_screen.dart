import 'dart:async';
import 'package:flutter/material.dart ';
import './signIn_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignInScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/images/logo.png',
            // ),
            CircularProgressIndicator(
              color: Color(0xFFE78200),
            )
          ],
        ));
  }
}
