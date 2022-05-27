import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sanogano/Login/LoginScreen.dart';

import 'About.dart';
import 'EditProfile.dart';
import 'Help.dart';

import 'Notifications.dart';
import 'Password.dart';
import 'Privecy.dart';
import 'QRScan.dart';

class MySettings extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset(
              "assets/icons/Back.ai.svg",
              height: 25,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Settings",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16, top: 10),
          child: Column(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyEditProfile()));
                  },
                  child: SettingsModel("Edit Profile.ai", "Edit Profile")),
              SizedBox(
                height: 25,
              ),
              SettingsModel("Invite Friends.ai", "Invite Friends"),
              SizedBox(
                height: 25,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyQrScan()));
                  },
                  child: SettingsModel("QR Code.ai", "QR Code")),
              SizedBox(
                height: 55,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyNotifications()));
                  },
                  child: SettingsModel("Notifications.ai", "Notifications")),
              SizedBox(
                height: 25,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyPassword()));
                  },
                  child: SettingsModel("Password.ai", "Password")),
              SizedBox(
                height: 25,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyPrivecy()));
                  },
                  child: SettingsModel("Privacy.ai", "Privacy Policy")),
              SizedBox(
                height: 55,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyAbout()));
                  },
                  child: SettingsModel("About.ai", "Abouts")),
              SizedBox(
                height: 25,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHelp()));
                  },
                  child: SettingsModel("Help.ai", "Help")),
              SizedBox(
                height: 25,
              ),
              InkWell(
                  onTap: () {
                     GoogleSignIn _googleSignIn = GoogleSignIn();
              _googleSignIn.disconnect();
                    FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false);
                  },
                  child: SettingsModel("Log Out.ai", "Log Out")),
            ],
          ),
        ));
  }
}

class SettingsModel extends StatelessWidget {
  final String image;
  final String text;

  SettingsModel(this.image, this.text);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/$image.svg",
          height: 33,
          color: Colors.black,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w400, color: Colors.black),
        ),
      ],
    );
  }
}
