import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sanogano/screens/create_post.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../models/workoutDetails.dart';

class CreateWorkoutPostPage extends StatefulWidget {
  final File image;
  final bool check;
  const CreateWorkoutPostPage({this.image, this.check});

  @override
  _CreateWorkoutPostPageState createState() => _CreateWorkoutPostPageState();
}

class _CreateWorkoutPostPageState extends State<CreateWorkoutPostPage> {
  bool insValidate = false;
  bool ingreValidte = false;
  bool descriptionValidate = false;
  bool servingsValidate = false;
  bool timeValidate = false;
  bool nameValidate = false;
  TextEditingController _workoutNameController,
      _exerciseController,
      _notesController;
  bool check = false;
  DateTime _chosenDateTime;
  String time;
  String userId;

  Widget changeState() {
    return Container();
  }

  @override
  void initState() {
    print(
        "===================================================================================");

    getUserIdfromSF().then(
      (value) {
        setState(
          () {
            userId = value;
            print(
                "================================$userId=======================================");
          },
        );
      },
    );
    super.initState();
    setControllers();
  }

  void setControllers() {
    _workoutNameController = TextEditingController();
    _exerciseController = TextEditingController();
    _notesController = TextEditingController();
  }

  Future<String> getUserIdfromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String userID = prefs.getString("userId") ?? "i have nothing to show";

    return userID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45.0),
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
                'Create Workout',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
                // fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () async {
                  if (_workoutNameController.text.isEmpty ||
                      _exerciseController.text.isEmpty ||
                      _notesController.text.isEmpty) {
                    Toast.show("Please provide the required detail", context);
                  }
                  // else if (_recipeNameController.text.isEmpty ||
                  //     _timeController.text.isEmpty ||
                  //     _servingsController.text.isEmpty ||
                  //     _descriptionController.text.isEmpty ||
                  //     _ingredientsController.text.isEmpty ||
                  //     _instructionsController.text.isEmpty) {
                  //   validateRecipe(_recipeNameController.text);
                  //   validateTime(_timeController.text);
                  //   validateServings(_recipeNameController.text);
                  //   validateDescription(_descriptionController.text);
                  //   validateIngridients(_ingredientsController.text);
                  //   validateInstructions(_instructionsController.text);
                  // }
                  else if (_workoutNameController.text.isNotEmpty &&
                      _exerciseController.text.isNotEmpty &&
                      _notesController.text.isNotEmpty) {
                    final workout = WorkoutDetails(
                      workoutName: _workoutNameController.text,
                      exercises: _exerciseController.text,
                      notes: _notesController.text,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreatePost(
                                workoutDetails: workout,
                                pageIndex: 3,
                              )),
                    );
                    Toast.show(userId, context);
                    if (widget.image!=null){
                      final String rand = '${new Random().nextInt(10000)}';
                    final imageName = 'image$rand';
                    print(
                        'object-----------------------------------------------');

                    print(widget.image.path);
                    String fileName = (widget.image.path);
                    Reference firebaseStorageRef =
                        FirebaseStorage.instance.ref().child(imageName);
                    UploadTask uploadTask =
                        firebaseStorageRef.putFile(widget.image);
                    TaskSnapshot taskSnapshot =
                        await uploadTask;
                    taskSnapshot.ref.getDownloadURL().then((value) {
                      print("Done: $value");
                      FirebaseFirestore.instance
                          .collection("users/$userId/workout")
                          .doc()
                          .set({
                        "imageUrl": value,
                        "workoutName": _workoutNameController.text,
                        "workoutNotes": _notesController.text,
                        "workoutExercise": _exerciseController.text,
                      });
                    });
                    }
                    else{
                      FirebaseFirestore.instance
                          .collection("users/$userId/workout")
                          .doc()
                          .set({
                        "DownloadUrl": "",
                        "workoutName": _workoutNameController.text.toString(),
                        "workoutNotes": _notesController.text.toString(),
                        "workoutExercise": _exerciseController.text.toString(),
                      });
                    }
                  }
                },
                child: Text(
                  'Next',
                  style: TextStyle(
                      color: check == true ? Colors.black : Colors.black45),
                ),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
        ),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: 180,
                    child: TextField(
                      onSubmitted: (value) {
                        if (_workoutNameController.text.isNotEmpty &&
                            _exerciseController.text.isNotEmpty &&
                            _notesController.text.isNotEmpty) {
                          setState(() {
                            check = true;
                          });
                        } else {
                          setState(() {
                            check = false;
                          });
                        }
                      },
                      controller: _workoutNameController,
                      style: TextStyle(fontSize: 22.0),
                      maxLines: 3,
                      minLines: 1,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(50),
                      ],
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                          hintStyle: TextStyle(fontSize: 20.0),
                          // contentPadding: EdgeInsets.only(bottom: 10),
                          border: InputBorder.none,
                          errorText: nameValidate
                              ? "Please provide the recipe name"
                              : null,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: '  Workout Name'),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/images/ibrahim.jpg'),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Text(
                      'nTenseSpence',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
                SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Notes',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.42,
                              child: TextField(
                                onSubmitted: (value) {
                                  if (_workoutNameController.text.isNotEmpty &&
                                      _exerciseController.text.isNotEmpty &&
                                      _notesController.text.isNotEmpty) {
                                    setState(() {
                                      check = true;
                                    });
                                  }
                                },
                                controller: _notesController,
                                maxLines: 7,
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                    // contentPadding: EdgeInsets.only(bottom: 10),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    errorText: descriptionValidate
                                        ? "Please provide the required notes"
                                        : null,
                                    disabledBorder: InputBorder.none,
                                    hintText: 'Add Notes'),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: widget.check != true
                                    ? FileImage(
                                        widget.image,
                                      )
                                    : AssetImage('assets/images/appbar.png')),
                          ),
                          width: 174,
                          height: 174,
                        ),
                      ],
                    )
                  ],
                ),
                Text(
                  'Exercises',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  onSubmitted: (value) {
                    if (_workoutNameController.text.isNotEmpty &&
                        _exerciseController.text.isNotEmpty &&
                        _notesController.text.isNotEmpty) {
                      setState(() {
                        check = true;
                      });
                    }
                  },
                  controller: _exerciseController,
                  maxLines: 7,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(

                      // contentPadding: EdgeInsets.only(bottom: 10),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      errorText: ingreValidte
                          ? "Please provide the required excercises"
                          : null,
                      disabledBorder: InputBorder.none,
                      hintText: 'Add Exercises'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // bool validateRecipe(String userInput) {
  //   if (userInput.isEmpty) {
  //     setState(() {
  //       nameValidate = true;
  //     });
  //     return false;
  //   }
  //   setState(() {
  //     nameValidate = false;
  //   });
  //   return true;
  // }

}
