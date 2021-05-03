import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyfollowRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/Sort.ai.svg",
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
          onPressed: () {},
        ),
        title: Text(
          "Follow Requests",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Column(
            children: [
              SizedBox(
                height: 15,
              ),
              FollowRequestsModel(),
              SizedBox(
                height: 10,
              ),
              FollowRequestsModel(),
              SizedBox(
                height: 10,
              ),
              FollowRequestsModel(),
              SizedBox(
                height: 10,
              ),
              FollowRequestsModel(),
              SizedBox(
                height: 10,
              ),
              FollowRequestsModel(),
              SizedBox(
                height: 10,
              ),
              FollowRequestsModel(),
              SizedBox(
                height: 10,
              ),
              FollowRequestsModel(),
              SizedBox(
                height: 10,
              ),
              FollowRequestsModel(),
              SizedBox(
                height: 10,
              ),
              FollowRequestsModel(),
              SizedBox(
                height: 10,
              ),
              FollowRequestsModel(),
            ],
          )
        ],
      ),
    );
  }
}

class FollowRequestsModel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
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
        title: Text("Spancer",
            style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w400)),
        subtitle: Text("1 mutual friend\n1 m",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            )),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "assets/icons/Checkmark.ai.svg",
              height: 23,
              color: Colors.black,
            ),
            SizedBox(
              width: 10,
            ),
            SvgPicture.asset(
              "assets/icons/X.ai.svg",
              height: 23,
              color: Colors.black,
            ),
          ],
        ));
  }
}
