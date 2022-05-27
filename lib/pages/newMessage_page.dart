import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sanogano/constant/newMessage_json.dart';
import 'package:sanogano/models/User.dart';
import 'package:sanogano/pages/Chat/ChatRoomModel.dart';
import 'package:sanogano/pages/Chat/PeerToPeerChat.dart';
import 'ChatGroups/CreateGroup.dart';
class NewMessagePage extends StatefulWidget {
  NewMessagePage({Key key}) : super(key: key);

  @override
  _NewMessagePageState createState() => _NewMessagePageState();
}

class _NewMessagePageState extends State<NewMessagePage> {
  bool check = false;
  int listIndex;
  List<String> friendData ;
  void selectFriend(DocumentSnapshot doc) {
    friendData = [doc["friendName"], doc["friendUUID"], doc["dp"]];
  } 

  AppUser appUser;
  getMyData() async{
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser.uid).get();
    appUser = AppUser.fromMap(doc.data());
    print("Current User data Fetched ${appUser.accountCreated}");
   }
  @override
  void initState() {
    super.initState();
    getMyData();

  }
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
                TextButton(
                  child: Text(
                  'Start',
                  style: TextStyle(color: Colors.black45, fontSize: 20),
                ),
                onPressed:friendData==null ? (){
                  Fluttertoast.showToast(msg: "Please choose any friend");
                } : () async{
                  print(friendData);
                  DocumentSnapshot doc = await FirebaseFirestore.instance.collection("Users")
                  .doc(friendData[1]).get();
                  ChatRoom room = ChatRoom(
                        chatCreator: appUser.name,
                        chatDP: doc.data()["profileDP"],
                        chatName: doc.data()["name"],
                        creatorDP: appUser.profileDP,
                        peerUUID: friendData[1],

                        isRead: false,
                        isRoom: false,
                        lastMessage: "",
                        roomID: getRoomId(FirebaseAuth.instance.currentUser.uid,friendData[1]),
                                                                        timeStamp: Timestamp.now());
                                                                    Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder: (context) => PeerToPeerChat(room, "New"),
                                                                      ),
                                                                    );
                                                                },
                                                                ),
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
                                                                Container(
                                                            color: Colors.white,
                                                            child: ListTile(
                                                              leading: Icon(Icons.group),
                                                              title: Text("New Group"),
                                                              onTap: () {
                                                                Navigator.push(context,
                                                                    CupertinoPageRoute(builder: (context) => CreateGroup()));
                                                              },
                                                            ),
                                                          ),
                                                          Divider(),
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
                                                                  child:  StreamBuilder(
                                                                    
                                                                    stream: FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser.uid).collection("Followers").snapshots(),
                                                                    builder: (context, AsyncSnapshot<QuerySnapshot> snap){
                                                
                                                                      if(snap.hasData && snap.data.docs.isNotEmpty){
                                                                        List<DocumentSnapshot> docs = snap.data.docs;
                                                                        return Column(
                                                                        children: List.generate(docs.length, (index) {
                                                                          return Column(
                                                                            children: [
                                                                              SizedBox(height: 10),
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  selectFriend(docs[index]);
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
                                                                                                  image:docs[index]["dp"] == "default" ? AssetImage(
                                                                                                      "assets/default_avatar.png") : NetworkImage(docs[index]["dp"]),
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
                                                                                            docs[index]['friendName'],
                                                                                            style: TextStyle(fontSize: 16.0),
                                                                                          ),
                                                                                          // Text(
                                                                                          //   newMessages[index]['user_name'],
                                                                                          //   style: TextStyle(
                                                                                          //       fontSize: 16,
                                                                                          //       color: Colors.black45),
                                                                                          // ),
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
                                                                      );
                                                                      }
                                                                      else{
                                                                        if(snap.connectionState == ConnectionState.waiting){
                                                                          return Center(
                                                
                                                                            child: CircularProgressIndicator(),
                                                
                                                                          );
                                                                        }
                                                                        else{
                                                                          return Container();
                                                                        }
                                                                      }
                                                
                                                
                                                
                                                
                                                                  })
                                                                      
                                                                   
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                        
                          String getRoomId(String myUid, String friendUid) {

                            if(myUid.hashCode < friendUid.hashCode){

                              return "$myUid-$friendUid";

                            }
                            else{
                              return "$friendUid-$myUid";
                            }
                          }
                        }
                        
