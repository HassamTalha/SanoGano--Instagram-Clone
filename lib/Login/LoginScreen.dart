import 'package:flutter/material.dart';
import 'package:sanogano/ForgotPassword/resetPassword.dart';
import 'package:sanogano/Signup/SignupScreen.dart';
import 'package:sanogano/pages/root_app.dart';

import 'package:toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController, _passController;
  bool signedIn = false;
  @override
  void initState() {
    super.initState();
    setControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: FutureBuilder(
        future: getUserStatus(),
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          String email = "";
          if (snapshot.hasData && snapshot.data != null) {
            email = snapshot.data.email;
          }
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: signedIn,
                      child: ListTile(
                        title: Text("User Already Signed In"),
                        subtitle: Text(email),
                        leading: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                        trailing: FlatButton(
                          child: Text("Sign Out"),
                          onPressed: () {
                            FirebaseAuth auth = FirebaseAuth.instance;
                            auth.signOut();
                            setState(() {
                              signedIn = false;
                            });
                          },
                        ),
                      ),
                    ),
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
                    Card(
                      color: Color(0xFF42528D),
                      child: InkWell(
                        onTap: () {
                          loginUser(context);
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
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
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void setControllers() {
    _emailController = TextEditingController();
    _passController = TextEditingController();
  }

  void loginUser(context) async {
    if (_emailController.text.isEmpty || _passController.text.isEmpty) {
      Toast.show("Please fill credentials", context);
    } else {
      try {
        FirebaseAuth auth = FirebaseAuth.instance;
        AuthResult result = await auth.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passController.text.trim());

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RootApp(userId: result.user.uid),
              //  CreatePostScreen(
              //   imageFile: croppedImage,
              // ),
            ));
        // Toast.show("LoggedIn : ${result.user.uid}", context);
        clearControllers();
      } catch (error) {
        Toast.show(getMessageFromErrorCode(error.code), context);
      }
    }
  }

  void clearControllers() {
    _emailController.clear();
    _passController.clear();
    setState(() {});
  }

  Future<FirebaseUser> getUserStatus() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseUser user = await auth.currentUser();
    if (user != null) {
      setState(() {
        signedIn = true;
      });
    }
    return user;
  }
}
