import 'package:flutter/material.dart';
import 'package:sanogano/pages/Chat/ChatRoomModel.dart';


class PeerDetails extends StatelessWidget {
  final ChatRoom userData;
  PeerDetails(this.userData);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 90,
              color: Theme.of(context).primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Container(
                  width: double.infinity,
                  height: 70,
                  child: ListTile(
                    leading: Hero(
                      tag: userData.chatDP,
                      child: CircleAvatar(
                        backgroundColor: Colors.red[200],
                        radius: 30,
                        backgroundImage: NetworkImage(userData.chatDP),
                      ),
                    ),
                    title: Hero(
                      tag: userData.chatDP + userData.chatName,
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          userData.chatName,
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    subtitle: Hero(
                      tag:
                          "${userData.chatDP}${userData.chatName}${userData.chatName}",
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          "last seen yesterday at 11:05 PM",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Padding(
              
              padding: EdgeInsets.only(left: 16, top: 15),
              child: Text("Info", style: TextStyle(fontWeight: FontWeight.bold),)),
            
              
          ],
        ));
  }
}
