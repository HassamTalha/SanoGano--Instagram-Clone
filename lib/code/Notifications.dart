import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Comments.dart';
import 'Likes.dart';
import 'Requests.dart';
import 'TabBar/Followers.dart';
import 'Taged.dart';

class MyNotifications extends StatelessWidget {
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
            Navigator.pop(context);},
        ),
        title: Text(
          "Notifications",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyComments()));
              },
              child: NotificationModel("Comments")),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyFollowers()));
              },
              child: NotificationModel("Followers")),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Mylikes()));
              },
              child: NotificationModel("Likes")),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyRequests()));
              },
              child: NotificationModel("Requests")),
          InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyTags()));
              },
              child: NotificationModel("Tagged")),
        ],
      ),
    );
  }
}

class NotificationModel extends StatelessWidget {
  final String text;
  NotificationModel(this.text);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        text,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
      ),
      trailing: SvgPicture.asset(
        "assets/icons/Forward.ai.svg",
        height: 20,
        color: Colors.black,
      ),
    );
  }
}
