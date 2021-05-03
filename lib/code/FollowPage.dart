import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'TabBar/Followers.dart';
import 'TabBar/Following.dart';


class FollowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Suggested.ai.svg",
                height: 24,
                color: Colors.black,
              ),
              onPressed: () {},
            )
          ],
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
            "Spancer",
            style: TextStyle(
                fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: SafeArea(
            child: Column(
          children: [
            TabBar(
                labelStyle: TextStyle(fontSize: 15),
                unselectedLabelColor: Colors.grey[600],
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                tabs: <Widget>[
                  Tab(
                    text: "Followers",
                  ),
                  Tab(
                    text: "Following",
                  ),
                ]),
            Expanded(
              child: TabBarView(children: <Widget>[
                MyFollowers(),
                MyFollowings(),
              ]),
            )
          ],
        )),
      ),
    );
  }
}
