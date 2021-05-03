// import 'dart:io';
// import 'dart:math';
// import 'package:camera/camera.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:toast/toast.dart';
// import 'package:transparent_image/transparent_image.dart';
// import '../../apis/encoding_provider.dart';
// import '../../apis/firebase_provider.dart';
// import '../../constants.dart';
// import '../../models/video_info.dart';
// import '../../widgets/player.dart';

// import 'package:path/path.dart' as p;

// import 'package:timeago/timeago.dart' as timeago;

// // ignore: must_be_immutable
// class VideoPage{
  

//   final thumbWidth = 100;
//   final thumbHeight = 150;
//   List<VideoInfo> _videos = <VideoInfo>[];
//   bool _imagePickerActive = false;
//   bool _processing = false;
//   bool _canceled = false;
//   double _progress = 0.0;
//   int _videoDuration = 0;
//   // String _processPhase = '';
//   final bool _debugMode = false;

//   // @override
//   // void initState() {
//   //   FirebaseProvider.listenToVideos((newVideos) {
//   //     setState(() {
//   //       _videos = newVideos;
//   //     });
//   //   }, widget.userId);

//   //   EncodingProvider.enableStatisticsCallback((int time,
//   //       int size,
//   //       double bitrate,
//   //       double speed,
//   //       int videoFrameNumber,
//   //       double videoQuality,
//   //       double videoFps) {
//   //     if (_canceled) return;

//   //     setState(() {
//   //       _progress = time / _videoDuration;
//   //     });
//   //   });

//   //   super.initState();
//   //   _takeVideo(widget.videoFile);
//   // }

//   void _onUploadProgress(event) {
//     if (event.type == StorageTaskEventType.progress) {
//       final double progress =
//           event.snapshot.bytesTransferred / event.snapshot.totalByteCount;
//       setState(() {
//         _progress = progress;
//       });
//     }
//   }

//   Future<String> _uploadFile(filePath, folderName) async {
//     final file = new File(filePath);
//     final basename = p.basename(filePath);

//     final StorageReference ref =
//         FirebaseStorage.instance.ref().child(folderName).child(basename);
//     StorageUploadTask uploadTask = ref.putFile(file);
//     uploadTask.events.listen(_onUploadProgress);
//     StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
//     String videoUrl = await taskSnapshot.ref.getDownloadURL();
//     return videoUrl;
//   }

//   String getFileExtension(String fileName) {
//     final exploded = fileName.split('.');
//     return exploded[exploded.length - 1];
//   }

//   void _updatePlaylistUrls(File file, String videoName) {
//     final lines = file.readAsLinesSync();
//     var updatedLines = List<String>();

//     for (final String line in lines) {
//       var updatedLine = line;
//       if (line.contains('.ts') || line.contains('.m3u8')) {
//         updatedLine = '$videoName%2F$line?alt=media';
//       }
//       updatedLines.add(updatedLine);
//     }
//     final updatedContents =
//         updatedLines.reduce((value, element) => value + '\n' + element);

//     file.writeAsStringSync(updatedContents);
//   }

//   Future<String> _uploadHLSFiles(dirPath, videoName) async {
//     final videosDir = Directory(dirPath);

//     var playlistUrl = '';

//     final files = videosDir.listSync();
//     int i = 1;
//     for (FileSystemEntity file in files) {
//       final fileName = p.basename(file.path);
//       final fileExtension = getFileExtension(fileName);
//       if (fileExtension == 'm3u8') _updatePlaylistUrls(file, videoName);

//       setState(() {
//         Toast.show(
//             getMessageFromErrorCode(
//                 "Uploading video file $i out of ${files.length}"),
//             context);
//         // _processPhase = 'Uploading video file $i out of ${files.length}';
//         _progress = 0.0;
//       });

//       final downloadUrl = await _uploadFile(file.path, videoName);

//       if (fileName == 'master.m3u8') {
//         playlistUrl = downloadUrl;
//       }
//       i++;
//     }

//     return playlistUrl;
//   }

//   Future<void> _processVideo(File rawVideoFile) async {
//     final String rand = '${new Random().nextInt(10000)}';
//     final videoName = 'video$rand';
//     final Directory extDir = await getApplicationDocumentsDirectory();
//     final outDirPath = '${extDir.path}/Videos/$videoName';
//     final videosDir = new Directory(outDirPath);
//     videosDir.createSync(recursive: true);

//     final rawVideoPath = rawVideoFile.path;
//     final info = await EncodingProvider.getMediaInformation(rawVideoPath);
//     final aspectRatio = EncodingProvider.getAspectRatio(info);

//     setState(() {
//       // _processPhase = 'Generating thumbnail';
//       _videoDuration = EncodingProvider.getDuration(info);
//       _progress = 0.0;
//     });

//     final thumbFilePath =
//         await EncodingProvider.getThumb(rawVideoPath, thumbWidth, thumbHeight);

//     setState(() {
//       // _processPhase = 'Encoding video';
//       _progress = 0.0;
//     });

//     final encodedFilesDir =
//         await EncodingProvider.encodeHLS(rawVideoPath, outDirPath);

//     setState(() {
//       // _processPhase = 'Uploading thumbnail to firebase storage';
//       _progress = 0.0;
//     });
//     final thumbUrl = await _uploadFile(thumbFilePath, 'thumbnail');
//     final videoUrl = await _uploadHLSFiles(encodedFilesDir, videoName);

//     final videoInfo = VideoInfo(
//       videoUrl: videoUrl,
//       thumbUrl: thumbUrl,
//       coverUrl: thumbUrl,
//       aspectRatio: aspectRatio,
//       uploadedAt: DateTime.now().millisecondsSinceEpoch,
//       videoName: videoName,
//     );

//     setState(() {
//       Toast.show(
//           getMessageFromErrorCode("Saving video metadata to cloud firestore"),
//           context);
//       _progress = 0.0;
//     });

//     await FirebaseProvider.saveVideo(videoInfo, widget.userId);

//     setState(() {
//       // _processPhase = '';
//       _progress = 0.0;
//       _processing = false;
//     });
//   }

//   void _takeVideo(videoFile) async {
//     if (_imagePickerActive) return;

//     // _imagePickerActive = false;
//     // videoFile = await ImagePicker.pickVideo(source: ImageSource.camera);
//     // _imagePickerActive = false;

//     if (videoFile == null) return;

//     setState(() {
//       _processing = true;
//     });

//     try {
//       await _processVideo(videoFile);
//     } catch (e) {
//       print('${e.toString()}');
//     } finally {
//       setState(() {
//         _processing = false;
//       });
//     }
//   }

//   // _getListView() {
//   //   return ListView.builder(
//   //       padding: const EdgeInsets.all(8),
//   //       itemCount: _videos.length,
//   //       itemBuilder: (BuildContext context, int index) {
//   //         final video = _videos[index];
//   //         return GestureDetector(
//   //           onTap: () {
//   //             Navigator.push(
//   //               context,
//   //               MaterialPageRoute(
//   //                 builder: (context) {
//   //                   return Player(
//   //                     video: video,
//   //                   );
//   //                 },
//   //               ),
//   //             );
//   //           },
//   //           child: Card(
//   //             child: new Container(
//   //               padding: new EdgeInsets.all(10.0),
//   //               child: Stack(
//   //                 children: <Widget>[
//   //                   Row(
//   //                     crossAxisAlignment: CrossAxisAlignment.start,
//   //                     children: <Widget>[
//   //                       Stack(
//   //                         children: <Widget>[
//   //                           Container(
//   //                             width: thumbWidth.toDouble(),
//   //                             height: thumbHeight.toDouble(),
//   //                             child: Center(child: CircularProgressIndicator()),
//   //                           ),
//   //                           ClipRRect(
//   //                             borderRadius: new BorderRadius.circular(8.0),
//   //                             child: FadeInImage.memoryNetwork(
//   //                               placeholder: kTransparentImage,
//   //                               image: video.thumbUrl,
//   //                             ),
//   //                           ),
//   //                         ],
//   //                       ),
//   //                       Expanded(
//   //                         child: Container(
//   //                           margin: new EdgeInsets.only(left: 20.0),
//   //                           child: Column(
//   //                             crossAxisAlignment: CrossAxisAlignment.start,
//   //                             mainAxisSize: MainAxisSize.max,
//   //                             children: <Widget>[
//   //                               Text("${video.videoName}"),
//   //                               Container(
//   //                                 margin: new EdgeInsets.only(top: 12.0),
//   //                                 child: Text(
//   //                                     'Uploaded ${timeago.format(new DateTime.fromMillisecondsSinceEpoch(video.uploadedAt))}'),
//   //                               ),
//   //                             ],
//   //                           ),
//   //                         ),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ],
//   //               ),
//   //             ),
//   //           ),
//   //         );
//   //       });
//   // }

//   // _getProgressBar() {
//   //   return Container(
//   //     padding: EdgeInsets.all(30.0),
//   //     child: Column(
//   //       crossAxisAlignment: CrossAxisAlignment.center,
//   //       mainAxisAlignment: MainAxisAlignment.center,
//   //       children: <Widget>[
//   //         Container(
//   //           margin: EdgeInsets.only(bottom: 30.0),
//   //           // child: Text(_processPhase),
//   //         ),
//   //         LinearProgressIndicator(
//   //           value: _progress,
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(widget.title),
// //       ),
// //       body: Center(child: _getListView()),
// //       // floatingActionButton: FloatingActionButton(
// //       //   child: _processing
// //       //       ? CircularProgressIndicator(
// //       //           valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
// //       //         )
// //       //       : Icon(Icons.add),
// //       // ),
// //     );
// //   }
// }
