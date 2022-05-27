import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sanogano/Login/LoginScreen.dart';
import 'package:sanogano/models/User.dart';

import 'package:toast/toast.dart';

import 'EmailAddressScreen.dart';
class PhoneNumberScreen extends StatefulWidget {
  final AppUser user;
  PhoneNumberScreen(this.user);
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController controller = TextEditingController();

  String initialCountry = 'US';

  PhoneNumber number = PhoneNumber(isoCode: 'US');
  bool isValidated = false;
  String phoneNumber = '';
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
            "What's your phone number?",
            style: TextStyle(
                color: Color(0xFF007596),
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1),
            ),
            child: InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                print(number.phoneNumber);
                phoneNumber = number.phoneNumber;
              },
              onInputValidated: (bool value) {
                print(value);
                isValidated = value;
              },
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.DIALOG,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              selectorTextStyle: TextStyle(color: Colors.black),
              initialValue: number,
              textFieldController: controller,
              formatInput: false,
              keyboardType:
                  TextInputType.numberWithOptions(signed: true, decimal: true),
              inputBorder: InputBorder.none,
              onSaved: (PhoneNumber number) {
                print('On Saved: $number');
              },
              onSubmit: () {
                validateAndAuthenticateUser();
              },
            ),
          ),
          SizedBox(height: 10),
          Text(
            """You’ll use this number when you log in and if you ever need to reset your password.""",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.white,
            onPressed: () {
              validateAndAuthenticateUser();
            },
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Center(
                child: Text(
                  "Continue",
                  style: TextStyle(
                      color: Color(0xFF943E3D), fontWeight: FontWeight.w500),
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

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void validateAndAuthenticateUser() {
    if (isValidated && phoneNumber.isNotEmpty) {
      AppUser user = widget.user.copyWith(phoneNumber: phoneNumber);
      print(user.phoneNumber);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => EmailAddressScreen(user)));
    }
    else{
      Toast.show("Please enter a valid Phone Number", context);
    }
  }
}
