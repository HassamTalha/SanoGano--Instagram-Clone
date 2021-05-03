import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sanogano/code/widgets/CustomSwitch.dart';


class MyTags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/Back.ai.svg",
            height: 25,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        title: Text(
          "Tagged",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          
          TagModel("Posts"),
          TagModel("Comments"),
          TagModel("Replies"),
        ],
      ),
    );
  }
}

class TagModel extends StatefulWidget {
  final String text;
  TagModel(this.text);

  @override
  _TagModelState createState() => _TagModelState();
}

class _TagModelState extends State<TagModel> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        widget.text,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
      ),
      trailing: MyCustomswitch(),
    );
  }
}
