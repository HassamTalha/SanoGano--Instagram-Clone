import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FullImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
       fit: StackFit.expand,
        children: [
          Image.asset(
              "assets/images/uploadpic.jpg",
              fit: BoxFit.cover,
            ),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,

             children: [
 _appBar(),
 _bottomBar()

           ],),
         )
        ],
      ),
    );
  }

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          "assets/icons/Back.ai.svg",
          height: 34,
          color: Colors.white,
        ),
        SvgPicture.asset(
          "assets/icons/Save Picture.ai.svg",
          height: 34,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget _bottomBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          "assets/icons/Create Post.ai.svg",
          height: 34,
          color: Colors.white,
        ),
        SvgPicture.asset(
          "assets/icons/Send.ai.svg",
          height: 34,
          color: Colors.white,
        ),
      ],
    );
  }
}
