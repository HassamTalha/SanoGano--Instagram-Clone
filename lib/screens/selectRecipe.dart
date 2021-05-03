import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sanogano/constant/cookbook_json.dart';

import 'createRecipe.dart';

class SelectRecipeScreen extends StatelessWidget {
  const SelectRecipeScreen({Key key}) : super(key: key);

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
                'Select Recipe',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
                // fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateRecipePostPage()),
                  );
                },
                child: SvgPicture.asset(
                  'assets/images/Addai.svg',
                  width: 25,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 05.0, right: 05),
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
                      width: MediaQuery.of(context).size.height * 0.160,
                      height: MediaQuery.of(context).size.height * 0.150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          image: DecorationImage(
                              image: AssetImage(cookbook[index]['image']),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  SizedBox(height: 05),
                  Text(
                    cookbook[index]['title'],
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
