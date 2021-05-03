import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sanogano/screens/create_post.dart';
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
  Widget changeState() {
    return Container();
  }

  @override
  void initState() {
    super.initState();
    setControllers();
  }

  void setControllers() {
    _workoutNameController = TextEditingController();
    _exerciseController = TextEditingController();
    _notesController = TextEditingController();
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
                onTap: () {
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

  bool validateRecipe(String userInput) {
    if (userInput.isEmpty) {
      setState(() {
        nameValidate = true;
      });
      return false;
    }
    setState(() {
      nameValidate = false;
    });
    return true;
  }

  bool validateTime(String userInput) {
    if (userInput.isEmpty) {
      setState(() {
        timeValidate = true;
      });
      return false;
    }
    setState(() {
      timeValidate = false;
    });
    return true;
  }

  bool validateServings(String userInput) {
    if (userInput.isEmpty) {
      setState(() {
        servingsValidate = true;
      });
      return false;
    }
    setState(() {
      servingsValidate = false;
    });
    return true;
  }

  bool validateDescription(String userInput) {
    if (userInput.isEmpty) {
      setState(() {
        descriptionValidate = true;
      });
      return false;
    }
    setState(() {
      descriptionValidate = false;
    });
    return true;
  }

  bool validateIngridients(String userInput) {
    if (userInput.isEmpty) {
      setState(() {
        ingreValidte = true;
      });
      return false;
    }
    setState(() {
      ingreValidte = false;
    });
    return true;
  }

  bool validateInstructions(String userInput) {
    if (userInput.isEmpty) {
      setState(() {
        insValidate = true;
      });
      return false;
    }
    setState(() {
      insValidate = false;
    });
    return true;
  }
}
