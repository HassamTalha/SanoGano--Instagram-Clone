import 'package:flutter/material.dart';


import 'FollowPage.dart';
import 'FollowRequests.dart';
import 'FollowersRequests.dart';
import 'Groups.dart';

import 'List.dart';
import 'Suggestion.dart';


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
         SafeArea(
            child: ListView(
      children: [
        Column(
          children: [
          
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                child: Text("FollowPage"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FollowPage()));
                }),
            SizedBox(
              height: 10,
            ),
           
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                child: Text("List"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyList()));
                }),
            SizedBox(
              height: 10,
            ),
            
            SizedBox(
              height: 10,
            ),
           
            SizedBox(
              height: 10,
            ),
           
            SizedBox(
              height: 10,
            ),
           
            SizedBox(
              height: 10,
            ),
           
            SizedBox(
              height: 10,
            ),
            
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                child: Text("Groups"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Groups()));
                }),
            SizedBox(
              height: 10,
            ),
           
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                child: Text("Requests"),
                onPressed: () {
                 
                }),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                child: Text("Suggestions"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Suggestions()));
                }),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                child: Text("Follow Requests"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyfollowRequests()));
                }),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                child: Text("Followersss Requests"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyRequsts()));
                }),
            SizedBox(
              height: 10,
            ),
            
       
            SizedBox(
              height: 10,
            ),
          
            ElevatedButton(
                child: Text("Followings"),
                onPressed: () {
                  
                }),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            
          ],
        ),
      ],
    ));
  }
}
