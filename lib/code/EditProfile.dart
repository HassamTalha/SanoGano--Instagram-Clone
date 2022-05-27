import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanogano/pages/root_app.dart';

class MyEditProfile extends StatefulWidget {
  @override
  _MyEditProfileState createState() => _MyEditProfileState();
}

class _MyEditProfileState extends State<MyEditProfile> {
  String username;

  String name;

  String bio;

  String website;

  User appUser;

  DocumentSnapshot userDoc;
  bool isLoading = false;
  File imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              updateUser();
            },
            child: Text(
              "Done  ",
              style: TextStyle(fontSize: 20, color: Colors.black45),
            ),
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/Back.ai.svg",
            height: 25,
            color: Colors.black,
          ),
          onPressed: () {
            showMessage(context);
          },
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: FutureBuilder(
          future: getUserDoc(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              DocumentSnapshot doc = snapshot.data;
              username = doc["username"];
              name = doc["name"];
              bio = doc["bio"];
              website = doc["url"];
              return SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 4 + 35,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            Container(
                                height:
                                    MediaQuery.of(context).size.height / 8 + 50,
                                width: MediaQuery.of(context).size.width,
                                child: Image.asset(
                                  "assets/images/life1.jpg",
                                  fit: BoxFit.fill,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 18.0),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 120,
                                  width: 120,
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: CircleAvatar(
                                          radius: 70,
                                          backgroundColor: Colors.grey[200],
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(300),
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 2),
                                                image: DecorationImage(
                                                    image: imageFile == null ? doc["profileDP"] ==
                                                            "default"
                                                        ? AssetImage(
                                                            'assets/default_avatar.png')
                                                        : NetworkImage(
                                                            doc["profileDP"]) : FileImage(imageFile),
                                                    fit: BoxFit.cover)),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(300),
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 2),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  if(!isLoading){
                                                    getImage(ImageSource.gallery);
                                                  }
                                                },
                                                child: Center(
                                                  child:isLoading ? CircularProgressIndicator() : Icon(
                                                      Icons.camera_alt_rounded),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      EditProfileModel(doc["username"], (value) {
                        username = value;
                      }),
                      EditProfileModel(doc["name"], (value) {
                        name = value;
                      }),
                      EditProfileModel(doc["bio"], (value) {
                        bio = value;
                      }),
                      EditProfileModel(website == "..." ? "Website" : website,
                          (value) {
                        website = value;
                      }),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 18, right: 8.0, top: 15),
                        child: Row(
                          children: [
                            Text(
                              "Theme",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 35,
                            ),
                            Mycircles(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Future getImage(ImageSource imageSource) async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    pickedFile = await imagePicker.getImage(source: imageSource);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        isLoading = true;
      });
      uploadFile();
    }
  }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot storageTaskSnapshot = await uploadTask;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) async {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(appUser.uid)
          .update({"profileDP": downloadUrl});
      setState(() {
        isLoading = false;
      });
    }, onError: (err) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: 'This file is not an image');
    });
  }

  updateUser() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(appUser.uid)
        .update(
            {"username": username, "name": name, "bio": bio, "url": website});

    Fluttertoast.showToast(msg: "Profile has been updated!");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => RootApp(
                  userId: appUser.uid,
                )),
        (route) => false);
  }

  void showMessage(context) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Discard Changes?"),
            content: Text(
              "If You go back now you will lose your changes",
              style: TextStyle(color: Colors.grey[600]),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text(
                  "Discard Changes",
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: Text(
                  "Keep Editing",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  Future<DocumentSnapshot> getUserDoc() async {
    User user =  FirebaseAuth.instance.currentUser;
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("Users").doc(user.uid).get();
    userDoc = doc;
    appUser = user;
    return doc;
  }
}

class EditProfileModel extends StatelessWidget {
  final String text;
  final Function changeValue;
  EditProfileModel(this.text, this.changeValue);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          onChanged: (value) {
            changeValue(value);
          },
          decoration: InputDecoration(
              hintStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              border: InputBorder.none,
              hintText: text),
        ),
      ),
    );
  }
}

class Mycircles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.black,
              ),
              SizedBox(
                width: 18,
              ),
              CircleAvatar(
                radius: 12,
                backgroundColor: Color(0xfff007596),
              ),
              SizedBox(
                width: 18,
              ),
              CircleAvatar(
                radius: 12,
                backgroundColor: Color(0xfff42528D),
              ),
              SizedBox(
                width: 18,
              ),
              CircleAvatar(
                radius: 12,
                backgroundColor: Color(0xFFF943E3D),
              ),
              SizedBox(
                width: 18,
              ),
              CircleAvatar(
                radius: 12,
                backgroundColor: Color(0xFFFAC6434),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
