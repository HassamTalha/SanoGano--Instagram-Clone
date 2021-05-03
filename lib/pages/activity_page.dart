import 'package:flutter/material.dart';

class ActivityPage extends StatefulWidget {
  ActivityPage({Key key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 08),
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today",
                    style: TextStyle(fontSize: 22.0, color: Colors.black),
                  ),
                  Text(
                    "Requests",
                    style: TextStyle(fontSize: 22.0, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("assets/images/ibrahim.jpg"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "Ahmed is the mutual friend",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  )
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("assets/images/ibrahim.jpg"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "Ahmed is the mutual friend",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  )
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("assets/images/ibrahim.jpg"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "Ahmed is the mutual friend",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  )
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("assets/images/ibrahim.jpg"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "Ahmed is the mutual friend",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  )
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("assets/images/ibrahim.jpg"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "Ahmed is the mutual friend",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  )
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("assets/images/ibrahim.jpg"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "Ahmed is the mutual friend",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  )
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("assets/images/ibrahim.jpg"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "Ahmed is the mutual friend",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  )
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("assets/images/ibrahim.jpg"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "Ahmed is the mutual friend",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  )
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("assets/images/ibrahim.jpg"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "Ahmed is the mutual friend",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  )
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("assets/images/ibrahim.jpg"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "Ahmed is the mutual friend",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
