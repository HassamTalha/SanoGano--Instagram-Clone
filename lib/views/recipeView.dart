import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sanogano/screens/create_post.dart';
import 'package:toast/toast.dart';
import '../models/reipeDetails.dart';

class RecipeView extends StatefulWidget {
  final RecipeDetails recipeDetails;
  const RecipeView({this.recipeDetails});

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  RecipeDetails recipeDeatils;
  bool insValidate = false;
  bool ingreValidte = false;
  bool descriptionValidate = false;
  bool servingsValidate = false;
  bool timeValidate = false;
  bool nameValidate = false;
  TextEditingController _recipeNameController,
      _timeController,
      _servingsController,
      _descriptionController,
      _ingredientsController,
      _instructionsController;
  bool check = false;
  DateTime _chosenDateTime;
  String time;
  Widget changeState() {
    return Container();
  }

  @override
  void initState() {
    super.initState();
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
                widget.recipeDetails.recipeName,
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            child: Row(
                          children: [
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: SvgPicture.asset(
                                'assets/images/Time.ai.svg',
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 10),
                            Center(
                              child: Container(
                                width: 135,
                                height: 25,
                                child: Text(
                                  widget.recipeDetails.time == "1"
                                      ? widget.recipeDetails.time + " Minute"
                                      : widget.recipeDetails.time + " Minutes",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ),
                          ],
                        )),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: SvgPicture.asset(
                                'assets/images/Servings.ai.svg',
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 130,
                              height: 25,
                              child: Text(
                                widget.recipeDetails.servings == "1"
                                    ? widget.recipeDetails.servings + " Serving"
                                    : widget.recipeDetails.servings +
                                        " Servings",
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          ],
                        )
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
                      width: 164,
                      height: 164,
                    )
                  ],
                ),
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  widget.recipeDetails.description,
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20),
                Text(
                  'Ingredients',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  widget.recipeDetails.ingridients,
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20),
                Text(
                  'Instructions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  widget.recipeDetails.instructions,
                  style: TextStyle(fontSize: 18.0),
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
