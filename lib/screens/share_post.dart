import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sanogano/constant/newMessage_json.dart';

class SharePostScreen extends StatefulWidget {
  SharePostScreen({Key key}) : super(key: key);

  @override
  _SharePostScreenState createState() => _SharePostScreenState();
}

class _SharePostScreenState extends State<SharePostScreen> {
  int listIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: new RotatedBox(
              quarterTurns: 2,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset(
                  'assets/images/Forwardai.svg',
                  width: 10,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Material(
                    elevation: 05,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.22,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 75,
                            height: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(17),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/images/appbar.png',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // SizedBox(height:02),
                        Text(
                          '_______',
                          style: TextStyle(
                            color: Colors.black38,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 10.0, right: 12.0),
                          child: Container(
                            height: 40,
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.top,
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                  hintStyle: TextStyle(
                                    height: 0.8,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFF2F2F2),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                    borderSide:
                                        BorderSide(width: 1, color: Colors.red),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    borderSide: BorderSide(
                                        width: 1, color: Color(0xFFf707070)),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      borderSide: BorderSide(
                                        width: 1,
                                      )),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      borderSide: BorderSide(
                                          width: 1, color: Color(0xFFf707070))),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      borderSide: BorderSide(
                                          width: 1, color: Color(0xFFf707070))),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 15),
                                  hintText: "Search"
                                  
                                  //  errorText: snapshot.error,
                                  ),
                              obscureText: false,
                            ),
                          ),
                        ),

                        SizedBox(height: 20),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0, right: 12.0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/ibrahim.jpg'),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  'Add post to your story',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              RotatedBox(
                                quarterTurns: 4,
                                child: SvgPicture.asset(
                                  'assets/images/Forwardai.svg',
                                  width: 20,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8.0, right: 12.0),
                          child: Container(
                            child: Column(
                              children:
                                  List.generate(newMessages.length, (index) {
                                return Column(
                                  children: [
                                    SizedBox(height: 10),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          listIndex = index;
                                        });
                                        if (newMessages[index] == listIndex) {
                                          print("dkjaskdj");
                                        }

                                        print(newMessages[index]);
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 55,
                                            height: 55,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Container(
                                                width: 45,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                    // border: Border.all(
                                                    //     color: Colors.black,
                                                    //     width: 2),
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          newMessages[index]
                                                              ['image']),
                                                      fit: BoxFit.cover,
                                                    )),
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
                                                  newMessages[index]['name'],
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  '@${newMessages[index]['user_name']}',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            ),
                                          ),
                                          index != listIndex
                                              ? SvgPicture.asset(
                                                  'assets/images/Selectai.svg',
                                                  width: 25,
                                                  color: Colors.black,
                                                )
                                              : SvgPicture.asset(
                                                  'assets/images/Selectedai.svg',
                                                  width: 25,
                                                ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 05),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30)
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 90,
                child: Column(
                  children: [
                    TextFormField(
                      style: TextStyle(decoration: TextDecoration.none),
                      textAlignVertical: TextAlignVertical.top,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            height: 1.2,
                          ),
                          filled: true,
                          fillColor: Color(0xFFF2F2F2),
                          contentPadding: EdgeInsets.only(
                              left: 20, bottom: 11, top: 11, right: 15),
                          hintText: "Write a message"
                          //  errorText: snapshot.error,
                          ),
                      obscureText: false,
                    ),
                    Container(
                      height: 42,
                      child: Center(
                        child: Text(
                          'Send Separately',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(
                          0xFFF064D8B,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
