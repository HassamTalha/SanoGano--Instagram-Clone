import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:sanogano/screens/StoryScreens/Stories.dart';
import 'package:sanogano/screens/StoryScreens/StoriesLoadingWidget.dart';

import 'package:sanogano/screens/StoryScreens/StoryUploadButton.dart';

import '../widgets/post_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: getUserData(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return StoriesLoadingWidget();
                } else {
                  List<dynamic> userData = snapshot.data;
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.2,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          StoriesUploadButton(userData, userData[1] != "default"),
                          Expanded(child: Stories(userData[0][0])),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
            //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

            // ------------------------------------------------------------------------------
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //       children: List.generate(stories.length, (index) {
            //     return StoryItem(
            //       img: stories[index]['img'],
            //       name: stories[index]['name'],
            //       flag: stories[index]['user'],
            //     );
            //   })),
            // ),
            // ------------------------------------------------------------------------------
            // Column(
            //   children: List.generate(posts.length, (index) {
            //     return PostItem(
            //       postImg: posts[index]['postImg'],
            //       profileImg: posts[index]['profileImg'],
            //       name: posts[index]['name'],
            //       caption: posts[index]['caption'],
            //       isLoved: posts[index]['isLoved'],
            //       viewCount: posts[index]['commentCount'],
            //       likedBy: posts[index]['likedBy'],
            //       dayAgo: posts[index]['dayAgo'],
            //     );
            //   }),
            // )
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc("mkrjnihnGDNMWsOWvMXpUbYjEhy1")
                      .collection("videos")
                      .orderBy("uploadedAt", descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return ListView(
                          // itemCount: snapshot.data.documents.length,
                          children: snapshot.data.docs.map((e) {
                        return PostItem(
                          videoUrl: e["videoUrl"],
                          postImg: e["thumbUrl"],
                          profileImg: "assets/images/ibrahim.jpg",
                          name: e["videoName"],
                          isLoved: true,
                          // viewCount: posts[index]['commentCount'],
                          // likedBy: posts[index]['likedBy'],
                          // dayAgo: posts[index]['dayAgo'],
                        );
                      }).toList());
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            SizedBox(height: 130),
          ],
        ),
      ),
    );
  }

  Future<List<dynamic>> getUserData() async {
    List<dynamic> data = [0,1];
    User user =  FirebaseAuth.instance.currentUser;

    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("Users").doc(user.uid).get();
    List<String> info = [user.uid, doc["name"], " ",];
    data[0] = info;
    data[1] = doc["profileDP"];
return data;
  }
}
