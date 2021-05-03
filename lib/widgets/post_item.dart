import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sanogano/pages/comments_page.dart';
import 'package:video_player/video_player.dart';
import '../widgets/playerforhomepage.dart';
import '../screens/share_post.dart';

class PostItem extends StatelessWidget {
  final String profileImg;
  final String videoUrl;
  final String name;
  final String postImg;
  final String caption;
  final isLoved;
  final String likedBy;
  final String viewCount;
  final String dayAgo;
  const PostItem({
    Key key,
    this.videoUrl,
    this.profileImg,
    this.name,
    this.postImg,
    this.isLoved,
    this.likedBy,
    this.viewCount,
    this.dayAgo,
    this.caption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VideoPlayerController _controller;
    Future<void> _initializeVideoPlayerFuture;
    String _error;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(profileImg),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      width: 05,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 05.0),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "5h",
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SvgPicture.asset(
                  'assets/icons/Options.ai.svg',
                  height: 25,
                  width: 25,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          // Stack(
          //   children: <Widget>[
          //     _error == null
          //         ? NetworkPlayerLifeCycle(
          //             videoUrl,
          //             (BuildContext context,
          //                     VideoPlayerController controller) =>
          //                 AspectRatioVideo(controller),
          //           )
          //         : Center(
          //             child: Text(_error),
          //           ),
          //     // Container(
          //     //   padding: EdgeInsets.all(16.0),
          //     //   child: IconButton(
          //     //     icon: Icon(Icons.close, color: Colors.white),
          //     //     onPressed: () => Navigator.pop(context),
          //     //   ),
          //     // ),
          //   ],
          // ),
          // FittedBox(
          //   child: Image.network(postImg),
          //   fit: BoxFit.fill,

          // ),

          // Stack(

          //   children: [
          //     Image.network(postImg, fit: BoxFit.cover),
          //   ],
          // ),
          Container(
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //       image: NetworkImage(postImg), fit: BoxFit.cover,)
            // ),
            child: Stack(
              children: [
                Image.network(postImg, fit: BoxFit.cover),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                        child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlayerForHomePage(
                                    video: videoUrl,
                                  )),
                        );
                      },
                      iconSize: 70,
                      color: Colors.grey,
                      icon: Opacity(opacity:0.5,child: Icon(Icons.play_arrow)),
                    ),
                    // child: Neumorphic(
                    
                    //     style: NeumorphicStyle(
                        
                    //         shape: NeumorphicShape.concave,
                    //         boxShape: NeumorphicBoxShape.roundRect(
                    //             BorderRadius.circular(12)),
                    //         depth: 2,
                    //         lightSource: LightSource.topLeft,
                    //         color: Colors.grey),
                    //     child: IconButton(
                    //       onPressed: () {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => PlayerForHomePage(
                    //               video: videoUrl,
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //       iconSize: 30,
                    //       // color: Colors.grey[500],
                    //       icon: Icon(Icons.play_arrow),
                    //     )),
                    // child: IconButton(
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => PlayerForHomePage(
                    //                 video: videoUrl,
                    //               )),
                    //     );
                    //   },
                    //   iconSize: 70,
                    //   color: Colors.grey[500],
                    //   icon: Icon(Icons.play_arrow),
                    // ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    isLoved
                        ? SvgPicture.asset(
                            "assets/images/loved_icon.svg",
                            width: 27,
                            color: Colors.black,
                          )
                        : SvgPicture.asset(
                            "assets/images/love_icon.svg",
                            width: 27,
                            color: Colors.black,
                          ),
                    SizedBox(width: 10.0),
                    Text(
                      "10",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black45,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommentsPage()),
                        );
                      },
                      child: SvgPicture.asset(
                        "assets/images/Comment.ai.svg",
                        width: 27,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "18",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black45,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SharePostScreen()),
                    );
                  },
                  child: SvgPicture.asset(
                    "assets/images/Send.ai.svg",
                    width: 27,
                    color: Colors.black,
                  ),
                ),
                SvgPicture.asset(
                  "assets/images/save_icon.svg",
                  width: 27,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
