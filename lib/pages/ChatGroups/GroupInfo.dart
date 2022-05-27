import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanogano/constants.dart';
import 'package:sanogano/pages/root_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class GroupInfo extends StatefulWidget {
  final List<DocumentSnapshot> _friendsSelected;
  GroupInfo(this._friendsSelected);
  @override
  _GroupInfoState createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  TextEditingController _groupName = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  var imageFile;
  String id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readLocal();
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: Visibility(
        visible: showFab,
        child: RoundedLoadingButton(
          color: Color(0xFF2E3546),
          child: Text('Create Group', style: TextStyle(color: Colors.white)),
          controller: _btnController,
          onPressed: createRoom,
        ),
      ),

      // RaisedButton(
      //   padding: EdgeInsets.symmetric(
      //       horizontal: MediaQuery.of(context).size.width / 2 - 70,
      //       vertical: 18),
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      //   onPressed: () {},
      //   color: Color(0xFF2E3546),
      //   child: Text(
      //     "Create Group",
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Color(0xFFEFE6DF),
      appBar: AppBar(
        title: Text("Group Info"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width / 3 + 5,
                        width: MediaQuery.of(context).size.width / 3 + 5,
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(6),
                              height: MediaQuery.of(context).size.width / 3,
                              width: MediaQuery.of(context).size.width / 3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(300),
                                  border: Border.all(
                                      color: Color(0xFFD0CCC8), width: 2)),
                              child: CircleAvatar(
                                backgroundColor: Color(0xFFD0CCC8),
                                backgroundImage: imageFile == null
                                    ? null
                                    : FileImage(imageFile),
                              ),
                            ),
                            Positioned(
                              right: 15,
                              bottom: 15,
                              child: GestureDetector(
                                onTap: () {
                                  getImage();
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 15,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Color(0xFFD0CCC8),
                                    size: 16,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: TextField(
                          controller: _groupName,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: "Group Name",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 30, bottom: 160),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Group participants",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 25),
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 20,
                                child: Wrap(
                                  children: widget._friendsSelected.map((e) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0, right: 16),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 80,
                                            width: 80,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(3),
                                                  height: 70,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              300),
                                                      border: Border.all(
                                                          color:
                                                              Color(0xFFD0CCC8),
                                                          width: 2)),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Color(0xFFD0CCC8),
                                                    backgroundImage: e["dp"]== "default"
                                                      ? AssetImage(
                                                          "assets/default_avatar.png")
                                                      : NetworkImage(
                                                            e["dp"]),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 10,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        widget._friendsSelected
                                                            .remove(e);
                                                      });
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.grey[200],
                                                      radius: 12,
                                                      child: Icon(
                                                        Icons.cancel,
                                                        color: Colors.black,
                                                        size: 14,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          // Container(
                                          //   child: CircleAvatar(
                                          //     radius: 30,
                                          //     backgroundImage:
                                          //         NetworkImage(friendDps[e]),
                                          //   ),
                                          // ),
                                          SizedBox(
                                            height: 0,
                                          ),
                                          Text(e["friendName"])
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  readLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('UUID') ?? '';
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  Future createRoom() async {
    print("1");
    if (_groupName.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please specify a group name!",
      );

      _btnController.reset();
      return;
    }
    print("2");
    var result;
    if (imageFile != null) {
      result = await uploadGroupDp();
      print("3");
      if (result == '') {
        _btnController.reset();
        return;
      }
    }

    print("4");
    List<int> peerIDs = [];
    for(DocumentSnapshot doc in widget._friendsSelected){

      peerIDs.add(doc["friendUUID"]);


    }
    print("5");
    String chatroomID = uniqueID();
    print("6");
    await FirebaseFirestore.instance
        // .collection("users")
        // .document(id)
        .collection("Chats")
        .doc(chatroomID)
        .set({
          "chatCreator" : "111",
                "chatDP": imageFile != null ? result : "default",
      "chatName": _groupName.text,
        "creatorDP" : "123",
      "isRead": false,
      "isRoom": true,
      "lastMessage": "",
      "peerUUID": peerIDs.toString(),
      "roomID": chatroomID,
      "timeStamp": Timestamp.now()
    });
    print("7");
    User user =  FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .collection("Chats")
          .doc(chatroomID)
          .set({
        "id": chatroomID,
      });
    for (var peer in widget._friendsSelected) {
      //TODO: change peer IDS accordingly
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(peer.toString())
          .collection("Chats")
          .doc(chatroomID)
          .set({
        "id": chatroomID,
      });
      print("8$peer");
    }
    _btnController.success();
    print("9");
    // ChatRoom chatRoom = ChatRoom(
    //     isRead: false,
    //     isRoom: true,
    //     lastMessage: "lastmessage",
    //     peerUUID: peerIDs.toString(),
    //     chatDP: imageFile != null ? imageFile.toString() : "default",
    //     roomID: chatroomID,
    //     chatName: _groupName.text,
    //     timeStamp: Timestamp.now());
    Timer(Duration(microseconds: 500), () async {
      
      print("10");
      Navigator.pop(context);
      print("11");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => RootApp(userId: user.uid)),
          (route) => false);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _groupName.dispose();
  }

  Future<String> uploadGroupDp() async {
    var imageUrl = "";
    
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference =
        FirebaseStorage.instance.ref().child("GroupDPs").child(fileName);
    UploadTask uploadTask = reference.putFile(imageFile);
   TaskSnapshot storageTaskSnapshot = await uploadTask;
      imageUrl = await storageTaskSnapshot.ref.getDownloadURL();
    } catch (error) {
      debugPrint(error);
      Fluttertoast.showToast(
          msg: 'Something went wrong!\nPlease try again later.');
    }

    return imageUrl;
  }
}
