import 'package:flutter/material.dart';
import 'package:multigroup_project/screens/welcome_screen.dart';
import 'package:splashscreen/splashscreen.dart' as ss;
import 'package:firebase_auth/firebase_auth.dart';

import 'news_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ss.SplashScreen(
        seconds: 3,
        image: new Image.asset('assets/images/logo.png'),
        backgroundColor: Colors.black,
        photoSize: 100,
        navigateAfterSeconds: FirebaseAuth.instance.currentUser == null ? WelcomePage() : NewsScreen(),
      ),
    );
  }
}
