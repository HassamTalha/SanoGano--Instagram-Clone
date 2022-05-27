import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanogano/constant/cookbook_json.dart';
import 'package:sanogano/constant/life_json.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CookbookPage extends StatefulWidget {
  CookbookPage({Key key}) : super(key: key);

  @override
  _CookbookPageState createState() => _CookbookPageState();
}

class _CookbookPageState extends State<CookbookPage> {
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
    return Padding(
      padding: const EdgeInsets.only(left: 05.0, right: 05),
      child: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection("recipe")
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              List<DocumentSnapshot> data = snapshot.data.docs;
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
                        child: Container(
                          width: MediaQuery.of(context).size.height * 0.160,
                          height: MediaQuery.of(context).size.height * 0.150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            image: DecorationImage(
                                image: data[index]["imageUrl"] != null
                                    ? new NetworkImage(
                                        "https://firebasestorage.googleapis.com/v0/b/sanogano-4e221.appspot.com/o/thumbnail%2Fimage_picker454483197620625779.jpg?alt=media&token=a05a1f21-4bf7-418b-8455-d6bbf84f314f")
                                    : AssetImage("assets/images/g182.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Text(
                        data[index]['recipeName'],
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
    );
  }
}
