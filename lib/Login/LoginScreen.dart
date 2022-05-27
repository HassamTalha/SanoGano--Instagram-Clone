import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sanogano/ForgotPassword/resetPassword.dart';
import 'package:sanogano/Signup/SignupScreen.dart';
import 'package:sanogano/pages/root_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'LoginOptions.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController, _passController;
  @override
  void initState() {
    super.initState();
    setControllers();
  }

  addUserIdToSF(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userId", userId);
  }

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(),
                ),
                Image.asset(
                  "assets/images/SanoGanoLogo.png",
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Email"),
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
                      obscureText: true,
                      controller: _passController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Password"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResetPassword()));
                        },
                        child: Text("Forgot Password?"),
                      )
                    ],
                  ),
                ),
                RoundedLoadingButton(
                  width: MediaQuery.of(context).size.width - 16,
                  child: Text('    Login    ',
                      style: TextStyle(color: Colors.white)),
                  controller: _btnController,
                  onPressed: () {
                    loginUser(context);
                  },
                ),
                TextButton(
                    child: Text("Sign Up",
                        style: TextStyle(
                          color: Color(0xFFAC6434),
                        )),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    }),
                Expanded(
                  child: Container(
                    child: Center(
                      child: LoginOptions(_btnController),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setControllers() {
    _emailController = TextEditingController();
    _passController = TextEditingController();
  }

  void loginUser(context) async {
    if (!_emailController.text.contains("@") ||
        !_emailController.text.contains(".com")) {
      Fluttertoast.showToast(msg: "Enter a valid Email");
      _btnController.reset();
    }
    if (_emailController.text.isEmpty || _passController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill credentials",
      );
      _btnController.reset();
    } else {
      try {
        FirebaseAuth auth = FirebaseAuth.instance;
        UserCredential result = await auth.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passController.text.trim());
        print(result.user.uid);
        await addUserIdToSF(result.user.uid);
        clearControllers();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (_) => RootApp(userId: result.user.uid),
            ), (route) => false);
      } catch (error) {
        Fluttertoast.showToast(
          msg: getMessageFromErrorCode(error.code),
        );
         _btnController.reset();
      }
    }
  }

  void clearControllers() {
    _emailController.clear();
    _passController.clear();
  }
}
