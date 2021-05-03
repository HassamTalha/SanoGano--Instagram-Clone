import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'TabBar2/All.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: SingleChildScrollView(
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
                                  image: AssetImage('assets/images/Img.jpg'),
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
                                            image: AssetImage(
                                              'assets/images/ibrahim.jpg',
                                            ),
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
                        child: ColumnModel(),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Spancer",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Dont walk infront of me..i may not follow",
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "www.google.com",
                style: TextStyle(color: Colors.blue),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "ESTEBLISHED DECEMBER,2020",
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
      ),
    );
  }
}

class ColumnModel extends StatelessWidget {
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
                      "100",
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
                      "20",
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
