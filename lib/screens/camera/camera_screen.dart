import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:video_trimmer/video_trimmer.dart';

import '../camera/videoTrimming.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:image_picker/image_picker.dart';

import 'package:path_provider/path_provider.dart';

import 'dart:async';
import 'dart:io';

import '../create_post.dart';

import 'video_page.dart';

import '../../widgets/customBarItemCamera.dart';

class CameraScreen extends StatefulWidget {
  final userId;
  final List<CameraDescription> cameras;
  CameraScreen(this.cameras, {this.userId});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  PageController contt = PageController(viewportFraction: 0.2);
  final Trimmer _trimmer = Trimmer();
//---------------------timmer------------------------------------------
  int seconds = 0, minutes = 0, hours = 0;
  Timer timer;
  bool active = false;
  void stop() {
    this.timer.cancel();
    setState(() {
      this.active = false;
    });
  }

  void reset() {
    if (timer != null) this.timer.cancel();
    setState(() {
      this.seconds = 0;
      this.minutes = 0;
      this.hours = 0;
      this.active = false;
    });
  }

  void increment() {
    setState(() {
      this.active = true;
    });
    Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = this.seconds + 1;
      int localMinutes = this.minutes;
      int localHours = this.hours;
      if (localSeconds > 60) {
        localMinutes++;
        if (localMinutes > 60) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        this.seconds = localSeconds;
        this.minutes = localMinutes;
        this.hours = localHours;
        this.timer = timer;
      });
    });
  }

//------------------------------------------------------------------------

//_______________________________________________
  XFile videoFile;
  XFile imageFile;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(); // Create instance.

  void showInSnackBar(String message) {
    // ignore: deprecated_member_use
    // _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }
  void onVideoRecordButtonPressed() {
    startVideoRecording().then((_) {
      if (mounted) setState(() {});
    });
  }

  void onStopButtonPressed() {
    stopVideoRecording().then((file) async {
      if (mounted) setState(() {});

      if (file != null) {
        showInSnackBar('Video recorded to ${file.path}');
        videoFile = file;
        File vFile = File(videoFile.path);
        // _startVideoPlayer();
        print(videoFile);
        if (videoFile != null) {
          await _trimmer.loadVideo(videoFile: vFile);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return TrimmerView(_trimmer, userId: widget.userId);
          }));
        }
        //---------------------------------
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (_) => VideoTrimmingPage(
        //             videoFile: vFile,
        //           )
        //       //  CreatePostScreen(
        //       //   imageFile: croppedImage,
        //       // ),
        //       ),
        // );

//----------------------

      }
    });
  }

  void onPauseButtonPressed() {
    pauseVideoRecording().then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Video recording paused');
    });
  }

  void onResumeButtonPressed() {
    resumeVideoRecording().then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Video recording resumed');
    });
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  Future<void> startVideoRecording() async {
    final CameraController cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return;
    }

    if (cameraController.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return;
    }

    try {
      await cameraController.startVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return;
    }
  }

  Future<XFile> stopVideoRecording() async {
    final CameraController cameraController = controller;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return null;
    }

    try {
      return cameraController.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  Future<void> pauseVideoRecording() async {
    final CameraController cameraController = controller;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return null;
    }

    try {
      await cameraController.pauseVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> resumeVideoRecording() async {
    final CameraController cameraController = controller;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return null;
    }

    try {
      await cameraController.resumeVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }
//______________________________________

  int selectedPage = 0;

  List<String> wid = [
    "Video",
    "Photo",
    "Square",
    
  ];

  final pageController = PageController();

  String imagePath;
  bool _toggleCamera = false;
  CameraController controller;
  final _picker = ImagePicker();
  bool checkButtonStatus = false;
  Widget stopButton() {
    return InkWell(
      onTap: () {
        this.stop();

        setState(() {
          checkButtonStatus = false;
          reset();
        });
        controller != null &&
                controller.value.isInitialized &&
                controller.value.isRecordingVideo
            ? onStopButtonPressed()
            // ignore: unnecessary_statements
            : null;
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(
                        Radius.circular(08),
                      ),
                    ),
                  ),
                ),
                height: 50,
                width: 50,
              ),
            )
            // child: Container(

            //   height: 05,
            //   width: 05,

            //   decoration: BoxDecoration(
            //     color: Colors.red,
            //     borderRadius: BorderRadius.all(
            //       Radius.circular(20),
            //     ),
            //   ),
            // ),
            ),
      ),
    );
  }

  @override
  void initState() {
    try {
      onCameraSelected(widget.cameras[0]);
    } catch (e) {
      print(e.toString());
    }

    super.initState();
    // initPlatformState();
  }

  @override
  Future<void> dispose() async {
    controller?.dispose();
    await _stopWatchTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cameras.isEmpty) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16.0),
        child: Text(
          'No Camera Found',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      );
    }

    if (!controller.value.isInitialized) {
      return Container();
    }
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Transform.scale(
              scale: controller.value.aspectRatio / deviceRatio,
              child: new AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: new CameraPreview(controller),
              ),
            ),
          ),
          Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.black),
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                  top: 18.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(
                          'assets/icons/Back.ai.svg',
                          width: 25,
                          color: Colors.white,
                        )),
                    SvgPicture.asset(
                      'assets/icons/Flash.ai.svg',
                      width: 25,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(
                  height: 70.0,
                ),
                checkButtonStatus == true
                    ? Container(
                        height: 30.0,
                        width: 90.0,
                        color: Colors.red,
                        // margin: const EdgeInsets.symmetric(vertical: 50.0),
                        child: Center(
                          child: Text(
                            ((this.hours >= 10)
                                    ? '${this.hours}'
                                    : '0${this.hours}') +
                                ':' +
                                ((this.minutes >= 10)
                                    ? '${this.minutes}'
                                    : '0${this.minutes}') +
                                ':' +
                                ((this.seconds >= 10)
                                    ? '${this.seconds}'
                                    : '0${this.seconds}'),
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 150.0,
                  padding: EdgeInsets.all(20.0),
                  color: Colors.black,
                  child: Column(
                    children: [
                      Container(
                          height: 30,
                          // width: double.infinity,
                          child: PageView.builder(
                            onPageChanged: (index) {
                              setState(() {
                                selectedPage = index;
                              });
                            },
                            controller: contt,
                            itemBuilder: (context, index) {
                              return MyCustomBarItem1(
                                  wid[index], index == selectedPage, () {
                                contt.animateToPage(index,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.ease);
                              });
                            },
                            itemCount: wid.length,
                          )),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            onTap: () {
                              if (selectedPage == 0) {
                                getGalleryVideo();
                              } else {
                                getGalleryImage();
                              }
                            },
                            // onTap: () {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (_) => VideoPage(
                            //               title: "Video Checking",
                            //             )
                            //         //  CreatePostScreen(
                            //         //   imageFile: croppedImage,
                            //         // ),
                            //         ),
                            //   );
                            //   print('hellp');
                            // },
                            child: Container(
                              padding: EdgeInsets.all(4.0),
                              child: Image.asset(
                                'assets/images/gallery_button.png',
                                color: Colors.grey[200],
                                width: 42.0,
                                height: 42.0,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Material(
                              color: Colors.transparent,
                              child: checkButtonStatus == false
                                  ? InkWell(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      onTap: () {
                                        if (selectedPage == 0 &&
                                            this.active == false) {
                                          this.increment();
                                          setState(() {
                                            checkButtonStatus = true;
                                          });
                                        }
                                        print(
                                            '--------------------------------------------------------------');
                                        selectedPage == 0
                                            ? controller != null &&
                                                    controller
                                                        .value.isInitialized &&
                                                    !controller
                                                        .value.isRecordingVideo
                                                ? onVideoRecordButtonPressed()
                                                // ignore: unnecessary_statements
                                                : null
                                            : _captureImage();
                                        print(
                                            '--------------------------------------------------------------');
                                        print(selectedPage);
                                      },
                                      child: Container(
                                        height: 55,
                                        width: 55,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Container(
                                              width: 50,
                                              height: 50,
                                              padding: EdgeInsets.all(4.0),
                                              decoration: BoxDecoration(
                                                  color: selectedPage == 0
                                                      ? Colors.red
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 01))),
                                        ),
                                      ),
                                    )
                                  : stopButton(),
                            ),
                          ),
                          InkWell(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            onTap: () {
                              if (!_toggleCamera) {
                                onCameraSelected(widget.cameras[1]);
                                setState(() {
                                  _toggleCamera = true;
                                });
                              } else {
                                onCameraSelected(widget.cameras[0]);
                                setState(
                                  () {
                                    _toggleCamera = false;
                                  },
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(4.0),
                              child: SvgPicture.asset(
                                'assets/icons/Flip Camera.ai.svg',
                                width: 42.0,
                                height: 42.0,
                                color: Colors.grey[200],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) await controller.dispose();
    controller =
        CameraController(cameraDescription, ResolutionPreset.ultraHigh);

    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showMessage('Camera Error: ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      showException(e);
    }

    if (mounted) setState(() {});
  }

  String timestamp() => new DateTime.now().millisecondsSinceEpoch.toString();

  void _captureImage() {
    takePicture().then((XFile file) {
      if (mounted) {
        setState(() {
          imagePath = file.path;
        });
        if (file != null) {
          showInSnackBar('Picture saved to ${file.path}');
          setCameraResult();
        }
      }
    });
  }

  void getGalleryImage() async {
    PickedFile pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
      setCameraResult();
    } else {
      print('No image selected.');
    }
  }

  void getGalleryVideo() async {
    PickedFile pickedFile = await _picker.getVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        videoFile = XFile(pickedFile.path);
      });
      print(videoFile);
      if (videoFile != null) {
        await _trimmer.loadVideo(
          videoFile: File(pickedFile.path),
        );
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return TrimmerView(_trimmer, userId: widget.userId);
        }));
      }
    } else {
      print('No image selected.');
    }
  }

  void setCameraResult() async {
    // File croppedImage = await _cropImage(File(imagePath));
    File croppedImage = File(imagePath);
    if (croppedImage == null) {
      return;
    }
    print(croppedImage);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => CreatePost(
                imageFile: croppedImage,
                filePath: imagePath,
                userId: widget.userId,
              )
          //  CreatePostScreen(
          //   imageFile: croppedImage,
          // ),
          ),
    );
  }

  Future<XFile> takePicture() async {
    if (!controller.value.isInitialized) {
      showMessage('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/InstaDarts/Images';
    await new Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      return null;
    }

    try {
      XFile file = await controller.takePicture();
      return file;
    } on CameraException catch (e) {
      showException(e);
      return null;
    }
  }

  // _cropImage(File imageFile) async {
  //   File croppedImage = await ImageCropper.cropImage(
  //     androidUiSettings: AndroidUiSettings(
  //       backgroundColor: Theme.of(context).backgroundColor,
  //       toolbarColor: Colors.white,
  //       toolbarWidgetColor: Theme.of(context).accentColor,
  //       toolbarTitle: 'Crop Photo',
  //       activeControlsWidgetColor: Colors.blue,
  //     ),
  //     sourcePath: imageFile.path,
  //     aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
  //   );
  //   return croppedImage;
  // }

  void showException(CameraException e) {
    logError(e.code, e.description);
    print('Error: ${e.code}\n${e.description}');
  }

  void showMessage(String message) {
    print(message);
  }

  void logError(String code, String message) =>
      print('Error: $code\nMessage: $message');
}

// ignore: must_be_immutable
