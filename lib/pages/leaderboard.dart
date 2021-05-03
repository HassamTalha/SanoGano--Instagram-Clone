import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:sanogano/code/HomePage.dart';

class MyLeaderboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
                padding: EdgeInsets.only(right: 10),
                icon: SvgPicture.asset(
                  "assets/images/Filter.ai.svg",
                  height: 24,
                  color: Colors.black,
                ),
                onPressed: () {
                   Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                })
          ],
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset(
              "assets/images/Back.ai.svg",
              height: 25,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Leaderboard",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  LeaderboardRow("1.", "Spancer", "100,000,00"),
                  LeaderboardRow("2.", "Spancer", "900,000,00"),
                  LeaderboardRow("3.", "Spancer", "800,000,00"),
                  LeaderboardRow("4.", "Spancer", "700,000,00"),
                  LeaderboardRow("5.", "Spancer", "600,000,00"),
                  LeaderboardRow("6.", "Spancer", "500,000,00"),
                  LeaderboardRow("7.", "My Number", "400,000,00"),
                  LeaderboardRow("8.", "Spancer", "300,000,00"),
                ],
              ),
            ),
          ],
        ));
  }
}

class LeaderboardRow extends StatelessWidget {
  final String text;
  final String text2;
  final String text3;
  LeaderboardRow(this.text, this.text2, this.text3);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        Expanded(
          child: ListTile(
            leading: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.grey[200],
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(300),
                    border: Border.all(color: Colors.pink),
                    image: DecorationImage(
                        image: AssetImage('assets/images/ibrahim.jpg'),
                        fit: BoxFit.cover)),
              ),
            ),
            title: Text(text2,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400)),
            subtitle: Text("spancer",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                )),
            trailing: Text(
              text3,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
