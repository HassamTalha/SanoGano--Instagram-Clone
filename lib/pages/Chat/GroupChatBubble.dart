import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sanogano/constants.dart';
import 'package:sanogano/widgets/full_photo.dart';

class GroupChatBubble extends StatefulWidget {
  final int index;
  final DocumentSnapshot document;
  final id;
  final peerAvatar;
  final listMessage;

  GroupChatBubble(
      {this.index, this.document, this.id, this.peerAvatar, this.listMessage});

  @override
  _GroupChatBubbleState createState() => _GroupChatBubbleState();
}

class _GroupChatBubbleState extends State<GroupChatBubble> {
  bool showDate = false;
  @override
  Widget build(BuildContext context) {
    print(widget.document.data()['idFrom'] == widget.id);
    return widget.document.data()['idFrom'] == widget.id
        ?
        // Right (my message)
        Row(
            children: <Widget>[
              widget.document.data()['type'] == 0
                  // Text
                  ? Container(
                      child: Text(
                        widget.document.data()['content'],
                        style: TextStyle(color: Colors.white),
                      ),
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                      width: 200.0,
                      decoration: BoxDecoration(
                          color: Color(0xFF2E3546),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(2.0),
                            bottomRight: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                          )),
                      margin: EdgeInsets.only(
                          bottom: isLastMessageRight(widget.index) ? 20.0 : 10.0,
                          right: 10.0),
                    )
                  : widget.document.data()['type'] == 1
                      // Image
                      ? Container(
                          child: TextButton(
                            child: Material(
                              child: CachedNetworkImage(
                                placeholder: (context, url) => Container(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).primaryColor),
                                  ),
                                  width: 200.0,
                                  height: 200.0,
                                  padding: EdgeInsets.all(70.0),
                                  decoration: BoxDecoration(
                                    color: kLightGreyColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Material(
                                  child: Image.asset(
                                    'images/img_not_available.jpeg',
                                    width: 200.0,
                                    height: 200.0,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                ),
                                imageUrl: widget.document.data()['content'],
                                width: 200.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              clipBehavior: Clip.hardEdge,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FullPhoto(
                                          url: widget.document.data()['content'])));
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                          ),
                          margin: EdgeInsets.only(
                              bottom: isLastMessageRight(widget.index) ? 20.0 : 10.0,
                              right: 10.0),
                        )
                      // Sticker
                      : Container(
                          child: Image.asset(
                            'assets/Stickers/${widget.document.data()['content']}.gif',
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                          margin: EdgeInsets.only(
                              bottom: isLastMessageRight(widget.index) ? 20.0 : 10.0,
                              right: 10.0),
                        ),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          )
        :
        // Left (peer message)
        InkWell(
           onTap: (){
                      setState(() {
                        showDate = !showDate;
                      });
                    },
                  child: Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                       Material(
                              child: widget.peerAvatar == "default"
                                  ? CircleAvatar(
                                      radius: 17,
                                      backgroundColor: Colors.grey[300],
                                      backgroundImage:
                                          AssetImage("assets/default_avatar.png"),
                                    )
                                  : CachedNetworkImage(
                                      placeholder: (context, url) => Container(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1.0,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Theme.of(context).primaryColor),
                                        ),
                                        width: 35.0,
                                        height: 35.0,
                                        padding: EdgeInsets.all(10.0),
                                      ),
                                      imageUrl: widget.peerAvatar,
                                      width: 35.0,
                                      height: 35.0,
                                      fit: BoxFit.cover,
                                    ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(18.0),
                              ),
                              clipBehavior: Clip.hardEdge,
                            )
                          ,
                      widget.document.data()['type'] == 0
                          ? Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text(widget.document["userName"], style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),),
                                  Text(
                                widget.document.data()['content'],
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                                ],
                              ),
                              padding:
                                  EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                              width: 200.0,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(2.0),
                                    topRight: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0),
                                  )),
                              margin: EdgeInsets.only(left: 10.0),
                            )
                          : widget.document.data()['type'] == 1
                              ? Container(
                                  child: TextButton(
                                    child: Material(
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) => Container(
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation<
                                                    Color>(
                                                Theme.of(context).primaryColor),
                                          ),
                                          width: 200.0,
                                          height: 200.0,
                                          padding: EdgeInsets.all(70.0),
                                          decoration: BoxDecoration(
                                            color: kLightGreyColor,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Material(
                                          child: Image.asset(
                                            'images/img_not_available.jpeg',
                                            width: 200.0,
                                            height: 200.0,
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8.0),
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                        ),
                                        imageUrl: widget.document.data()['content'],
                                        width: 200.0,
                                        height: 200.0,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8.0)),
                                      clipBehavior: Clip.hardEdge,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => FullPhoto(
                                                  url:
                                                      widget.document.data()['content'])));
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                  ),
                                  margin: EdgeInsets.only(left: 10.0),
                                )
                              : Container(
                                  child: Image.asset(
                                    'assets/Stickers/${widget.document.data()['content']}.gif',
                                    width: 100.0,
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                  ),
                                  margin: EdgeInsets.only(
                                      bottom:
                                          isLastMessageRight(widget.index) ? 20.0 : 10.0,
                                      right: 10.0),
                                ),
                    ],
                  ),

                  // Time
                  Visibility(
                    visible: showDate,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                        child: Text(
                          DateFormat('dd MMM kk:mm').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(widget.document.data()['timestamp']))),
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12.0,
                              fontStyle: FontStyle.italic),
                        ),
                        margin:
                            EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
                      )),
                  
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              margin: EdgeInsets.only(bottom: 10.0),
            ),
        );
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            widget.listMessage != null &&
            widget.listMessage[index - 1]['idFrom'] == widget.id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            widget.listMessage != null &&
            widget.listMessage[index - 1]['idFrom'] != widget.id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }
}
