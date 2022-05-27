import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'package:sanogano/code/Settings.dart';
import 'package:sanogano/code/SpancerProfile.dart';
import 'package:sanogano/pages/leaderboard.dart';
import 'package:sanogano/pages/activity_page.dart';
import 'package:sanogano/pages/message_page.dart';
import 'package:sanogano/pages/search.dart';
import 'package:sanogano/screens/create_post.dart';
import 'package:sanogano/screens/selectRecipe.dart';

import 'package:sanogano/theme/colors.dart';
import 'package:toast/toast.dart';
import '../screens/list.dart';

import 'cookbook_page.dart';
import 'gym_page.dart';
import 'home_page.dart';
import 'life_page.dart';

class RootApp extends StatefulWidget {
  final String userId;
  RootApp({this.userId});
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  Color c = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      backgroundColor: Colors.white,
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Widget getBody() {
    List<Widget> pages = [
      HomePage(),
      LifePage(),
      CookbookPage(),
      ActivityPage(),
      MyProfile(),
    ];
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getAppBar() {
    if (pageIndex == 0) {
      return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreatePost(
                            userId: widget.userId,
                          )),
                );
              },
              child: SvgPicture.asset(
                "assets/images/CreatePostai.svg",
                width: 25,
                color: Colors.black,
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchScreen()),
                  );
                },
                child: Image.asset(
                  'assets/images/SanoGanoLogo.png',
                  width: 100,
                )),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MessagesPage()),
                );
              },
              child: SvgPicture.asset(
                "assets/images/Messenger.ai.svg",
                width: 25,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    } else if (pageIndex == 1) {
      return AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GymPage()),
                    );
                  },
                  child: new RotatedBox(
                    quarterTurns: 2,
                    child: SvgPicture.asset(
                      'assets/images/Gymai.svg',
                      width: 30,
                      color: Colors.black,
                    ),
                  )),
              Text(
                'Life',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                ),
                // fontWeight: FontWeight.bold),
              ),
              SvgPicture.asset(
                'assets/images/Addai.svg',
                width: 25,
                color: Colors.black,
              )
            ],
          ));
    } else if (pageIndex == 2) {
      return PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListScreen()),
                      );
                    },
                    child: SvgPicture.asset(
                      'assets/images/Listai.svg',
                      width: 25,
                      color: Colors.black,
                    )),
                Text(
                  'Cookbook',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  // fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    Toast.show("I am not implemented yet", context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => SelectRecipeScreen(),
                    //   ),
                    // );
                  },
                  child: SvgPicture.asset(
                    'assets/images/Addai.svg',
                    width: 25,
                    color: Colors.black,
                  ),
                )
              ],
            )),
      );
    } else if (pageIndex == 3) {
      return PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyLeaderboard()),
                    );
                  },
                  child: SvgPicture.asset(
                    'assets/images/Leaderboardai.svg',
                    width: 25,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Activity',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                  // fontWeight: FontWeight.bold),
                ),
                SvgPicture.asset(
                  'assets/images/Trendingai.svg',
                  width: 25,
                  color: Colors.black,
                ),
              ],
            )),
      );
    } else {
      return AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: SvgPicture.asset(
        //     "assets/icons/Back.ai.svg",
        //     height: 25,
        //     color: Colors.black,
        //   ),
        //   onPressed: () {},
        // ),
        title: FutureBuilder(
            future: getUserName(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return Text(
                  snapshot.data,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                );
              } else {
                return Text("Connecting...");
              }
            }),
        actions: [
          IconButton(
              padding: EdgeInsets.only(right: 20),
              icon: SvgPicture.asset(
                "assets/icons/Settings.ai.svg",
                height: 25,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MySettings()));
              })
        ],
      );
    }
  }

  Widget getFooter() {
    List bottomItems = [
      SvgPicture.asset(
        "assets/images/Homeai.svg",
        color: pageIndex == 0 ? Colors.black : Colors.black38,
        width: 27,
      ),
      SvgPicture.asset(
        "assets/images/Lifeai.svg",
        color: pageIndex == 1 ? Colors.black : Colors.black38,
        width: 27,
      ),
      SvgPicture.asset(
        "assets/images/Cookbookai.svg",
        color: pageIndex == 2 ? Colors.black : Colors.black38,
        width: 27,
      ),
      SvgPicture.asset(
        "assets/images/Notificationsai.svg",
        color: pageIndex == 3 ? Colors.black : Colors.black38,
        width: 27,
      ),
      StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(widget.userId)
              .get()
              .asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
                           DocumentSnapshot doc = snapshot.data;

              return Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: pageIndex == 4 ? black : Colors.black38,
                        width: 2.5),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: doc["profileDP"] == "default" ?  AssetImage('assets/default_avatar.png') : NetworkImage(doc["profileDP"]),
                        fit: BoxFit.cover)),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    ];
    return Container(
      width: double.infinity,
      height: 42,
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(bottomItems.length, (index) {
            return Container(
              child: InkWell(
                onTap: () {
                  selectedTab(index);
                },
                child: bottomItems[index],
              ),
            );
          }),
        ),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }

  getUserName() async {
    User user =  FirebaseAuth.instance.currentUser;

    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("Users").doc(user.uid).get();

    return toBeginningOfSentenceCase(doc["name"]);
  }
}
