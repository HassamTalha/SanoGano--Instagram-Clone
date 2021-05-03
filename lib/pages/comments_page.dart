import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sanogano/constant/comments_data.dart';
import 'package:sanogano/pages/reply_screen.dart';

class CommentsPage extends StatefulWidget {
  CommentsPage({Key key}) : super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
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
                  '55 Comments',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  // fontWeight: FontWeight.bold),
                ),
                SvgPicture.asset(
                  'assets/images/Sortai.svg',
                  width: 25,
                  color: Colors.black,
                )
              ],
            )),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SafeArea(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: List.generate(comments.length, (index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 2),
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      comments[index]['image']),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 05),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Spencer',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black87),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(left: 45.0),
                                  child: Row(
                                    children: [
                                      SizedBox(height: 25),
                                      Row(
                                        children: [
                                          Text('  '),
                                          SvgPicture.asset(
                                            "assets/images/love_icon.svg",
                                            width: 16,
                                            color: Colors.black45,
                                          ),
                                          SizedBox(
                                            width: 05,
                                          ),
                                          Text(
                                            comments[index]['likes'],
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black45),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                45 / .15,
                                      ),
                                      Text(comments[index]['time'],
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black45)),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                45 / .15,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ReplyPage()),
                                          );
                                        },
                                        child: Text(comments[index]['reply'],
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black45)),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
                              ],
                            );
                          }),
                        ),
                      ),
                      SizedBox(
                        height: 120,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/ibrahim.jpg'),
                                  fit: BoxFit.cover)),
                        ),
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width - 72,
                          child: TextField(
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              suffixIconConstraints: BoxConstraints(
                                minHeight: 30,
                                minWidth: 42,
                              ),
                              errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black)),

                              disabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black),
                              ),

                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.black,
                                ),
                              ),

                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  borderSide: BorderSide(
                                    width: 1,
                                  )),

                              hintStyle: TextStyle(
                                height: 2.8,
                              ),
                              isDense: true,
                              suffixIcon: Container(
                                  height: 20,
                                  width: 20,
                                  child: SvgPicture.asset(
                                      'assets/images/sendMessage.ai..svg')),
                              hintText: ' Add a comment',
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(45),
                              //   borderSide: BorderSide(
                              //     color: Colors.red,
                              //     width: 5,
                              //     style: BorderStyle.none,
                              //   ),
                              // ),
                              filled: true,
                              contentPadding: EdgeInsets.all(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
