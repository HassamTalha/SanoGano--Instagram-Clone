import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sanogano/Login/LoginScreen.dart';
import 'package:sanogano/models/User.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'package:toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ConfirmAccountScreen extends StatefulWidget {
  final AppUser user;
  ConfirmAccountScreen(this.user);
  @override
  _ConfirmAccountScreenState createState() => _ConfirmAccountScreenState();
}

class _ConfirmAccountScreenState extends State<ConfirmAccountScreen> {
  final TextEditingController codeController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _verificationId;
  final SmsAutoFill _autoFill = SmsAutoFill();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    registerAndSendVerificationCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    "Confirm your account",
                    style: TextStyle(
                        color: Color(0xFF943E3D),
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Text(
                    """A Verification link has been sent to your Email. Please check that to verify your email""",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     border: Border.all(width: 1),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //     child: TextField(
                  //       controller: codeController,
                  //       textAlign: TextAlign.center,
                  //       decoration: InputDecoration(
                  //           border: InputBorder.none, hintText: "Enter code"),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 20),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Color(0xFF943E3D),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => false);
                    },
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  // FlatButton(
                  //   textColor: Color(0xFF943E3D),
                  //   child: Text("Send Code Again"),
                  //   onPressed: () {},
                  // ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void registerAndSendVerificationCode() async {
    signUp(widget.user).then((value) {
      if (!value) {
        Toast.show("SomeThing went Wrong! Try again later!", context);
      }
    });
  }

  Future<bool> signUp(AppUser user) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: user.email, password: user.password);
    try {
      await result.user.sendEmailVerification();
      print(result.user.uid);
      saveUserToDatabase(result.user);

      return Future.value(true);
    } catch (e) {
      Toast.show(
          "An error occured while trying to send email verification", context);
      print(e.message);
      return Future.value(false);
    }
  }

  void saveUserToDatabase(User user) {
    widget.user.accountCreated = Timestamp.now();
    widget.user.bio= "Bio";
    widget.user.followers = 00;
    widget.user.following = 00;
    widget.user.url = "...";
     widget.user.username = "Username";
     widget.user.profileDP = "default";

    FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid)
        .set(widget.user.toMap());
  }
}
