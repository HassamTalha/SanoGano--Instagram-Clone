import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sanogano/code/widgets/CustomSwitch.dart';

import 'BlockAccount.dart';
import 'Notifications.dart';

class MyPrivecy extends StatelessWidget {
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
          "Privacy",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          PrivecyModel("Private Account"),
          PrivecyModel("Stories"),
          PrivecyModel("Face/Touch ID"),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyBlockAccounts()));
              },
              child: NotificationModel("Block Accounts"))
        ],
      ),
    );
  }
}

class PrivecyModel extends StatelessWidget {
  final String text;
  PrivecyModel(this.text);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        text,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
      ),
      trailing: MyCustomswitch(),
    );
  }
}
