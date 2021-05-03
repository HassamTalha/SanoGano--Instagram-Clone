

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../models/video_info.dart';

class FirebaseProvider {
  static saveVideo(VideoInfo video, String id, BuildContext contex) async {
    await Firestore.instance.collection('users/$id/videos').document().setData({
      'videoUrl': video.videoUrl,
      'thumbUrl': video.thumbUrl,
      'coverUrl': video.coverUrl,
      'aspectRatio': video.aspectRatio,
      'uploadedAt': video.uploadedAt,
      'videoName': video.videoName,
    });
    // print("---------------------------------------------");
    // print('helloooooooooo');
    // Toast.show(
    //     getMessageFromErrorCode("Saving video metadata to cloud firestore"),
    //     contex);
  }

  static listenToVideos(callback, String id) async {
    print("-----------------------------");
    print(id);
    print("-----------------------------");
    Firestore.instance.collection('users/$id/videos').snapshots().listen((qs) {
      final videos = mapQueryToVideoInfo(qs);
      callback(videos);
    });
  }

  static mapQueryToVideoInfo(QuerySnapshot qs) {
    return qs.documents.map((DocumentSnapshot ds) {
      return VideoInfo(
        videoUrl: ds.data['videoUrl'],
        thumbUrl: ds.data['thumbUrl'],
        coverUrl: ds.data['coverUrl'],
        aspectRatio: ds.data['aspectRatio'],
        videoName: ds.data['videoName'],
        uploadedAt: ds.data['uploadedAt'],
      );
    }).toList();
  }
}
