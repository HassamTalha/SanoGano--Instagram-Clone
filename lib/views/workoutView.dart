import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import '../models/workoutDetails.dart';

class WorkoutView extends StatefulWidget {
  final WorkoutDetails workoutDetails;
  const WorkoutView({this.workoutDetails});

  @override
  _WorkoutViewState createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView> {
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
                widget.workoutDetails.workoutName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                ),
                // fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.more_horiz,
                  color: Colors.black,
                  size: 35,
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
                      style: TextStyle(fontSize: 16.0),
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
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.42,
                              child: Text(
                                widget.workoutDetails.notes,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
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
                                image: AssetImage('assets/images/appbar.png')),
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
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.workoutDetails.exercises,
                  style: TextStyle(
                    fontSize: 16,
                  ),
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
