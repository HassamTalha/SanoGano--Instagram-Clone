import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sanogano/apis/Repository.dart';

import 'package:story_view/story_view.dart';
import 'package:timeago/timeago.dart' as timeago;

class StoryPage extends StatelessWidget {
  final String uid;
  final String userImage;
  final String userName;
  StoryPage(this.uid, this.userImage, this.userName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          
          if (snapshot.hasData) {
            return StoryViewDelegate(
              stories: snapshot.data,
              userImage: userImage,
              userName: userName,
            );
          }

          if (snapshot.hasError) {
            return Center(child: ErrorView());
          }

          return Center(
            child: SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(),
            ),
          );
        },
        future: Repository.getWhatsappStories(uid),
      ),
    );
  }
}

class ErrorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.cancel,
                color: Colors.red,
              ),
              SizedBox(
                width: 16,
              ),
              Text("An error occured while loading stories.")
            ],
          ),
          Lottie.network(
              "https://assets5.lottiefiles.com/temp/lf20_USCruP.json"),
          CupertinoButton(child: Text("Back"), onPressed: () {
            Navigator.pop(context);
          })
        ],
      ),
    );
  }
}

class StoryViewDelegate extends StatefulWidget {
  final List<WhatsappStory> stories;
  final userImage;
  final userName;
  StoryViewDelegate({this.stories, this.userImage, this.userName});

  @override
  _StoryViewDelegateState createState() => _StoryViewDelegateState();
}

class _StoryViewDelegateState extends State<StoryViewDelegate> {
  final StoryController controller = StoryController();
  List<StoryItem> storyItems = [];

  String when = "";

  @override
  void initState() {
    super.initState();
    widget.stories.forEach((story) {
      if (story.mediaType == MediaType.text) {
        storyItems.add(
          StoryItem.text(
            title: story.caption,
            backgroundColor: (story.color),
            duration: Duration(
              milliseconds: (story.duration * 1000).toInt(),
            ),
          ),
        );
      }

      if (story.mediaType == MediaType.image) {
        storyItems.add(StoryItem.pageImage(
          url: story.media,
          controller: controller,
          caption: story.caption,
          duration: Duration(
            milliseconds: (story.duration * 1000).toInt(),
          ),
        ));
      }

      if (story.mediaType == MediaType.video) {
        storyItems.add(
          StoryItem.pageVideo(
            story.media,
            controller: controller,
            duration: Duration(milliseconds: (story.duration * 1000).toInt()),
            caption: story.caption,
          ),
        );
      }
    });

    when =
        'Uploaded ${timeago.format(new DateTime.fromMillisecondsSinceEpoch(widget.stories[0].when))}';
  }

  Widget _buildProfileView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(widget.userImage),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.userName,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                when,
                style: TextStyle(
                  color: Colors.white38,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        StoryView(
          storyItems: storyItems,
          controller: controller,
          onComplete: () {
            Navigator.of(context).pop();
          },
          onVerticalSwipeComplete: (v) {
            if (v == Direction.down) {
              Navigator.pop(context);
            }
          },
          onStoryShow: (storyItem) {
            int pos = storyItems.indexOf(storyItem);

            // the reason for doing setState only after the first
            // position is becuase by the first iteration, the layout
            // hasn't been laid yet, thus raising some exception
            // (each child need to be laid exactly once)
            if (pos > 0) {
              setState(() {
                when =
                    'Uploaded ${timeago.format(new DateTime.fromMillisecondsSinceEpoch(widget.stories[pos].when))}';
              });
            }
          },
        ),
        Container(
          padding: EdgeInsets.only(
            top: 48,
            left: 16,
            right: 16,
          ),
          child: _buildProfileView(),
        )
      ],
    );
  }
}

// import 'package:flutter/material.dart';

// import "package:story_view/story_view.dart";

// class StoryScreen extends StatefulWidget {
//   @override
//   _StoryScreenState createState() => _StoryScreenState();
// }

// class _StoryScreenState extends State<StoryScreen> {
//   final controller = StoryController();

//   List<StoryItem> storyItems = [];
//   @override
//   void initState() {

//     super.initState();
//     storyItems = [
//     StoryItem.text(title: "Hi, This is my Story", backgroundColor: Colors.blue),
//     StoryItem.pageImage(
//       url:
//           "https://scontent.fisb1-2.fna.fbcdn.net/v/t1.0-9/61382885_2320261921550591_3251561994242752512_o.jpg?_nc_cat=101&ccb=3&_nc_sid=09cbfe&_nc_eui2=AeGT81LJlYo0yo_ik_dOO_hLdwjro-DgiXh3COuj4OCJeHJJauhtsTUn8q7zlh4WI6NfjIN7e2T8pBABzbSTI9v0&_nc_ohc=cZLF4sTHkCYAX_5ixEK&_nc_ht=scontent.fisb1-2.fna&oh=8f74a967a5b1caf5ecc12df22b2ad9cc&oe=605CACD5",
//       controller: controller,
//       imageFit: BoxFit.fitHeight
//     ),
//     StoryItem.pageImage(
//       url:
//           "https://scontent.fisb1-2.fna.fbcdn.net/v/t1.0-9/32856100_2062968340613285_5556719711359598592_n.jpg?_nc_cat=111&ccb=3&_nc_sid=174925&_nc_eui2=AeFbBLky-leuXNpdN4e6MwmfI0dpzSIwJsgjR2nNIjAmyFl82yx3bXMhl5eWWEEpCQxGMde6Og5ekY6hZ75sKOs1&_nc_ohc=hWBryo5VlJoAX-4TH5J&_nc_ht=scontent.fisb1-2.fna&oh=82e029282660ff19ed5697f7c0231d8d&oe=605B4C90",
//       controller: controller,
//       imageFit: BoxFit.fitHeight
//     ),
//     StoryItem.pageImage(
//       url:
//           "https://scontent.fisb1-2.fna.fbcdn.net/v/t1.0-9/45734190_2192699867640131_6036577294737211392_o.jpg?_nc_cat=109&ccb=3&_nc_sid=174925&_nc_eui2=AeHSm9jEmg3b6TcYb9bei7_Fts1QlSASo3S2zVCVIBKjdGmTPuDGRuyKJ3V_41vUJ0xhJ85Hfzojf_qeKIkR3R5z&_nc_ohc=lO7Gh81FI0MAX_nVeTG&_nc_ht=scontent.fisb1-2.fna&oh=0b889cad7c74e4606554aa8d7d20e4a4&oe=605BA3F7",
//       controller: controller,
//       imageFit: BoxFit.fitHeight
//     ),
//     StoryItem.pageImage(
//       url:
//           "https://scontent.fisb1-2.fna.fbcdn.net/v/t31.0-8/27500724_2012085989034854_2804735570822689174_o.jpg?_nc_cat=111&ccb=3&_nc_sid=19026a&_nc_eui2=AeFxxioZl4-chLJrsPpzq9g7CMyzXmLjxWwIzLNeYuPFbLEvVDkrn5dQT6_rK_xXbDxtyX9wSVXn_fnqF-4Pk22n&_nc_ohc=xHeFiHuTrb8AX_ouv1Q&_nc_ht=scontent.fisb1-2.fna&oh=81a7cf4bb9495c6eab469968f4b5c55c&oe=605D56C3",
//       controller: controller,
//       imageFit: BoxFit.fitHeight
//     ),
//         StoryItem.text(title: "Drag down to end Stories", backgroundColor: Colors.blue),

//   ];

//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(children: [
//         StoryView(
//             storyItems: storyItems,
//             controller: controller, // pass controller here too
//             repeat: true, // should the stories be slid forever
//             onStoryShow: (s) {},
//             onComplete: () {},
//             onVerticalSwipeComplete: (direction) {
//               if (direction == Direction.down) {
//                 Navigator.pop(context);
//               }
//             } // To disable vertical swipe gestures, ignore this parameter.
//             // Preferrably for inline story view.
//             ),
//         Container(
//           padding: EdgeInsets.only(
//             top: 48,
//             left: 16,
//             right: 16,
//           ),
//           child: _buildProfileView(),
//         ),
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: Container(
//             padding: EdgeInsets.only(
//               bottom: 18,
//               left: 16,
//               right: 16,
//             ),
//             child: bottomBarStorryScreen(),
//           ),
//         )
//       ]),
//     );
//   }

//   Widget _buildProfileView() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         CircleAvatar(
//           radius: 24,
//           backgroundColor: Colors.grey[200],
//           backgroundImage: NetworkImage(
//               "https://scontent.fisb1-2.fna.fbcdn.net/v/t1.0-9/61382885_2320261921550591_3251561994242752512_o.jpg?_nc_cat=101&ccb=3&_nc_sid=09cbfe&_nc_eui2=AeGT81LJlYo0yo_ik_dOO_hLdwjro-DgiXh3COuj4OCJeHJJauhtsTUn8q7zlh4WI6NfjIN7e2T8pBABzbSTI9v0&_nc_ohc=cZLF4sTHkCYAX_5ixEK&_nc_ht=scontent.fisb1-2.fna&oh=8f74a967a5b1caf5ecc12df22b2ad9cc&oe=605CACD5"),
//         ),
//         SizedBox(
//           width: 16,
//         ),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 "Hassam Talha",
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//               Text(
//                 "5m",
//                 style: TextStyle(
//                   color: Colors.white38,
//                 ),
//               )
//             ],
//           ),
//         ),
//         IconButton(
//             icon: Icon(
//               Icons.close_rounded,
//               size: 36,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             })
//       ],
//     );
//   }

//   Widget bottomBarStorryScreen() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           "9k Views",
//           style: TextStyle(
//               color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
//         ),
//         IconButton(
//           icon: Icon(
//             Icons.more_horiz,
//             size: 34,
//             color: Colors.white,
//           ),
//           onPressed: () {},
//         )
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
// }
