import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sanogano/models/workoutDetails.dart';
import 'package:sanogano/views/recipeView.dart';
import 'package:sanogano/views/workoutView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GymPage extends StatefulWidget {
  GymPage({Key key}) : super(key: key);

  @override
  _GymPageState createState() => _GymPageState();
}

class _GymPageState extends State<GymPage> {
  String userId;
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
      appBar: AppBar(
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
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 30,
                  )),
              Text(
                'Workout',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                ),
                // fontWeight: FontWeight.bold),
              ),
              SvgPicture.asset(
                'assets/images/Addai.svg',
                width: 25,
                color: Colors.black,
              )
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.only(left: 05.0, right: 05),
        child: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .collection("workout")
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                List data = snapshot.data.documents;
                return GridView.count(
                  shrinkWrap: true,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.95,
                  crossAxisSpacing: 0,
                  crossAxisCount: 03,
                  children: List.generate(data.length, (index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 05.0, right: 05),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => WorkoutView(
                                            workoutDetails: WorkoutDetails(
                                                exercises: data[index]
                                                    ["workoutExercise"],
                                                workoutName: data[index]
                                                    ["workoutName"],
                                                notes: data[index]
                                                    ["workoutNotes"],
                                                image: data[index]["imageUrl"]),
                                          )

                                      //  CreatePostScreen(
                                      //   imageFile: croppedImage,
                                      // ),
                                      ));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.height * 0.160,
                              height:
                                  MediaQuery.of(context).size.height * 0.150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                image: DecorationImage(
                                    image: data[index]["imageUrl"] != null
                                        ? new NetworkImage(
                                            data[index]["imageUrl"],
                                          )
                                        : AssetImage(
                                            "assets/images/Gym.ai.png",
                                          ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          data[index]['workoutName'],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  }),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
