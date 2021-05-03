import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyAbout extends StatelessWidget {
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
          "About",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Text(
              "Privacy Policy",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            trailing: SvgPicture.asset(
              "assets/icons/Forward.ai.svg",
              height: 20,
              color: Colors.black,
            ),
          ),
          ListTile(
            leading: Text(
              "Terms of Use",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            trailing: SvgPicture.asset(
              "assets/icons/Forward.ai.svg",
              height: 20,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
