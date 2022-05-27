import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sanogano/Login/LoginScreen.dart';
import 'package:sanogano/pages/Chat/ChatRoomModel.dart';
import 'package:sanogano/pages/Chat/Conversation.dart';
import 'package:sanogano/pages/Chat/PeerDetails.dart';

class PeerToPeerChat extends StatefulWidget {
  final String from;
  final ChatRoom userData;
  PeerToPeerChat(this.userData, this.from);
  @override
  _PeerToPeerChatState createState() => _PeerToPeerChatState();
}

class _PeerToPeerChatState extends State<PeerToPeerChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: InkWell(
          onTap: () {
           

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => PeerDetails(widget.userData),
            //   ),
            // );
          },
          child: Hero(
                    tag: widget.userData.chatDP + widget.userData.chatName,
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        widget.userData.chatName,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
        ),
        actions: [ Hero(
                tag: widget.userData.chatDP,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.red[200],
                    radius: 20,
                    backgroundImage:  widget.userData.chatDP == "default"
                            ?
                            // widget.userData.roomDP
                            AssetImage("assets/default_avatar.png")
                            : NetworkImage(widget.userData.chatDP),
                  ),
                ),
              ),],
      ),
      body: Column(children: [
        Expanded(
          child: ChatScreen(
              peerName: widget.userData.chatName,
              peerId: widget.userData.peerUUID,
              from: widget.from,
              peerAvatar: widget.userData.chatDP,
              chatRoomDetails: widget.userData),
        ),
      ]),
    );
  }
}
