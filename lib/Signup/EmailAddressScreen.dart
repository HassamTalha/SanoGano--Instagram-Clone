import 'package:flutter/material.dart';
import 'package:sanogano/Login/LoginScreen.dart';
import 'package:sanogano/Signup/ConfirmAccountScreen.dart';
import 'package:sanogano/models/User.dart';

import 'package:toast/toast.dart';
class EmailAddressScreen extends StatefulWidget {
  final AppUser user;
  EmailAddressScreen(this.user);
  @override
  _EmailAddressScreenState createState() => _EmailAddressScreenState();
}

class _EmailAddressScreenState extends State<EmailAddressScreen> {
  final TextEditingController _emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          Text(
            "What's your Email Address?",
            style: TextStyle(
                color: Color(0xFF943E3D),
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: _emailcontroller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter your email address"
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            """You’ll use this email address when you log in and if you ever need to reset your password.""",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.white,
            onPressed: () {
              sendOTP();
                            
                          },
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Center(
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                  color: Color(0xFF007596),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        
                        FlatButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                                (route) => false);
                          },
                          child: Text(
                            "Already Have an Account?",
                            style: TextStyle(
                              color: Color(0xFF42528D),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
                }
              
                @override
                void dispose() {
                  _emailcontroller?.dispose();
                  super.dispose();
                }
              
                void sendOTP() {
                  if(_emailcontroller.text.isEmpty || !_emailcontroller.text.contains("@") || !_emailcontroller.text.contains(".com")){
                    Toast.show("Please enter a valid Email Address", context);
                  }
                  else{
                    AppUser user = widget.user.copyWith(email: _emailcontroller.text.trim());
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ConfirmAccountScreen(user)));
                  }
                }
}
