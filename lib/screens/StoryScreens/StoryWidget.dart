import 'package:flutter/material.dart';
import 'package:sanogano/constants.dart';

class StoriesWidget extends StatelessWidget {
  final String userImage;
  final String image;
  StoriesWidget(this.image, this.userImage);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      height: MediaQuery.of(context).size.width * 0.2,
      width: MediaQuery.of(context).size.width * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(300),
        image: image.split('.#_-_#.')[0]== "image" ? DecorationImage(image: NetworkImage(image.split('.#_-_#.')[1]), fit: BoxFit.cover) : null,
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(300),
              color: image.split('.#_-_#.')[0]== "image" ? null : myColors[int.parse(image.split('.#_-_#.')[0].split(' ')[0])],
              gradient:image.split('.#_-_#.')[0]!= "image" ? null : LinearGradient(colors: [
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(0.5)

              ]),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: double.infinity,),
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text( image.split('.#_-_#.')[0]== "image" ? "" : image.split('.#_-_#.')[1] ,style: TextStyle(color: Colors.white),),
              ),],
            )
          ),
          Padding(
            padding: const EdgeInsets.only(left: 3.0, bottom: 3.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Card(
                margin: EdgeInsets.zero,
                shape: CircleBorder(),
                color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(2),
                                                              child: CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(userImage),
                ),
                              ),
              ),
            ),
          )
        ],
      ),
    );
  }
}