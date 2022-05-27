import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanogano/constants.dart';
import 'package:sanogano/models/User.dart';
import 'package:sanogano/pages/Chat/ChatRoomModel.dart';
import 'package:sanogano/pages/Chat/ChatWidget.dart';
import 'package:sanogano/widgets/Loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'GroupChatBubble.dart';

class ChatScreen extends StatefulWidget {
  final from;
  final peerId;
  final peerName;
  final String peerAvatar;
  final ChatRoom chatRoomDetails;

  ChatScreen(
      {Key key,
      @required this.peerName,
      @required this.peerId,
      @required this.from,
      @required this.peerAvatar,
      @required this.chatRoomDetails})
      : super(key: key);

  @override
  State createState() => ChatScreenState(peerAvatar: chatRoomDetails.chatDP);
}

class ChatScreenState extends State<ChatScreen> {
  ChatScreenState({Key key, @required this.peerAvatar});

  //
  //  Variables
  //
  String peerAvatar;
  String id;
  List<DocumentSnapshot> listMessage = new List.from([]);
  int _limit = 20;
  final int _limitIncrement = 20;

  SharedPreferences prefs;
  bool textFocused = false;
  File imageFile;
  bool isLoading;
  bool isShowSticker;
  String imageUrl;
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  //
  //__________________________________________________________________________________________________
  //

  AppUser appUser;
  getMyData() async{
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser.uid).get();
    appUser = AppUser.fromMap(doc.data());
    debugPrint("Current User data Fetched ${appUser.accountCreated}");
   }
  @override
  void initState() {
    super.initState();
getMyData();
   KeyboardVisibilityNotification().addNewListener(
    onChange: (bool visible) {
     setState(() {
       textFocused = visible;
     });
    },
  );
    listScrollController.addListener(_scrollListener);
    
    isLoading = false;
    isShowSticker = false;
    imageUrl = '';
  }

  //TODO : Use the function
  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FutureBuilder(
            future: getUserUUIDfromPrefs(),
            builder: (context, snapshot) {
             if(snapshot.hasData && snapshot.data != null){
                return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // List of messages
                  buildListMessage(),

                  // Sticker
                  (isShowSticker ? buildSticker() : Container()),

                  // Input content
                  buildInput(),
                ],
              );
             }
             else{
               return Center(child:  CircularProgressIndicator());
             }
            }
          ),

          //Loading
          buildLoading()
        ],
      ),
    );
  }

//User Interface

  Widget buildSticker() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                TextButton(
                  onPressed: () => onSendMessage(
                    'mimi1',
                    2,
                  ),
                  child: Image.asset(
                    'assets/Stickers/mimi1.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  onPressed: () => onSendMessage(
                    'mimi2',
                    2,
                  ),
                  child: Image.asset(
                    'assets/Stickers/mimi2.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  onPressed: () => onSendMessage(
                    'mimi3',
                    2,
                  ),
                  child: Image.asset(
                    'assets/Stickers/mimi3.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                TextButton(
                  onPressed: () => onSendMessage(
                    'mimi4',
                    2,
                  ),
                  child: Image.asset(
                    'assets/Stickers/mimi4.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  onPressed: () => onSendMessage(
                    'mimi5',
                    2,
                  ),
                  child: Image.asset(
                    'assets/Stickers/mimi5.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  onPressed: () => onSendMessage(
                    'mimi6',
                    2,
                  ),
                  child: Image.asset(
                    'assets/Stickers/mimi6.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                TextButton(
                  onPressed: () => onSendMessage(
                    'mimi7',
                    2,
                  ),
                  child: Image.asset(
                    'assets/Stickers/mimi7.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  onPressed: () => onSendMessage(
                    'mimi8',
                    2,
                  ),
                  child: Image.asset(
                    'assets/Stickers/mimi8.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  onPressed: () => onSendMessage(
                    'mimi9',
                    2,
                  ),
                  child: Image.asset(
                    'assets/Stickers/mimi9.gif',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: kLightGreyColor, width: 0.5)),
          color: Colors.white),
      padding: EdgeInsets.all(5.0),
      height: 180.0,
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading ? const Loading() : Container(),
    );
  }

  Widget buildInput() {
    return Row(
      children: <Widget>[
        // Button send image
        Visibility(
          visible: !textFocused,
          child: Row(
            children: [
              Material(
                child: Container(
                  child: IconButton(
                    icon: Image.asset("assets/camera.png", height: 20),
                    onPressed: () {
                      getImage(ImageSource.camera);
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                color: Colors.white,
              ),
              Material(
                child: Container(
                  child: IconButton(
                    icon: Image.asset("assets/image.png", height: 20),
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                color: Colors.white,
              ),
              // Material(
              //   child: Container(
              //     child: IconButton(
              //       icon: Image.asset("assets/happy.png", height: 20),
              //       onPressed: getSticker,
              //       color: Theme.of(context).primaryColor,
              //     ),
              //   ),
              //   color: Colors.white,
              // ),
            ],
          ),
        ),
        Visibility(
          visible: textFocused,
          child: Material(
            child: Container(
              child: IconButton(
                icon: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black),
                onPressed: () {
                  setState(() {
                    textFocused = !textFocused;
                   
                  });
                },
              ),
            ),
            color: Colors.white,
          ),
        ),

        // Edit text
        Expanded(
          child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
           padding: EdgeInsets.all(8),
            child: ConstrainedBox(
              constraints: BoxConstraints(
            maxHeight: 300.0,
      ),
              
              // duration: Duration(microseconds: 500),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(30),
              //   color: Colors.grey[200],
              // ),
             
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                maxLines: 5,
                minLines: 1,
                maxLengthEnforcement :MaxLengthEnforcement.enforced,

                // expands: true,

                // minLines: null,
                onSubmitted: (value) {

                  onSendMessage(
                    textEditingController.text,
                    0,
                  );
                },
                style: TextStyle(color: Colors.black, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Aa',
                  hintStyle: TextStyle(color: kLightGreyColor),
                ),
               
              ),
            ),
          ),
        ),

        // Button send message
        Material(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: Image.asset("assets/send.png", height: 24),
              onPressed: () => onSendMessage(
                textEditingController.text,
                0,
              ),
              color: Theme.of(context).primaryColor,
            ),
          ),
          color: Colors.white,
        ),
      ],
    );
  }

  Widget buildListMessage() {
    print("++++++ ${widget.chatRoomDetails.roomID}");
    return Flexible(
        fit: FlexFit.loose,
        child: FutureBuilder(
          future: getUserUUIDfromPrefs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return FutureBuilder(
                  future: chekingDocumentExistance(),
                  builder: (context, snapi) {
                    
                      return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            
                            .collection("Chats")
                            .doc(widget.chatRoomDetails.roomID)
                            .collection("messages")
                            .orderBy('timestamp', descending: true)
                            .limit(_limit)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          print("++++++++++++++++++++++++++++");
                          if (!snapshot.hasData ||
                              snapshot.data.docs.isEmpty) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Theme.of(context).primaryColor)));
                            }
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    "assets/chatAnim.gif",
                                    height: 80,
                                  ),
                                  Text(
                                    "Say something to start a conversation!",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            );
                          } else {
                           
                            listMessage = snapshot.data.docs;
                            return ListView.builder(
                              padding: EdgeInsets.all(10.0),
                              itemBuilder: (context, index) {
                                if(widget.chatRoomDetails.isRoom){

                                return GroupChatBubble(
                                index: index,
                                document: snapshot.data.docs[index],
                                id: id,
                                listMessage: listMessage,
                                peerAvatar: snapshot.data.docs[index]["userDp"],
                              );
                                }
                                else{
                                  return ChatBubble(
                                index: index,
                                document: snapshot.data.docs[index],
                                id: id,
                                listMessage: listMessage,
                                peerAvatar: peerAvatar,
                              );
                                }
                              } ,
                              itemCount: snapshot.data.docs.length,
                              reverse: true,
                              controller: listScrollController,
                            );
                          }
                        },
                      );
                    
                    
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            }
          },
        ));
  }

  Future<void> setChatLastMsg( String lastContent) async {
    FirebaseFirestore.instance
          .collection("Chats")
          .doc(widget.chatRoomDetails.roomID).update({
'lastMessage': lastContent,
'timeStamp': Timestamp.now()
          }, );

   
  }
//
//_____________________________ Buisness Logic _________________________
//
  Future getImage(ImageSource imageSource) async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    pickedFile = await imagePicker.getImage(source: imageSource);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        isLoading = true;
      });
      uploadFile();
    }
  }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot storageTaskSnapshot = await uploadTask;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl;
      setState(() {
        isLoading = false;
        onSendMessage(imageUrl, 1);
      });
    }, onError: (err) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: 'This file is not an image');
    });
  }

  bool flag = true;
  void onSendMessage(String content, int type) async {
    if (newChat && flag) {
      await createRoom(
        chatRoomID: widget.chatRoomDetails.roomID,
        peerAvatar: widget.chatRoomDetails.chatDP,
        peerName: widget.chatRoomDetails.chatName,
        peerId: widget.chatRoomDetails.peerUUID,
        currentUserDP: profileDP,
        currentUserName: name,
      );

      flag = false;
      newChat = false;
      
    }

    // type: 0 = text, 1 = image, 2 = sticker

    if (content.trim() != '') {
      textEditingController.clear();

      var documentReference = FirebaseFirestore.instance
          .collection("Chats")
          .doc(widget.chatRoomDetails.roomID)
          .collection("messages")
          .doc(DateTime.now().millisecondsSinceEpoch.toString());
      if(widget.chatRoomDetails.isRoom){
FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'idFrom': id,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type,
            'userDp':appUser.profileDP,
            'userName': appUser.name
          },
        );
      });
      }
      else{
        FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'idFrom': id,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type,
          },
        );
      });
      }
      
      setChatLastMsg(content);
      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(
          msg: 'Nothing to send',
          backgroundColor: Colors.black,
          textColor: Colors.red);
    }
  }

  void getSticker() {
    // Hide keyboard when sticker appear
   
    setState(() {
      isShowSticker = !isShowSticker;
    });
  }

  void onFocusChange() {
    if (textFocused) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  _scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      print("reach the bottom");
      setState(() {
        print("reach the bottom");
        _limit += _limitIncrement;
      });
    }
  }

  void loadListener(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  void dispose() {
    
    super.dispose();
    textEditingController.dispose();
    listScrollController.dispose();
  }

  void clearTextField() {
    textEditingController.clear();
  }

  void scrollToInitialPoint() {
    listScrollController.animateTo(0.0,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  String name = '';
  String profileDP = '';
  Future<String> getUserUUIDfromPrefs() async {
    prefs = await SharedPreferences.getInstance();

    id = prefs.getString('userId') ?? '';
    print(" ididididi : $id");
    name = prefs.getString("name");
    profileDP = prefs.getString("profileDP");
     print(" ididididi : $name");
      print(" ididididi : $profileDP");
    return id;
  }

  Future<bool> checkDoc() async {
    print("entered");

    bool exists = false;
    try {
      print(widget.chatRoomDetails.roomID);
      await FirebaseFirestore.instance
          .doc("Chats/${widget.chatRoomDetails.roomID}")
          .get()
          .then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  bool newChat = false;
  Future chekingDocumentExistance() async {
    if (widget.from == "New") {
      print("New");
      newChat = !(await checkDoc());
    } else {
      return Future.value(true);
    }

    return Future.value(true);
  }

  Future createRoom(
      {chatRoomID,
      peerId,
      peerAvatar,
      peerName,
      currentUserDP,
      currentUserName}) async {
    await FirebaseFirestore.instance
        .collection("Chats")
        .doc(chatRoomID)
        .set({
          //TODO : Enter Chat Creator Name
      "isRead": false,
      "isRoom" : false,
      "lastMessage": "...",
      "peerUUID": peerId,
      "chatDP": peerAvatar,
      "roomID": chatRoomID,
      "chatName": peerName,
      'chatCreator': name,
      'creatorDP':profileDP,
      "timeStamp": Timestamp.now()
    });
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(id)
        .collection("Chats")
        .doc(chatRoomID)
        .set({
      "id": chatRoomID,
    });
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(peerId)
        .collection("Chats")
        .doc(chatRoomID)
        .set({
      "id": chatRoomID,
    });
  }
}
