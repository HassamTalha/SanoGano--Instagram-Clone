import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';
import 'package:sanogano/models/User.dart';

import 'package:toast/toast.dart';

import 'PhoneNumberScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _usernameController,
      _passController,
      _confPassController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setControllers();
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
                  "assets/SanoGano Logo.png",
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
                      controller: _usernameController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "User Name"),
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
                      controller: _passController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Password"),
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
                      controller: _confPassController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Confirm Password"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  color: Color(0xFFAC6434),
                  child: InkWell(
                    onTap: () {
                      signupUser();
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                FlatButton(
                    child: Text("Login",
                        style: TextStyle(
                          color: Color(0xFF42528D),
                        )),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Expanded(
                  child: Container(),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "By tapping Sign Up, you agree to our ",
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Terms of use",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () => Toast.show('Terms of Use Tapped', context),
                        ),
                        TextSpan(
                          text: " and ",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () => Toast.show('Privacy Policy tapped', context),
                        ),
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setControllers() {
    _usernameController = TextEditingController();
    _passController = TextEditingController();
    _confPassController = TextEditingController();
  }

  void signupUser(){
    if(_usernameController.text.isEmpty){
      Toast.show("Please enter User Name", context);
    return ;
    }
    if(_passController.text.isEmpty){
      Toast.show("Please enter a valid password", context);
    return ;
    }
    if(_confPassController.text.isEmpty){
      Toast.show("Please fill confirm password", context);
    return ;
    }
    if(_passController.text != _confPassController.text){
      Toast.show("Passwords does not match!", context);
      return;
    }
    if(_passController.text.length < 8 || _confPassController.text.length < 8){
      Toast.show("Password should contain 8 characters!", context);
      return;
    }

    
    
    
    
    User user = User(name: _usernameController.text.trim(), password: _passController.text.trim());
    Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneNumberScreen(user)));
    
  }
}
