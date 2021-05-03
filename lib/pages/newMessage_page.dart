import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sanogano/constant/newMessage_json.dart';

class NewMessagePage extends StatefulWidget {
  NewMessagePage({Key key}) : super(key: key);

  @override
  _NewMessagePageState createState() => _NewMessagePageState();
}

class _NewMessagePageState extends State<NewMessagePage> {
  bool check = false;
  int listIndex;
  void logic(int value) {}
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
                  'New Message',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  // fontWeight: FontWeight.bold),
                ),
                Text(
                  'Start',
                  style: TextStyle(color: Colors.black45, fontSize: 20),
                )
              ],
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'To',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
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
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Suggested',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  child: Column(
                    children: [
                      
                      Container(
                        child: Column(
                          children: List.generate(newMessages.length, (index) {
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
                                                        newMessages[index]
                                                            ['image']),
                                                    fit: BoxFit.cover,)),
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
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                            Text(
                                              newMessages[index]['user_name'],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black45),
                                            ),
                                          ],
                                        ),
                                      ),
                                      index != listIndex
                                          ? SvgPicture.asset(
                                              'assets/images/Selectai.svg',
                                              width: 25,
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
