import 'package:flutter/material.dart';
import 'package:sanogano/constant/life_json.dart';

class LifePage extends StatefulWidget {
  LifePage({Key key}) : super(key: key);

  @override
  _LifePageState createState() => _LifePageState();
}

class _LifePageState extends State<LifePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:05.0,right: 05),
      child: Container(
        child: GridView.count(
          shrinkWrap: true,
          mainAxisSpacing: 20,
          childAspectRatio: 0.95,
          crossAxisSpacing: 0,
          crossAxisCount: 03,
          children: List.generate(life.length, (index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:05.0,right: 05),
                  child: Container(
                    width: MediaQuery.of(context).size.height*0.160,
                    height: MediaQuery.of(context).size.height*0.150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      image: DecorationImage(
                          image: AssetImage(
                            life[index]['image'],
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                Text(
                  life[index]['title'],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
