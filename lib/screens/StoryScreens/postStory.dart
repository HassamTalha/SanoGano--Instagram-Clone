
import 'dart:io';

import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanogano/Animations/FadeAnimation.dart';
import 'package:sanogano/apis/StorageServices.dart';
import 'package:sanogano/constants.dart';
import 'package:sanogano/models/StoryModel.dart';
import 'package:sanogano/screens/StoryScreens/ColorPicker.dart';
import 'package:toast/toast.dart';

class PostStory extends StatefulWidget {
  File pickedImage;
  final userData;
  PostStory(this.pickedImage, this.userData);
  @override
  _PostStoryState createState() => _PostStoryState();
}

class _PostStoryState extends State<PostStory> {
  final TextEditingController captionController = TextEditingController();
  bool uploading = false;
  bool achievement = false;
  bool captionOn = false;
  bool colorPalate = false;
  
  StorageServices ss = StorageServices();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.pickedImage == null ){
      setState(() {
        captionOn = true;
      });
    }
  }
  int selectedIndex = 0;
  Color selectedColor = Colors.white;
  changeColor(color, index){
    setState(() {
      selectedIndex = index;
    selectedColor = color;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: uploading
          ? Container(
            color: Colors.white,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   
                   Text("Sharing your story...", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                   SizedBox(height: 15),
                   Image.asset("assets/splash.gif"),
               
                ],
              ),
            )
          : achievement ? Container(): Container(
              color: selectedColor,
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Center(
                      child: widget.pickedImage != null
                          ? Image.file(widget.pickedImage)
                          : Container()),
                  Visibility(
                    visible: captionOn, 
                                      child: Center(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 22.0,right: 22.0, bottom: 70, top: 120),
                          child: TextField(
                            textAlign: TextAlign.center,
                            textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(
                                fontSize: 25,
                                color:selectedColor == Colors.white ? Colors.black :   Colors.white,
                                fontWeight: FontWeight.w600),
                            maxLines: null,
                            controller: captionController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: selectedColor == Colors.white ? Colors.black :    Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic),
                              hintText: "Caption",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                 Positioned(
                   top: 100,
                                    child: Visibility(
                                      visible: colorPalate,
                                                                          child: FadeAnimationDown( 1,
                                                                             Container(
                                        width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 16),
                      height: 30,
                      child: ColorPicker(changedColor: changeColor),),
                                                                          ),
                                    ),
                 ),
                  Visibility(
                    visible: 
                    widget.pickedImage == null,
                                      child: Positioned(
                      top: 40, right: 15,
                      child: CircleAvatar(
                        backgroundColor: mainColor,
                                            child: IconButton(icon: Icon(Icons.color_lens, color: colorPalate ? Colors.red : Colors.white,) ,onPressed: (){
                          setState(() {
                            colorPalate = !colorPalate;
                          });
                        },),
                      ),),
                  ),
                  Visibility(
                    visible: widget.pickedImage !=null,
                                      child: Positioned(
                      top: 40, right: 15,
                      child: CircleAvatar(
                        backgroundColor: mainColor,
                                            child: IconButton(icon: Icon(Icons.text_fields, color: captionOn ? Colors.red : Colors.white,) ,onPressed: (){
                          setState(() {
                            captionOn = !captionOn;
                          });
                        },),
                      ),),
                  ),
                  Positioned(
                    top: 40,
                    left: 15,
                    child: InkWell(
                      onTap: () {
                        if(widget.pickedImage != null){
                        setState(() {
                        widget.pickedImage = null;
                        captionOn = true;
                          
                        });
                        }
                        else{
Navigator.pop(context);
                      
                        }
                        },
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                        shape: CircleBorder(),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 15,
                      left: 16,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(widget.userData[1]),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Your Story",
                            style: TextStyle(
                                color: selectedColor == Colors.white ? Colors.black :  Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      )),
                      Positioned( bottom: 15,
                      left: 96,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: (){
                              pickImage();
                            },
                                                      child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.image, color : Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Gallery",
                            style: TextStyle(
                                color: selectedColor == Colors.white ? Colors.black :  Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      )),
                  Positioned(
                    bottom: 15,
                    right: 16,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.white,
                      onPressed: () {
                        postStory(context);
                      },
                      child: Row(
                        children: [
                          Text(
                            "Post",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 24,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
  pickImage() async{
    ImagePicker picker = ImagePicker();
     final pickedFile = await picker.getImage(
                    source: ImageSource.gallery, imageQuality: 80);

                if (pickedFile != null) {
                  setState(() {
                  widget.pickedImage = File(pickedFile.path);
                  selectedColor = Colors.black;
                  colorPalate = false;
                  });
                  } else {
                  print('No image selected.');
                }
  }

  postStory(context) async {
    setState(() {
      uploading = true;
    });

    String result;
    if (widget.pickedImage != null) {
      result = await ss.uploadStoryImage(widget.pickedImage.path);
    }
    var timestamp = Timestamp.now();
    var po = DateTime.now().millisecondsSinceEpoch;
    StoryModel tm = StoryModel(
        aspectRatio: 0,
        duration: "5.0",
        date: timestamp,
        desc: captionController.text == null ? "" : captionController.text,
        media: result,
        postOrder: po,
        userImage: widget.userData[1],
        userName: "${widget.userData[0][1]} ${widget.userData[0][2]}",
        type: widget.pickedImage == null ? "$selectedIndex.Text" : "Image");
    await FirebaseFirestore.instance
        .collection("Stories")
        .doc(widget.userData[0][0])
        .set({
      "media": result == null ? "$selectedIndex text.#_-_#.${captionController.text.length > 25 ? captionController.text.substring(0, 24) : captionController.text}" : 'image.#_-_#.$result',
      "userImage" :widget.userData[1],
      "timestamp": po,
      'userName': '${widget.userData[0][1]} ${widget.userData[0][2]}',
      'userID' : widget.userData[0][0],
    }).catchError((onError) {
      Toast.show(onError.toString(), context);
    });
    await FirebaseFirestore.instance
        .collection("Stories")
        .doc(widget.userData[0][0])
        .collection("MyStories")
        .add(tm.toJson())
        .catchError((onError) {
      Toast.show(onError.toString(), context);
    }).whenComplete(() {
     
     
    });
             setState(() {
      uploading = false;
      achievement = true;
    });

     showAchievementView(context);
  }

  void showAchievementView(BuildContext context) {
    AchievementView(context,
        title: "Yeaaah!",
        subTitle: "Story Shared successfully",
        //onTab: _onTabAchievement,
        icon: Icon(
          Icons.insert_emoticon,
          color: Colors.white,
        ),
        typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
        //borderRadius: 5.0,
        color: Colors.blueGrey,
        //textStyleTitle: TextStyle(),
        //textStyleSubTitle: TextStyle(),
        alignment: Alignment.center,
        duration: Duration(seconds: 2),
        isCircle: true, listener: (status) {
      print(status);
      if (status == AchievementState.closed) {
       Navigator.pop(context);
      }
      //AchievementState.opening
      //AchievementState.open
      //AchievementState.closing
      //AchievementState.closed
    })
      ..show();
  }
}
