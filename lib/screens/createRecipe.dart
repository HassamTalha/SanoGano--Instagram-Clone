import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sanogano/screens/create_post.dart';
import 'package:toast/toast.dart';
import '../models/reipeDetails.dart';

class CreateRecipePostPage extends StatefulWidget {
  final File image;
  final bool check;
  const CreateRecipePostPage({this.image, this.check});

  @override
  _CreateRecipePostPageState createState() => _CreateRecipePostPageState();
}

class _CreateRecipePostPageState extends State<CreateRecipePostPage> {
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
    setControllers();
  }

  void setControllers() {
    _recipeNameController = TextEditingController();
    _timeController = TextEditingController();
    _servingsController = TextEditingController();
    _descriptionController = TextEditingController();
    _ingredientsController = TextEditingController();
    _instructionsController = TextEditingController();
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
                'Create Recipe',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
                // fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  if (_recipeNameController.text.isEmpty ||
                      _timeController.text.isEmpty ||
                      _servingsController.text.isEmpty ||
                      _descriptionController.text.isEmpty ||
                      _ingredientsController.text.isEmpty ||
                      _instructionsController.text.isEmpty) {
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
                  else if (_recipeNameController.text.isNotEmpty &&
                      _timeController.text.isNotEmpty &&
                      _servingsController.text.isNotEmpty &&
                      _descriptionController.text.isNotEmpty &&
                      _ingredientsController.text.isNotEmpty &&
                      _instructionsController.text.isNotEmpty) {
                    final recipe = RecipeDetails(
                      recipeName: _recipeNameController.text,
                      time: _timeController.text,
                      servings: _servingsController.text,
                      description: _descriptionController.text,
                      ingridients: _ingredientsController.text,
                      instructions: _instructionsController.text,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreatePost(
                                recipeDetails: recipe,
                                pageIndex: 2,
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
                        if (_recipeNameController.text.isNotEmpty &&
                            _timeController.text.isNotEmpty &&
                            _servingsController.text.isNotEmpty &&
                            _descriptionController.text.isNotEmpty &&
                            _ingredientsController.text.isNotEmpty &&
                            _instructionsController.text.isNotEmpty) {
                          setState(() {
                            check = true;
                          });
                        } else {
                          setState(() {
                            check = false;
                          });
                        }
                      },
                      controller: _recipeNameController,
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
                          hintText: '  Recipe Name'),
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
                            Container(
                              width: 135,
                              height: 35,
                              child: TextField(
                                onSubmitted: (value) {
                                  if (_recipeNameController.text.isNotEmpty &&
                                      _timeController.text.isNotEmpty &&
                                      _servingsController.text.isNotEmpty &&
                                      _descriptionController.text.isNotEmpty &&
                                      _ingredientsController.text.isNotEmpty &&
                                      _instructionsController.text.isNotEmpty) {
                                    setState(() {
                                      check = true;
                                    });
                                  }
                                },
                                controller: _timeController,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(3),
                                ],
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                    // contentPadding: EdgeInsets.only(bottom: 10),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    errorText: timeValidate
                                        ? "Please provide time in minutes"
                                        : null,
                                    hintText: 'Time in minutes'),
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
                              height: 35,
                              child: TextField(
                                onSubmitted: (value) {
                                  if (_recipeNameController.text.isNotEmpty &&
                                      _timeController.text.isNotEmpty &&
                                      _servingsController.text.isNotEmpty &&
                                      _descriptionController.text.isNotEmpty &&
                                      _ingredientsController.text.isNotEmpty &&
                                      _instructionsController.text.isNotEmpty) {
                                    setState(() {
                                      check = true;
                                    });
                                  }
                                },
                                controller: _servingsController,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(3),
                                ],
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                    // contentPadding: EdgeInsets.only(bottom: 10),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    errorText: servingsValidate
                                        ? "Provide no of servings"
                                        : null,
                                    hintText: 'No of Servings'),
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
                            image: widget.check != true
                                ? FileImage(
                                    widget.image,
                                  )
                                : AssetImage('assets/images/appbar.png')),
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
                TextField(
                  onSubmitted: (value) {
                    if (_recipeNameController.text.isNotEmpty &&
                        _timeController.text.isNotEmpty &&
                        _servingsController.text.isNotEmpty &&
                        _descriptionController.text.isNotEmpty &&
                        _ingredientsController.text.isNotEmpty &&
                        _instructionsController.text.isNotEmpty) {
                      setState(() {
                        check = true;
                      });
                    }
                  },
                  controller: _descriptionController,
                  maxLines: 3,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
                      // contentPadding: EdgeInsets.only(bottom: 10),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      errorText: descriptionValidate
                          ? "Please provide the required description"
                          : null,
                      disabledBorder: InputBorder.none,
                      hintText: 'Add Description'),
                ),
                Text(
                  'Ingredients',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  onSubmitted: (value) {
                    if (_recipeNameController.text.isNotEmpty &&
                        _timeController.text.isNotEmpty &&
                        _servingsController.text.isNotEmpty &&
                        _descriptionController.text.isNotEmpty &&
                        _ingredientsController.text.isNotEmpty &&
                        _instructionsController.text.isNotEmpty) {
                      setState(() {
                        check = true;
                      });
                    }
                  },
                  controller: _ingredientsController,
                  maxLines: 3,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(

                      // contentPadding: EdgeInsets.only(bottom: 10),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      errorText: ingreValidte
                          ? "Please provide the required ingredients"
                          : null,
                      disabledBorder: InputBorder.none,
                      hintText: '•             Add Ingredients'),
                ),
                Text(
                  'Instructions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  onSubmitted: (value) {
                    if (_recipeNameController.text.isNotEmpty &&
                        _timeController.text.isNotEmpty &&
                        _servingsController.text.isNotEmpty &&
                        _descriptionController.text.isNotEmpty &&
                        _ingredientsController.text.isNotEmpty &&
                        _instructionsController.text.isNotEmpty) {
                      setState(() {
                        check = true;
                      });
                    } else {
                      setState(() {
                        check = false;
                      });
                    }
                  },
                  controller: _instructionsController,
                  maxLines: 3,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
                      // contentPadding: EdgeInsets.only(bottom: 10),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      errorText: insValidate
                          ? "Please provide the required instructions"
                          : null,
                      disabledBorder: InputBorder.none,
                      hintText: '1.           Add Instructions'),
                )
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
