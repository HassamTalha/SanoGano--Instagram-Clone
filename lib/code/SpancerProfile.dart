import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'TabBar2/All.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: FutureBuilder(
        future: getUserID(),
        //toBeginningOfSentenceCase(doc["name"])
              builder: (context, snapshot){
                if(snapshot.hasData && snapshot.data!=null){

                  return 
              
              
              StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Users").doc(snapshot.data).get().asStream(),
          builder: (context,AsyncSnapshot<DocumentSnapshot> snap) {
           if(snap.hasData && snap.data!=null){
             DocumentSnapshot doc = snap.data;
return   SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height + 150,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width<=388?MediaQuery.of(context).size.height / 4 + 70:MediaQuery.of(context).size.height / 4 + 85,
                      width: MediaQuery.of(context).size.width,
                      // color: Colors.blue,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 8 + 40,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:  AssetImage('assets/images/Img.jpg'),
                                        fit: BoxFit.cover)),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 02),
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 110,
                                width: 110,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: CircleAvatar(
                                        radius:
                                            MediaQuery.of(context).size.height / 16 +
                                                25,
                                        backgroundColor: Colors.grey[200],
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(300),
                                              border: Border.all(color: Colors.black),
                                              image: DecorationImage(
                                                  image: doc["profileDP"] == "default" ?  AssetImage('assets/default_avatar.png') : NetworkImage(doc["profileDP"]),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 8 + 40,
                            ),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ColumnModel(doc["followers"], doc["following"]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                     toBeginningOfSentenceCase(doc["name"]),
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      toBeginningOfSentenceCase(doc["bio"]),
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                    doc["url"],
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      
                      "ESTEBLISHED ${DateFormat('MM yyyy').format(doc["accountCreated"].toDate())}",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TabBar(
                        labelStyle: TextStyle(fontSize: 12),
                        unselectedLabelColor: Colors.grey[600],
                        indicatorColor: Colors.black,
                        labelColor: Colors.black,
                        tabs: <Widget>[
                          Tab(
                            text: "All",
                          ),
                          Tab(
                            text: "Media",
                          ),
                          Tab(
                            text: "Reciepe",
                          ),
                          Tab(
                            text: "Workout",
                          ),
                          Tab(
                            text: "Tagged",
                          ),
                        ]),
                    Expanded(
                      child: TabBarView(children: <Widget>[
                        MyAll(),
                        MyAll(),
                        MyAll(),
                        MyAll(),
                        MyAll(),
                        // MyMedia(),
                        // MyReciepe(),
                        // MyWorkout(),
                        // MyTagged(),
                      ]),
                    )
                  ],
                ),
              ),
            );
           }
           else{
             return Padding(
               padding: const EdgeInsets.only(top: 18.0),
               child: Center(
                 child: CircularProgressIndicator(),
               ),
             );
           }
          }
        );
                }
                else{
                  return Center(
child: Text("Loading data..."),
                  );
                }
              },
      ),
    );
  }
  
  getUserID() async {
    User user =  FirebaseAuth.instance.currentUser;

    return user.uid;
  }
}

class ColumnModel extends StatelessWidget {
  final int followers;
  final int following;

  ColumnModel(this.followers, this.following);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: MediaQuery.of(context).size.width>=388?const EdgeInsets.only(left: 80, right: 80):const EdgeInsets.only(left: 065, right: 065),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Center(
                    child: Text(
                      "$followers",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "Followers",
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                      child: Center(
                    child: Text(
                      "$following",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
                  Text(
                    "Followings",
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  )
                ],
              )
            ],
          ),
        ),
        Stack(
          children: [
            Padding(
              padding:MediaQuery.of(context).size.width>388? const EdgeInsets.only(left: 90, right: 90):const EdgeInsets.only(left: 75, right: 75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        child: Image.asset(
                          "assets/images/g36.png",
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 15.0, top: 40),
                        child: Text(
                          "Groups",
                          style: TextStyle(fontSize: 10, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        height: 40,
                        width: 40,
                        child: SvgPicture.asset(
                          "assets/icons/Save.ai.svg",
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 15.0, top: 40),
                        child: Text(
                          "Save",
                          style: TextStyle(fontSize: 10, color: Colors.black),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: MediaQuery.of(context).size.width>=388? const EdgeInsets.only(left: 140, right: 140, top: 30):const EdgeInsets.only(left: 125, right: 120, top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/images/g182.png',
                            height: 50,
                            width: 50,
                            color: Colors.black,
                          ),
                          // child: SvgPicture.asset(
                          //   "assets/images/See Cookbook.svg",
                          //   width: 40,
                          //   height: 40,
                          //   color: Colors.black,
                          // ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 0.0, right: 15.0, top: 40),
                          child: Text(
                            "Cookbook",
                            style: TextStyle(fontSize: 10, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                    Container(
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            height: 50,
                            width: 50,
                            child: SvgPicture.asset(
                              "assets/icons/Gym.ai.svg",
                              height: 4,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 13.0, right: 15.0, top: 40),
                            child: Text(
                              "Gym",
                              style: TextStyle(fontSize: 10, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
