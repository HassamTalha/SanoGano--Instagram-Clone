import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';


class ResetPassword extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
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
                    "Reset your Password",
                    style: TextStyle(
                        color: Color(0xFF943E3D),
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Text(
                    """A Verification link will been sent to your Email. Please check that to reset your password""",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your registered email"),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Color(0xFF943E3D),
                    onPressed: () {
                      sendResetLink(context);
                    },
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Center(
                        child: Text(
                          "Send Reset Link",
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

  void sendResetLink(context) {
    if (emailController.text.isEmpty ||
        !emailController.text.contains("@") ||
        !emailController.text.contains(".com")) {
      Toast.show("Please enter valid email", context);
      return;
    }
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.sendPasswordResetEmail(email: emailController.text.trim());
    Toast.show("Password reset link sent", context);
    emailController.clear();
  }

  
}
