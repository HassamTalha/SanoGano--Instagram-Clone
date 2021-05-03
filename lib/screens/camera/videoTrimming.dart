import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanogano/screens/camera/video_page.dart';
import 'package:sanogano/screens/create_post.dart';

import 'package:video_trimmer/video_trimmer.dart';


class TrimmerView extends StatefulWidget {
  final userId;
  final Trimmer _trimmer;
  TrimmerView(this._trimmer, {this.userId});
  @override
  _TrimmerViewState createState() => _TrimmerViewState();
}

class _TrimmerViewState extends State<TrimmerView> {
  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  bool _progressVisibility = false;

  Future<String> _saveVideo() async {
    File vFile;
    setState(() {
      _progressVisibility = true;
    });

    String _value;

    await widget._trimmer
        .saveTrimmedVideo(startValue: _startValue, endValue: _endValue)
        .then((value) {
      setState(() {
        _progressVisibility = false;
        _value = value;
        vFile = File(_value);
        print("========================$_value=============================");
      });
    });

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Select Thumbnail"),
        content: Text("You want to select thumbnail from the gallery or not?"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => CreatePost(
                          videoFile: vFile,
                          userId: widget.userId,
                        )
                    //  CreatePostScreen(
                    //   imageFile: croppedImage,
                    // ),
                    ),
              );
            },
            child: Text("No"),
          ),
          FlatButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              PickedFile pickedFile =
                  await ImagePicker().getImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CreatePost(
                            videoFile: vFile,
                            userId: widget.userId,
                            thumbnail: File(pickedFile.path),
                          )
                      //  CreatePostScreen(
                      //   imageFile: croppedImage,
                      // ),
                      ),
                );
              } else {
                print('No image selected.');
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Alert Dialog Box"),
                    content:
                        Text("Are you sure you don't want to select the image"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text("No"),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CreatePost(
                                      videoFile: vFile,
                                      userId: widget.userId,
                                    )
                                //  CreatePostScreen(
                                //   imageFile: croppedImage,
                                // ),
                                ),
                          );
                        },
                        child: Text("Yes"),
                      ),
                    ],
                  ),
                );
              }
            },
            child: Text("Yes"),
          ),
        ],
      ),
    );

    return _value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "       Video Trimmer",
          // style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.blue,
              size: 25,
            ),
            onPressed: _progressVisibility
                ? null
                : () async {
                    _saveVideo().then((outputPath) {
                      print('OUTPUT PATH: $outputPath');
                      final snackBar =
                          SnackBar(content: Text('Video Saved successfully'));
                      Scaffold.of(context).showSnackBar(snackBar);
                    });
                  },
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Builder(
        builder: (context) => Center(
          child: Container(
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Visibility(
                  visible: _progressVisibility,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.red,
                  ),
                ),
                // RaisedButton(
                //   onPressed: _progressVisibility
                //       ? null
                //       : () async {
                //           _saveVideo().then((outputPath) {
                //             print('OUTPUT PATH: $outputPath');
                //             final snackBar = SnackBar(
                //                 content: Text('Video Saved successfully'));
                //             Scaffold.of(context).showSnackBar(snackBar);
                //           });
                //         },
                //   child: Text("SAVE"),
                // ),
                Expanded(
                  child: VideoViewer(),
                ),
                Center(
                  child: TrimEditor(
                    thumbnailQuality: 100,
                    viewerHeight: 50.0,
                    circleSize: 02,
                    maxVideoLength: Duration(seconds: 10),
                    viewerWidth: MediaQuery.of(context).size.width,
                    onChangeStart: (value) {
                      _startValue = value;
                    },
                    onChangeEnd: (value) {
                      _endValue = value;
                    },
                    onChangePlaybackState: (value) {
                      setState(() {
                        _isPlaying = value;
                      });
                    },
                  ),
                ),
                FlatButton(
                  child: _isPlaying
                      ? Icon(
                          Icons.pause,
                          size: 80.0,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.play_arrow,
                          size: 80.0,
                          color: Colors.white,
                        ),
                  onPressed: () async {
                    bool playbackState =
                        await widget._trimmer.videPlaybackControl(
                      startValue: _startValue,
                      endValue: _endValue,
                    );
                    setState(() {
                      _isPlaying = playbackState;
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
