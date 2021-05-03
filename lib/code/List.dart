import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Trash.ai.svg",
                height: 24,
                color: Colors.black,
              ),
              onPressed: () {})
        ],
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
          "List",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
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
