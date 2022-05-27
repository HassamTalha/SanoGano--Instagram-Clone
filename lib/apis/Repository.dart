import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

enum MediaType { image, video, text }

class WhatsappStory {
  final MediaType mediaType;
  final String media;
  final double duration;
  final String caption;
  final int when;
  final Color color;

  WhatsappStory({
    this.mediaType,
    this.media,
    this.duration,
    this.caption,
    this.when,
    this.color,
  });
}



/// The repository fetches the data from the same directory from git.
/// This is just to demonstrate fetching from a remote (workflow).
class Repository {
  static MediaType _translateType(String type) {
    if (type == "Image") {
      return MediaType.image;
    }

    if (type == "Video") {
      return MediaType.video;
    }

    return MediaType.text;
  }

  static Future<List<WhatsappStory>> getWhatsappStories(String uid) async {
   print(" ------------------- DEBUG STATE --------------------");
   print(uid);

    final List < WhatsappStory > loadedList = [];
    

   QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("Stories").doc(uid).collection("MyStories").orderBy('postOrder', descending: true).get()
    .whenComplete(() {
      
      print("____________________________ QUERY COMPLETED ________________");
     
    })
    .catchError((err){
      debugPrint(err.toString());
    });
    
    snapshot.docs.forEach((f) => {
       
            loadedList.add(WhatsappStory(
                 mediaType : _translateType(f.data()["type"]),
   media : f.data()["media"],
  duration: double.parse(f.data()["duration"]),
   caption: f.data()["description"],
  when: f.data()["postOrder"],
  color:f.data()["type"] == "Image" ?  Colors.black: myColors[int.parse(f.data()["type"].toString().split('.')[0])],
            ))
        });
   
    // final response = await get(
    //     "https://raw.githubusercontent.com/blackmann/storyexample/master/lib/data/whatsapp.json");

    // final data = jsonDecode(utf8.decode(response.bodyBytes))['data'];

    // final res = data.map<WhatsappStory>((it) {
    //   return WhatsappStory(
    //       caption: it['caption'],
    //       media: it['media'],
    //       duration: double.parse(it['duration']),
    //       when: it['when'],
    //       mediaType: _translateType(it['mediaType']),
    //       color: it['color']);
    // }).toList();

    // return res;
    
    return loadedList;
  }

}