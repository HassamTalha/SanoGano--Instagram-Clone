import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ListScreen extends StatefulWidget {
  ListScreen({Key key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
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
                  'Life',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  // fontWeight: FontWeight.bold),
                ),
                SvgPicture.asset(
                  'assets/images/Trashai.svg',
                  width: 25,
                  color: Colors.black,
                )
              ],
            )),
      ),
      body: Column(
        children: [
          ListModel("Apple", "Select"),
          ListModel("Orange", "Select"),
          ListModel("Cup Milk", "Selected"),
          ListModel("Mango Juice", "Select"),
          ListModel("Apple Juice", "Select"),
          ListModel("WaterMelon", "Select"),
        ],
      ),
    );
  }
}

class ListModel extends StatelessWidget {
  final String text;
  final String image;
  ListModel(this.text, this.image);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        text,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
      ),
      trailing: SvgPicture.asset(
        "assets/icons/$image.ai.svg",
        height: 20,
        color: Colors.black,
      ),
    );
  }
}
