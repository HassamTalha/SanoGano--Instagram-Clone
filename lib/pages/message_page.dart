import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sanogano/Login/LoginScreen.dart';

import 'package:sanogano/constant/message_json.dart';
import 'package:sanogano/pages/Chat/ChatRoomModel.dart';
import 'package:sanogano/pages/newMessage_page.dart';
import 'package:sanogano/pages/Chat/ChatTile.dart';

class MessagesPage extends StatefulWidget {
  MessagesPage({Key key}) : super(key: key);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  Future<User> getLoggedInUser() async {
    
    User user = FirebaseAuth.instance.currentUser;
    return Future.value(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
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
            //           FirebaseAuth au = FirebaseAuth.instance;
            // au.signOut();
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => LoginScreen(),
            //   ),
            // );
                      Navigator.pop(context);
                    },
                    child: new RotatedBox(
                      quarterTurns: 2,
                      child: SvgPicture.asset(
                        'assets/images/Forwardai.svg',
                        width: 25,
                        color: Colors.black,
                      ),
                    )),
                Text(
                  'Messages',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  // fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewMessagePage()),
                    );
                  },
                  child: SvgPicture.asset(
                    'assets/images/NewMessageai.svg',
                    width: 25,
                    color: Colors.black,
                  ),
                )
              ],
            )),
      ),
      body: FutureBuilder(
          future: getLoggedInUser(),
          builder: (context, AsyncSnapshot<User> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              print("User data got");
              String userID = snapshot.data.uid;
              print(userID);
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 05, bottom: 15),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Container(
                            height: 40,
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.top,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                  hintStyle: TextStyle(
                                    height: 2.8,
                                  ),
                                  border: new OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: BorderSide(
                                      width: 2,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[200]),
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[200]),
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  errorBorder: InputBorder.none,
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 15),
                                  hintText: "Search"),
                            )),
                        Expanded(
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("Users")
                                .doc(userID)
                                .collection("Chats")
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> sSnapshot) {
                              if (sSnapshot.hasData && sSnapshot.data.docs.isNotEmpty) {
                                print("Chats found");
                                print(sSnapshot.data.docs);
                                return StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                .collection("Chats")
                               
                                .snapshots(),
                                  builder: (context, AsyncSnapshot<QuerySnapshot> snap){
                                  if(snap.hasData && snap.data.docs.isNotEmpty){
                                    List<DocumentSnapshot> allChats = snap.data.docs;
                                    return ListView(
                                  children:
                                      sSnapshot.data.docs.map(( DocumentSnapshot myChat) {
                                        for(DocumentSnapshot d in allChats){
                                          if(myChat["id"] == d.id){
                                            ChatRoom chatRoom = ChatRoom.fromMap(d.data());
                                    return ChatTile(chatRoom, userID);
                                          }
                                        }
                                        
                                  }).toList(),
                                );
                                  }
                                  else{
                                    return Center(child: CircularProgressIndicator(),);
                                  }
                                });
                              } else {
                                if (ConnectionState.done ==
                                    snapshot.connectionState) {
                                  return Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                         children: [
                                           Image.asset("assets/chatAnim.gif", height: 80,),
                                           Text(
                                          "No conversations found, Start a new one!", style: TextStyle(color: Colors.black),),
                                    
                                         ],),
                                  );
                                } else {
                                  print("Searching for chats");
                                    
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              print("Searching for user data");
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
