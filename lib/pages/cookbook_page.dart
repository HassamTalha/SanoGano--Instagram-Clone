import 'package:flutter/material.dart';
import 'package:sanogano/constant/cookbook_json.dart';

class CookbookPage extends StatefulWidget {
  CookbookPage({Key key}) : super(key: key);

  @override
  _CookbookPageState createState() => _CookbookPageState();
}

class _CookbookPageState extends State<CookbookPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 05.0, right: 05),
      child: Container(
        child: GridView.count(
          shrinkWrap: true,
          mainAxisSpacing: 10,
          childAspectRatio: 0.91,
          crossAxisCount: 03,
          children: List.generate(cookbook.length, (index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 05.0, right: 05),
                  child: Container(
                    width: MediaQuery.of(context).size.height*0.160,
                    height: MediaQuery.of(context).size.height*0.150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        image: DecorationImage(
                            image: AssetImage(cookbook[index]['image']),
                            fit: BoxFit.cover)),
                  ),
                ),
                SizedBox(height:05),
                Text(
                  cookbook[index]['title'],style: TextStyle(fontSize: 10,),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
