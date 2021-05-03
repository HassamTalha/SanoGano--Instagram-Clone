import 'package:flutter/material.dart';

class MyFollowings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 17),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Colors.grey[200]),
                  height: MediaQuery.of(context).size.height / 15,
                  width: MediaQuery.of(context).size.width / 1,
                  child: TextField(
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      hintText: "Search",
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              FollowingList(),
              FollowingList(),
              FollowingList(),
              FollowingList(),
              FollowingList(),
              FollowingList(),
            ],
          )
        ],
      )),
    );
  }
}

class FollowingList extends StatelessWidget {
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
                  image: NetworkImage(
                    "https://media.istockphoto.com/photos/macho-man-picture-id1202142519?k=6&m=1202142519&s=612x612&w=0&h=7aTJXgG-0REO-DurbvMr1X6JcrDeGi784Vdkr-esjEA=",
                  ),
                  fit: BoxFit.cover)),
        ),
      ),
      title: Text("Spancer",
          style: TextStyle(
              fontSize: 17, color: Colors.black, fontWeight: FontWeight.w400)),
      subtitle: Text("spancer",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          )),
      trailing: Container(
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[400]),
        ),
        child: Text(
          "Follow",
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
        ),
      ),
    );
  }
}
