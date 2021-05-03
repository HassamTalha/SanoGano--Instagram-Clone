import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyEditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
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
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4 + 35,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height / 8 + 50,
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
                                    borderRadius: BorderRadius.circular(300),
                                    border: Border.all(
                                        color: Colors.black, width: 2),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          "https://media.istockphoto.com/photos/macho-man-picture-id1202142519?k=6&m=1202142519&s=612x612&w=0&h=7aTJXgG-0REO-DurbvMr1X6JcrDeGi784Vdkr-esjEA=",
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
              ],
            ),
          ),
          EditProfileModel("Username"),
          EditProfileModel("Name"),
          EditProfileModel("Bio"),
          EditProfileModel("Website"),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 8.0, top: 15),
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
    );
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
}

class EditProfileModel extends StatelessWidget {
  final String text;
  EditProfileModel(this.text);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        text,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
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
