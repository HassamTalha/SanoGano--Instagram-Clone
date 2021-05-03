import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sanogano/constant/comments_data.dart';

class ReplyPage extends StatefulWidget {
  ReplyPage({Key key}) : super(key: key);

  @override
  _ReplyPageState createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage> {
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
                  '5 Replies',
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
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: List.generate(comments.length, (index) {
                          return Column(
                            children: [
                              Row(
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
                                                color: Colors.black, width: 2),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    comments[index]['image']),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'This picture looks very cool ',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 05),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 0.0, right: 45),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 05),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/images/love_icon.svg",
                                          width: 25,
                                          color: Colors.black,
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
                                    Text(comments[index]['time'],
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black45)),
                                    Text("Reply",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black45)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
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
                          width: MediaQuery.of(context).size.width - 65,
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
                              hintText: '@Add a reply',
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
                  SizedBox(height: 20),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
