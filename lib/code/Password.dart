import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyPassword extends StatelessWidget {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
            
            changePassword();},
            child: Text(
              "Save",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          )
        ],
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
          "Password",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: currentPassword,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      border: InputBorder.none,
                      hintText: "Current Password"),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: newPassword,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      border: InputBorder.none,
                      hintText: "New Password"),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: confirmPassword,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      border: InputBorder.none,
                      hintText: "Re-enter New Password"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  changePassword() async {
    if (currentPassword.text.isEmpty ||
        newPassword.text.isEmpty ||
        confirmPassword.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter all the fields!");
      return;
    }
    if (newPassword.text.length < 8) {
      Fluttertoast.showToast(msg: "Password is too short");
      return;
    }
    if (newPassword.text != confirmPassword.text) {
      Fluttertoast.showToast(msg: "New password's fields does not match");
      return;
    }
    Fluttertoast.showToast(msg: "Processing...");
    bool userVerified = await validatePassword(currentPassword.text.trim());
    if (userVerified) {
      var firebaseUser =  FirebaseAuth.instance.currentUser;
      await firebaseUser.updatePassword(newPassword.text.trim());
      Fluttertoast.showToast(msg: "Password changed successfully!");
      currentPassword.clear();
      newPassword.clear();
      confirmPassword.clear();
    } else {
      Fluttertoast.showToast(msg: "Current User Password is incorrect!");
    }
  }

  Future<bool> validatePassword(String password) async {
    var firebaseUser =  FirebaseAuth.instance.currentUser;

    var authCredentials = EmailAuthProvider.credential(
        email: firebaseUser.email, password: password);
    try {
      var authResult =
          await firebaseUser.reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
