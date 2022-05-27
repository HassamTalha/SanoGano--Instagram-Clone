
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanogano/screens/StoryScreens/postStory.dart';

class StoriesUploadButton extends StatelessWidget {
  final bool dpLoaded;
  final List<dynamic> userData;
  StoriesUploadButton(this.userData, this.dpLoaded);

  File pickedImage;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      height: MediaQuery.of(context).size.width * 0.2,
      width: MediaQuery.of(context).size.width * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(300),
        image: DecorationImage(
            image:
                dpLoaded ? NetworkImage(userData[1]) : AssetImage("assets/default_avatar.png"),
            fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(300),
              gradient: LinearGradient(
                
                colors: [
                Colors.grey.withOpacity(0.5),
                Colors.black.withOpacity(0.5)
              ]),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.only(left: 3.0, bottom: 3.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: InkWell(
              onTap: () async {
                // if (!dpLoaded) {
                //   return;
                // }
                // final pickedFile = await picker.getImage(
                //     source: ImageSource.gallery, imageQuality: 80);

                // if (pickedFile != null) {
                //   pickedImage = File(pickedFile.path);
                // } else {
                //   print('No image selected.');
                // }
              Navigator.push(context, MaterialPageRoute(builder: (context)=> PostStory(pickedImage, userData)));
              },
              child: Image.asset("assets/storiesUpload.png", height: 32,)),
              // Card(
              //   shape: CircleBorder(),
              //   color: Colors.red,
              //   child: Padding(
              //     padding: const EdgeInsets.all(4.0),
              //     child: CircleAvatar(
              //       radius: 15,
              //       backgroundImage: dpLoaded
              //           ? NetworkImage(userData[1])
              //           : AssetImage("assets/user.png"),
              //     ),
              //   ),
              // ),
            ),
          )
        ],
      ),
    );
  }



}
