import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:sanogano/constant/post_json.dart';
import 'package:sanogano/constant/story_json.dart';

import 'package:sanogano/widgets/story_item.dart';

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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: List.generate(stories.length, (index) {
                return StoryItem(
                  img: stories[index]['img'],
                  name: stories[index]['name'],
                  flag: stories[index]['user'],
                );
              })),
            ),
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
                  stream: Firestore.instance
                      .collection("users")
                      .document("mkrjnihnGDNMWsOWvMXpUbYjEhy1")
                      .collection("videos")
                      .orderBy("uploadedAt", descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return ListView(
                          // itemCount: snapshot.data.documents.length,
                          children: snapshot.data.documents.map((e) {
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
          SizedBox(height:130),
          ],
          
        ),
      ),
    );
  }
}
