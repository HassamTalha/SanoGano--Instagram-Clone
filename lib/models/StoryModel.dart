
import 'package:cloud_firestore/cloud_firestore.dart';

class StoryModel {
  String userName;
  Timestamp date;
  String userImage;
  String media;
  String desc;
  int likes;
  String type;
  int comments;
  int postOrder;

  double aspectRatio;
  String duration;
  String thumbUrl;
  String coverUrl;

  StoryModel(
      {this.userName,
      this.date,
      this.userImage,
      this.media,
      this.desc,
      this.comments,
      this.likes,
      this.type,
      this.aspectRatio,
      this.duration,
      this.coverUrl,
      this.thumbUrl, this.postOrder});

  _fromJson(Map<String, dynamic> json) {
    aspectRatio = json["aspectRatio"];
    duration = json["duration"];
    thumbUrl = json["thumbUrl"];
    coverUrl = json["coverUrl"];
    postOrder = json['postOrder'];
    type = json["type"];
    userName = json['userName'];
    date = json['date'];
    userImage = json['userImage'];
    media = json['media'];
    desc = json['description'];
    likes = json['likes'];
    comments = json['comments'];
  }

  StoryModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    _fromJson(documentSnapshot.data());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['aspectRatio'] = aspectRatio;
    data['coverUrl'] = coverUrl;
    data['thumbUrl'] = thumbUrl;
    data['duration'] = duration;
    data['postOrder'] = postOrder;
    data['type'] = type;
    data['userName'] = userName;
    data['date'] = date;
    data['userImage'] = userImage;
    data['media'] = media;
    data['description'] = desc;
    data['likes'] = likes;
    data['comments'] = comments;

    return data;
  }
}
