import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'GroupInfo.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<int> _friendsSelected = [];
  List<DocumentSnapshot> docs =[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _friendsSelected.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                List<DocumentSnapshot> friends = [];
                for (int i in _friendsSelected){
                  friends.add(docs[i]);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroupInfo(friends),
                  ),
                );
              },
              backgroundColor: Color(0xFF2E3546),
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              label: Text(
                "Done",
                style: TextStyle(color: Colors.white),
              ),
            ),
      appBar: AppBar(
        title: Text("New Group"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.grey)]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Add people...", border: InputBorder.none),
              ),
            ),
          ),
          Container(
            height: _friendsSelected.isEmpty ? 0 : 40,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: _friendsSelected.length,
                itemBuilder: (context, index) {
                  return MyChip(index: _friendsSelected[index], 
                  name: docs[_friendsSelected[index]]["friendName"],
                  image: docs[_friendsSelected[index]]["dp"],

                  removeFriendCallback:
                  () {
                    setState(() {
                      _friendsSelected.removeAt(index);
                    });
                  }, );
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Users")
                        .doc(FirebaseAuth.instance.currentUser.uid)
                        .collection("Followers")
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
                      if (snap.hasData && snap.data.docs.isNotEmpty) {
                        docs = snap.data.docs;
                        return Column(
                          children: List.generate(docs.length, (index) {
                             bool selected = false;
                for (var i in _friendsSelected) {
                  if (index == i) {
                    selected = true;
                  }
                }
                            return Column(
                              children: [
                                SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    addChip(index);
                                   
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 55,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                           
                                            child: Container(
                                              width: 45,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                  
                                                  shape: BoxShape.circle,
                                                  ),

                                                  child: Stack(children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: docs[index]["dp"] ==
                                                            "default"
                                                        ? AssetImage(
                                                            "assets/default_avatar.png")
                                                        : NetworkImage(
                                                            docs[index]["dp"]),
                      ),
                      Visibility(
                        visible: selected,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 7,
                              child: Icon(Icons.check,
                                  color: Colors.white, size: 12)),
                        ),
                      )
                    ]),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              docs[index]['friendName'],
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                            
                                          ],
                                        ),
                                      ),
                                      
                                    ],
                                  ),
                                ),
                                SizedBox(height: 05),
                              ],
                            );
                          }),
                        );
                      } else {
                        if (snap.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Container();
                        }
                      }
                    })),
          )
        ],
      ),
    );
  }

  addChip(index) {
    for (var i in _friendsSelected) {
      if (index == i) {
        setState(() {
          _friendsSelected.remove(i);
        });
        return;
      }
    }
    setState(() {
      _friendsSelected.add(index);
    });
    print(_friendsSelected);
  }
}

class MyChip extends StatelessWidget {
  final int index;
  final String image;
  final String name;
  final VoidCallback removeFriendCallback;
  MyChip({this.index, this.removeFriendCallback, this.image, this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(300),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: Colors.grey[200],
            backgroundImage:image==
                                                          "default"
                                                      ? AssetImage(
                                                          "assets/default_avatar.png")
                                                      : NetworkImage(
                                                          image),
          ),
          SizedBox(width: 8),
          Text(name),
          SizedBox(width: 8),
          InkWell(
              onTap: removeFriendCallback,
              child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.white,
                  ))),
        ],
      ),
    );
  }
}
