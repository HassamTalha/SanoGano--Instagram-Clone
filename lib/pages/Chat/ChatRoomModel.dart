import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ChatRoom {
  bool isRead;

  String lastMessage;
  String peerUUID;

  String chatDP;
  String roomID;
  String chatName;
  Timestamp timeStamp;
  String chatCreator;
  String creatorDP;
  bool isRoom;
  ChatRoom({
    @required this.isRead,
    @required this.lastMessage,
    @required this.peerUUID,
    @required this.chatDP,
    @required this.roomID,
    @required this.chatName,
    @required this.timeStamp,
    @required this.chatCreator,
    @required this.creatorDP,
    @required this.isRoom,
  });
  

  ChatRoom copyWith({
    bool isRead,
    String lastMessage,
    String peerUUID,
    String chatDP,
    String roomID,
    String chatName,
    Timestamp timeStamp,
    String chatCreator,
    String creatorDP,
    bool isRoom,
  }) {
    return ChatRoom(
      isRead: isRead ?? this.isRead,
      lastMessage: lastMessage ?? this.lastMessage,
      peerUUID: peerUUID ?? this.peerUUID,
      chatDP: chatDP ?? this.chatDP,
      roomID: roomID ?? this.roomID,
      chatName: chatName ?? this.chatName,
      timeStamp: timeStamp ?? this.timeStamp,
      chatCreator: chatCreator ?? this.chatCreator,
      creatorDP: creatorDP ?? this.creatorDP,
      isRoom: isRoom ?? this.isRoom,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isRead': isRead,
      'lastMessage': lastMessage,
      'peerUUID': peerUUID,
      'chatDP': chatDP,
      'roomID': roomID,
      'chatName': chatName,
      'timeStamp': timeStamp,
      'chatCreator': chatCreator,
      'creatorDP': creatorDP,
      'isRoom': isRoom,
    };
  }

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      isRead: map['isRead'],
      lastMessage: map['lastMessage'],
      peerUUID: map['peerUUID'],
      chatDP: map['chatDP'],
      roomID: map['roomID'],
      chatName: map['chatName'],
      timeStamp: map['timeStamp'],
      chatCreator: map['chatCreator'],
      creatorDP: map['creatorDP'],
      isRoom: map['isRoom'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatRoom.fromJson(String source) => ChatRoom.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatRoom(isRead: $isRead, lastMessage: $lastMessage, peerUUID: $peerUUID, chatDP: $chatDP, roomID: $roomID, chatName: $chatName, timeStamp: $timeStamp, chatCreator: $chatCreator, creatorDP: $creatorDP, isRoom: $isRoom)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ChatRoom &&
      other.isRead == isRead &&
      other.lastMessage == lastMessage &&
      other.peerUUID == peerUUID &&
      other.chatDP == chatDP &&
      other.roomID == roomID &&
      other.chatName == chatName &&
      other.timeStamp == timeStamp &&
      other.chatCreator == chatCreator &&
      other.creatorDP == creatorDP &&
      other.isRoom == isRoom;
  }

  @override
  int get hashCode {
    return isRead.hashCode ^
      lastMessage.hashCode ^
      peerUUID.hashCode ^
      chatDP.hashCode ^
      roomID.hashCode ^
      chatName.hashCode ^
      timeStamp.hashCode ^
      chatCreator.hashCode ^
      creatorDP.hashCode ^
      isRoom.hashCode;
  }
}
