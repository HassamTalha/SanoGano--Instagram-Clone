import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sanogano/screens/StoryScreens/StoryScreen.dart';
import 'package:sanogano/screens/StoryScreens/StoryWidget.dart';

class Stories extends StatefulWidget {
  final String uid;
  Stories(this.uid);

  @override
  _StoriesState createState() => _StoriesState();
}

class _StoriesState extends State<Stories>
    with AutomaticKeepAliveClientMixin<Stories> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Stories")
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
          print("data : ${snapshot.data}");
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              {
                print("ConnectionState.none");
                return Center();
              }
            case ConnectionState.waiting:
              {
                print("ConnectionState.waiting");
                return Center(
                    child: SpinKitChasingDots(
                  color: Color(0xFF3B63A2),
                  size: 30,
                ));
              }
            case ConnectionState.active:
              {
                print("ConnectionState.active");

                return new ListView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  scrollDirection: Axis.horizontal,
                  children: snapshot.data.docs.map((document) {
                    // String docId = document.documentID;

                    return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StoryPage(
                                document['userID'],
                                document['userImage'],
                                document['userName'],
                              ),
                            ),
                          );
                        },
                        child: StoriesWidget(
                            document['media'], document['userImage']));
                  }).toList(),
                );
              }
            case ConnectionState.done:
              {
                print("ConnectionState.done");
                return Container();
              }
          }
        } else {
          return Center();
        }
        return Center(
          child: Text("Something Went Wrong !"),
        );
      },
    );
  }

  @override
  @override
  bool get wantKeepAlive {
    return true;
  }
}
