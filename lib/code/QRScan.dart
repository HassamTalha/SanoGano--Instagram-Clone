import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyQrScan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [],
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
          "QR Code",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: Container()),
          Row(),
          SvgPicture.asset(
            "assets/icons/Go to QR Code.ai.svg",
            color: Colors.black,
          ),
          Expanded(child: Container()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/Camera.ai.svg",
                height: 25,
                color: Colors.black,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "Scan QR Code",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
