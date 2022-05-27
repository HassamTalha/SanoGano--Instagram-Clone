import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sanogano/Login/LoginScreen.dart';
import 'package:sanogano/pages/root_app.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () async {
      User user =  FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => RootApp(userId: user.uid),
            ),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Row()),
          Image.asset(
            "assets/images/SanoGanoLogo.png",
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset(
            "assets/splash.gif",
            height: 100,
          ),
          Expanded(child: Center()),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text("@copyrights reserved 2021"),
          )
        ],
      ),
    );
  }
}
