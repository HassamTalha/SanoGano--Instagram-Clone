import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sanogano/models/User.dart';
import 'package:sanogano/pages/root_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginScreen.dart';

// ignore: must_be_immutable
class LoginOptions extends StatefulWidget {
   final RoundedLoadingButtonController _btnController ;
   LoginOptions(this._btnController);
  @override
  _LoginOptionsState createState() => _LoginOptionsState();
}

class _LoginOptionsState extends State<LoginOptions> {
  double width;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
              onTap: appleSignIn,
              child: Image.asset(
                "assets/apple.png",
                height: width * 0.15,
              )),
          InkWell(
              onTap:(){}, 
              //facebookSignIn,
              child: Image.asset(
                "assets/facebook.png",
                height: width * 0.15,
              )),
          InkWell(
             onTap: googleSignIn,
             
              child: Image.asset(
                "assets/google.png",
                height: width * 0.15,
              )),
        ],
      ),
    );
  }

  googleSignIn() async {
    widget._btnController.start();
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;
      GoogleSignInAccount _user = googleUser;
      final googleAuth = await googleUser.authentication;

      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(credentials);
      User user = result.user;
      final AppUser appUser = AppUser(
        accountCreated: Timestamp.now(),
        bio: "Bio",
        email: user.email,
        followers: 0,
        following: 0,
        name: user.displayName,
        password: "Google Authenticated",
        phoneNumber: user.phoneNumber,
        url: "...",
        username: "Username",
        profileDP: user.photoURL,

      );
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .set(appUser.toMap());
      // asdsad
      await addUserIdToSF(user.uid);
      widget._btnController.reset();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RootApp(userId: user.uid),
          ));
    } catch (e) {
      print("${e.code} :: ${e.message}");
      Fluttertoast.showToast(msg: "Oops! Something went wrong!");
      widget._btnController.error();
      Timer(Duration(seconds: 2), (){

        widget._btnController.reset();
      });
    }

    // try {
    //   FacebookLogin facebookSignIn = new FacebookLogin();
    //   await facebookSignIn.logOut();
    //   Fluttertoast.showToast(msg: "LoggedOUt");
    // } catch (e) {
    //   Fluttertoast.showToast(msg: "Something went wrong in logout !");
    // }
  }

  addUserIdToSF(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userId", userId);
  }

  appleSignIn() async {}

  facebookSignIn() async {
    var facebooklogin = FacebookLogin();
    FacebookLoginResult result = await facebooklogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.error:
        print("Error");
        Fluttertoast.showToast(msg: "Something went wrong!");
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        final String token = result.accessToken.token;
        final response = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
        final profile = jsonDecode(response.body);
        print(profile);

        break;
    }
  }
}
