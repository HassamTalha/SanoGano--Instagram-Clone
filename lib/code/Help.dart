import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHelp extends StatelessWidget {
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
          "Help",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Text(
              "Contact Us",
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
              "Help Center",
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
