import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sanogano/code/widgets/CustomSwitch.dart';


class MyRequests extends StatelessWidget {
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
          "Requests",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          RequestModel("Follow"),
          RequestModel("Group"),
          RequestModel("Message"),
        ],
      ),
    );
  }
}

class RequestModel extends StatefulWidget {
  final String text;
  RequestModel(this.text);

  @override
  _RequestModelState createState() => _RequestModelState();
}

class _RequestModelState extends State<RequestModel> {
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
