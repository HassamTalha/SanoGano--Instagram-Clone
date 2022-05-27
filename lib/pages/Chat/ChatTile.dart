import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sanogano/pages/Chat/ChatRoomModel.dart';
import 'package:sanogano/pages/Chat/PeerToPeerChat.dart';

class ChatTile extends StatelessWidget {

 final ChatRoom chatRoom;
 final String userID;
  ChatTile(this.chatRoom, this.userID);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
         Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PeerToPeerChat(chatRoom, "AlreadyExisted"),
              ));
      },
          child: Column(
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
                              padding:
                      const EdgeInsets.all(3.0),
                              child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black,
                            width: 2),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image:chatRoom.isRoom ?chatRoom.chatDP == "default" ? AssetImage("assets/default_avatar.png"): NetworkImage(
                                                       chatRoom.chatDP)   : userID == chatRoom.peerUUID ? chatRoom.creatorDP=="default" ?   AssetImage("assets/default_avatar.png"): NetworkImage(
                                                       chatRoom.creatorDP) : chatRoom.chatDP== "default" ? AssetImage("assets/default_avatar.png"): NetworkImage(
                                                       chatRoom.chatDP),
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
                      Row(
                        children: [
                          Text(
                            userID == chatRoom.peerUUID ? chatRoom.isRoom ? chatRoom.chatName: chatRoom.chatCreator : 
                          "${chatRoom.chatName}",
                          style: TextStyle(
                              fontSize: 16.0),
                          ),
                          SizedBox(width: 5),
                          Text(": ${DateFormat("HH:mm a").format(chatRoom.timeStamp.toDate()).toString()}",style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),)
                        ],
                      ),
                      Text(
                      chatRoom.lastMessage,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black45),
                          overflow: TextOverflow.ellipsis,
                      ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment:
                      CrossAxisAlignment.end,
                            children: [
                              Text(
                    DateFormat("dd/MM/yyyy")
                        .format(chatRoom.timeStamp.toDate())
                        .toString(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 7,),
                              Icon(Icons.arrow_forward_ios_rounded, 
                      color: Colors.black,
                       size: 20,
                     )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 05),
                      ],
                          ),
    );
  }
}