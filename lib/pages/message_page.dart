import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sanogano/constant/message_json.dart';
import 'package:sanogano/pages/newMessage_page.dart';


class MessagesPage extends StatefulWidget {
  MessagesPage({Key key}) : super(key: key);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
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
                  'Messages',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  // fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewMessagePage()),
                    );
                  },
                  child: SvgPicture.asset(
                    'assets/images/NewMessageai.svg',
                    width: 25,
                    color: Colors.black,
                  ),
                )
              ],
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 05, bottom: 15),
          child: Container(
            child: Column(
              children: [
                Container(
                   
                    height: 40,
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.top,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                          hintStyle: TextStyle(
                            height: 2.8,
                          ),
                          border: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              width: 2,
                              style: BorderStyle.none,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[200]),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[200]),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          errorBorder: InputBorder.none,
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Search"),
                    )),
                Container(
                  child: Column(
                    children: [
                      SizedBox(height: 05),
                      Container(
                        child: Column(
                          children: List.generate(messages.length, (index) {
                            return Column(
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                      ),
                                      width: 8,
                                      height: 8,
                                    ),
                                    SizedBox(width: 05.0),
                                    Container(
                                      width: 55,
                                      height: 55,
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
                                                      messages[index]['image']),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            messages[index]['text'],
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                          Text(
                                            messages[index]['message'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black45),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          messages[index]['time'],
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          messages[index]['icon'],
                                          color: Colors.black,
                                          width: 30,
                                        )
                                      ],
                                    )
                                  ],
                                ),

                                SizedBox(height: 05),
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       left: 0.0, right: 45),
                                //   child: Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceBetween,
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     children: [
                                //       SizedBox(height: 25),
                                //       Row(
                                //         children: [
                                //           SvgPicture.asset(
                                //             "assets/images/love_icon.svg",
                                //             width: 20,
                                //             color: Colors.black,
                                //           ),
                                //           SizedBox(
                                //             width: 10,
                                //           ),
                                //           Text(
                                //             comments[index]['likes'],
                                //             style: TextStyle(
                                //                 fontSize: 20.0,
                                //                 color: Colors.black45),
                                //           )
                                //         ],
                                //       ),
                                //       Text(comments[index]['time'],
                                //           style: TextStyle(
                                //               fontSize: 20.0,
                                //               color: Colors.black45)),
                                //       InkWell(
                                //         onTap: () {
                                //           Navigator.push(
                                //             context,
                                //             MaterialPageRoute(
                                //                 builder: (context) =>
                                //                     ReplyPage()),
                                //           );
                                //         },
                                //         child: Text(comments[index]['reply'],
                                //             style: TextStyle(
                                //                 fontSize: 20.0,
                                //                 color: Colors.black45)),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                // SizedBox(height: 15),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
