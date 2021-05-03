import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../createRecipe.dart';

class RecipeCameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  RecipeCameraScreen(this.cameras);

  @override
  _RecipeCameraScreenState createState() => _RecipeCameraScreenState();
}

class _RecipeCameraScreenState extends State<RecipeCameraScreen> {
  String imagePath;
  bool _toggleCamera = false;
  CameraController controller;
  final _picker = ImagePicker();
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

  void showMessage(String message) {
    print(message);
  }

  void showException(CameraException e) {
    logError(e.code, e.description);
    print('Error: ${e.code}\n${e.description}');
  }

  void logError(String code, String message) =>
      print('Error: $code\nMessage: $message');
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

  String timestamp() => new DateTime.now().millisecondsSinceEpoch.toString();
  void _captureImage() {
    takePicture().then((XFile file) {
      if (mounted) {
        setState(() {
          imagePath = file.path;
        });
        if (file != null) {
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
          builder: (_) => CreateRecipePostPage(
                image: croppedImage,
              )
          //  CreatePostScreen(
          //   imageFile: croppedImage,
          // ),
          ),
    );
  }

  @override
  Future<void> dispose() async {
    controller?.dispose();

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
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                
                Container(
                  width: double.infinity,
                  height: 150.0,
                  padding: EdgeInsets.only(left:20.0,right: 20.0,bottom: 10.0),
                  color: Colors.black,
                  child: Column(
                    children: [
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CreateRecipePostPage(
                                      check: true,
                                    )
                                //  CreatePostScreen(
                                //   imageFile: croppedImage,
                                // ),
                                ),
                          );
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(color: Colors.white,fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            onTap: () {
                              getGalleryImage();
                            },
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
                                child: InkWell(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  onTap: () {
                                    _captureImage();
                                    print(
                                        '--------------------------------------------------------------');
                                  },
                                  child: Container(
                                    height: 55,
                                    width: 55,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Container(
                                          width: 50,
                                          height: 50,
                                          padding: EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 01))),
                                    ),
                                  ),
                                )),
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
}
