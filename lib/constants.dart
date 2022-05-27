
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String getMessageFromErrorCode(errorCode) {
    switch (errorCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
        break;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        return "Server error, please try again later.";
        break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";
        break;
      default:
        return "Login failed. Please try again.";
        break;
    }
  }


  
List<String> friendNames = [
  "Hassam Talha",
  "Aaqib Mushtak",
  "Elon Musk",
  "Jeff Bezos",
  "Jack Ma",
  "David",
  "Henry",
  "Maya",
  "Eleesa",
  "Ema Watson"
];
List<String> friendDps = [
"https://upload.wikimedia.org/wikipedia/commons/e/ed/Elon_Musk_Royal_Society.jpg",
"https://upload.wikimedia.org/wikipedia/commons/e/ed/Elon_Musk_Royal_Society.jpg",
  "https://upload.wikimedia.org/wikipedia/commons/e/ed/Elon_Musk_Royal_Society.jpg",
  "https://viewpointhousingnews.com/wp-content/uploads/2020/02/Jeff-Bozes.jpg",
  "https://static.theprint.in/wp-content/uploads/2020/11/Jack-Ma-696x392.jpg",
  "https://media.istockphoto.com/photos/handsome-man-picture-id907605102?k=6&m=907605102&s=612x612&w=0&h=Ix5b9FLOE8HzckUuvvA86F1OtMTZEOACwm3a_iTW6xk=",
  "https://media.istockphoto.com/photos/serious-young-afro-american-man-standing-in-studio-picture-id1040478272?k=6&m=1040478272&s=612x612&w=0&h=Mk0jXSE4vfRDgA1oMJsRRzwVw9TVEENDqi4Zr8FY0ns=",
  "https://media.istockphoto.com/photos/studio-shot-of-young-beautiful-woman-picture-id829627902?k=6&m=829627902&s=612x612&w=0&h=srWzsPoAtT_9YOe6qmEmu7nPh2RdKPlmJ9omNeAafek=",
  "https://media.istockphoto.com/photos/girl-with-red-lipstick-and-short-hair-in-black-tshirt-picture-id539953380?k=6&m=539953380&s=612x612&w=0&h=BNit7kOCDX-MkmRSJUkO-Z3PYRqZid25MkmPqniO3QY=",
  "https://media.istockphoto.com/photos/young-beautiful-woman-picture-id1050903354?k=6&m=1050903354&s=612x612&w=0&h=OWPVsGQxA-eiYS-I7iKuTO2Cq3sYQYxvUIuSapFN_70=",
];

const Color kRedColor = Color(0xffc0012a);
const Color kOrangeColor = Color(0xffed5f5f);
const Color kLightGreyColor = Color(0xffc9c9d9);
const Color kAshWhiteColor = Color(0xfff7f7f7);

final List<Color> myColors = [
    Colors.white,
    Color(0xFF792139),
    Color(0xFF233740),
    Color(0xFF6E257E),
    Color(0xFF5697FC),
    Color(0xFF736769),
    Color(0xFF57C8FD),
    Color(0xFF26C3DC),
    Color(0xFFFF7B6C),
    Color(0xFF56C266),
    Color(0xFFFE8A8B),
    Color(0xFF8B6991),
    Color(0xFFC79FCD),
    Color(0xFFF0B32F),
   
  
  ];
  Color mainColor = Color(0xFF3B63A2);

String createCryptoRandomString([int length = 32]) {
  final Random _random = Random.secure();
  var values = List<int>.generate(length, (i) => _random.nextInt(256));

  return base64Url.encode(values);
}

String uniqueID() {
  return new DateTime.now().millisecondsSinceEpoch.toString();
}