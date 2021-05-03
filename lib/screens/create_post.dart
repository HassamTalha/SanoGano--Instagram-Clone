import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sanogano/constant/cookbook_json.dart';
import 'package:sanogano/constant/life_json.dart';
import 'package:sanogano/widgets/player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sanogano/apis/encoding_provider.dart';
import 'package:sanogano/apis/firebase_provider.dart';
import 'package:sanogano/models/video_info.dart';
import 'package:sanogano/screens/camera/camera_screen.dart';
import 'package:sanogano/utilities/show_error_dialog.dart';
import 'package:path/path.dart' as p;
import 'package:video_player/video_player.dart';
import '../widgets/customBarItemPost.dart';
import './camera/recipeCameraScreen.dart';
import '../models/reipeDetails.dart';
import '../screens/camera/workoutCameraScreen.dart';
import '../models/workoutDetails.dart';
import '../views/workoutView.dart';
import '../views/recipeView.dart';

class CreatePost extends StatefulWidget {
  final File imageFile;
  final String filePath;
  final File videoFile;
  final File thumbnail;
  final int pageIndex;
  final RecipeDetails recipeDetails;
  final WorkoutDetails workoutDetails;

  final userId;

  const CreatePost({
    this.workoutDetails,
    this.pageIndex,
    this.recipeDetails,
    this.imageFile,
    Key key,
    this.filePath,
    this.userId,
    this.videoFile,
    this.thumbnail,
  }) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String _error;

  PageController contt = PageController(viewportFraction: 0.2, initialPage: 1);
  int selectedPage = 1;
  List<String> wid = ["Story", "Post", "Recipe", "Workout", "      "];
  List<CameraDescription> _cameras;
  // PageController _pageController = PageController();
  Future<Null> _getCameras() async {
    try {
      _cameras = await availableCameras();
    } on CameraException catch (_) {
      ShowErrorDialog.showAlertDialog(
          errorMessage: 'Cant get cameras!', context: context);
    }
  }

  @override
  void initState() {
    super.initState();
    _getCameras();
    if (widget.pageIndex == 2) {
      setState(() {
        selectedPage = 2;
      });
    }
    if (widget.pageIndex == 3) {
      setState(() {
        selectedPage = 3;
      });
    }
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    if (selectedPage == 1 || selectedPage == 0) {
      setState(() {
        setState(() {
          contt = PageController(viewportFraction: 0.2, initialPage: 1);
        });
      });
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: new RotatedBox(
                      quarterTurns: 2,
                      child: SvgPicture.asset(
                        'assets/images/Forwardai.svg',
                        width: 25,
                        color: Colors.black,
                      ),
                    )),
                Text(
                  'Create Post',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                  // fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    _takeVideo(widget.videoFile);
                  },
                  child: Text(
                    'Post',
                    style: TextStyle(
                        color: widget.filePath != null
                            ? Colors.black
                            : Colors.black45),
                  ),
                )
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 66,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/ibrahim.jpg'),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              Text(
                                'nTenseSpence',
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            maxLines: 024,
                            minLines: 02,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            decoration: new InputDecoration(
                              // contentPadding: EdgeInsets.only(bottom: 10),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: ' Whats up?',
                              hintStyle: TextStyle(
                                fontSize: 21.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    widget.filePath != null
                        ? Stack(
                            children: [
                              Container(
                                height: 389,
                                width: MediaQuery.of(context).size.width,
                                child: Image.file(
                                  widget.imageFile,
                                  fit: BoxFit.cover,
                                ),
                                // child: Image.asset(
                                //   'assets/images/appbar.png',
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        final String rand =
                                            '${new Random().nextInt(10000)}';
                                        final imageName = 'image$rand';
                                        print(
                                            'object-----------------------------------------------');

                                        print(widget.imageFile.path);
                                        String fileName =
                                            (widget.imageFile.path);
                                        StorageReference firebaseStorageRef =
                                            FirebaseStorage.instance
                                                .ref()
                                                .child(imageName);
                                        StorageUploadTask uploadTask =
                                            firebaseStorageRef
                                                .putFile(widget.imageFile);
                                        StorageTaskSnapshot taskSnapshot =
                                            await uploadTask.onComplete;
                                        taskSnapshot.ref
                                            .getDownloadURL()
                                            .then((value) {
                                          print("Done: $value");
                                          Firestore.instance
                                              .collection(
                                                  "users/${widget.userId}/images")
                                              .document()
                                              .setData({"DownloadUrl": value});
                                        });

                                        // var p;
                                        // await ImageDownloader.downloadImage(imageFile.path)
                                        //     .then((value) {
                                        //   p = value;
                                        //   print('hello');

                                        //   print(imageFile.path);
                                        //   // ignore: deprecated_member_use
                                        //   Scaffold.of(context).showSnackBar(SnackBar(
                                        //     content: Text('Wallpaper saved'),
                                        //     duration: Duration(seconds: 5),
                                        //   ));
                                        // });
                                        // GallerySaver.saveImage(imageFile.path)
                                        //     .then(( bool path) {
                                        //   print("hello");

                                        // });
                                      },
                                      child: SvgPicture.asset(
                                        "assets/icons/Save Picture.ai.svg",
                                        height: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      "assets/icons/X.ai.svg",
                                      height: 25,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        : Container(),
                    widget.videoFile != null
                        ? Stack(
                            children: <Widget>[
                              _error == null
                                  ? NetworkPlayerLifeCycle(
                                      widget.videoFile,
                                      (BuildContext context,
                                              VideoPlayerController
                                                  controller) =>
                                          AspectRatioVideo(controller),
                                    )
                                  : Center(
                                      child: Text(_error),
                                    ),
                              // Container(
                              //   padding: EdgeInsets.all(16.0),
                              //   child: IconButton(
                              //     icon: Icon(Icons.close, color: Colors.white),
                              //     onPressed: () => Navigator.pop(context),
                              //   ),
                              // ),
                            ],
                          )
                        // This trailing comma makes auto-formatting nicer for build methods.
                        : Container(),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              bottom: 00,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  color: Colors.white,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return Player(
                              //         video: video,
                              //       );
                              //     },
                              //   ),
                              // );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(08),
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/images/appbar.png',
                                  ),
                                ),
                              ),
                              width: 45,
                              height: 45,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CameraScreen(_cameras,
                                        userId: widget.userId)
                                    //  CreatePostScreen(
                                    //   imageFile: croppedImage,
                                    // ),
                                    ),
                              );
                            },
                            child: SvgPicture.asset(
                              'assets/icons/Camera.ai.svg',
                              height: 45,
                              width: 45,
                              color: Colors.black,
                            ),
                          ),
                          SvgPicture.asset('assets/icons/Tag.ai.svg',
                              height: 45, width: 45, color: Colors.black45),
                        ],
                      ),
                      SizedBox(height: 20),
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
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Center(
                                child: MyCustomBarItem(
                                    wid[index], index == selectedPage, () {
                                  contt.animateToPage(index,
                                      duration: Duration(milliseconds: 200),
                                      curve: Curves.ease);
                                }),
                              ),
                            );
                          },
                          itemCount: wid.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else if (selectedPage == 2 || widget.recipeDetails != null) {
      setState(() {
        contt = PageController(viewportFraction: 0.2, initialPage: 2);
      });
      return widget.recipeDetails != null
          ? Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: new RotatedBox(
                            quarterTurns: 2,
                            child: SvgPicture.asset(
                              'assets/images/Forwardai.svg',
                              width: 25,
                              color: Colors.black,
                            ),
                          )),
                      Text(
                        'Create Recipe Post',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                        // fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          _takeVideo(widget.videoFile);
                        },
                        child: Text(
                          'Post',
                          style: TextStyle(
                              color: widget.filePath != null
                                  ? Colors.black
                                  : Colors.black45),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height - 66,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/ibrahim.jpg'),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'nTenseSpence',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  maxLines: 024,
                                  minLines: 02,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.text,
                                  decoration: new InputDecoration(
                                    // contentPadding: EdgeInsets.only(bottom: 10),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintText: 'Whats up?',
                                    hintStyle: TextStyle(
                                      fontSize: 21.0,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => RecipeView(
                                              recipeDetails:
                                                  widget.recipeDetails)

                                          //  CreatePostScreen(
                                          //   imageFile: croppedImage,
                                          // ),
                                          ),
                                    );
                                  },
                                  child: Text(
                                    "Go to Recipe",
                                    style: TextStyle(
                                        fontSize: 21.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          widget.filePath != null
                              ? Stack(
                                  children: [
                                    Container(
                                      height: 389,
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.file(
                                        widget.imageFile,
                                        fit: BoxFit.cover,
                                      ),
                                      // child: Image.asset(
                                      //   'assets/images/appbar.png',
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              final String rand =
                                                  '${new Random().nextInt(10000)}';
                                              final imageName = 'image$rand';
                                              print(
                                                  'object-----------------------------------------------');

                                              print(widget.imageFile.path);
                                              String fileName =
                                                  (widget.imageFile.path);
                                              StorageReference
                                                  firebaseStorageRef =
                                                  FirebaseStorage.instance
                                                      .ref()
                                                      .child(imageName);
                                              StorageUploadTask uploadTask =
                                                  firebaseStorageRef.putFile(
                                                      widget.imageFile);
                                              StorageTaskSnapshot taskSnapshot =
                                                  await uploadTask.onComplete;
                                              taskSnapshot.ref
                                                  .getDownloadURL()
                                                  .then((value) {
                                                print("Done: $value");
                                                Firestore.instance
                                                    .collection(
                                                        "users/${widget.userId}/images")
                                                    .document()
                                                    .setData(
                                                        {"DownloadUrl": value});
                                              });

                                              // var p;
                                              // await ImageDownloader.downloadImage(imageFile.path)
                                              //     .then((value) {
                                              //   p = value;
                                              //   print('hello');

                                              //   print(imageFile.path);
                                              //   // ignore: deprecated_member_use
                                              //   Scaffold.of(context).showSnackBar(SnackBar(
                                              //     content: Text('Wallpaper saved'),
                                              //     duration: Duration(seconds: 5),
                                              //   ));
                                              // });
                                              // GallerySaver.saveImage(imageFile.path)
                                              //     .then(( bool path) {
                                              //   print("hello");

                                              // });
                                            },
                                            child: SvgPicture.asset(
                                              "assets/icons/Save Picture.ai.svg",
                                              height: 25,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SvgPicture.asset(
                                            "assets/icons/X.ai.svg",
                                            height: 25,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              : Container(),
                          widget.videoFile != null
                              ? Stack(
                                  children: <Widget>[
                                    _error == null
                                        ? NetworkPlayerLifeCycle(
                                            widget.videoFile,
                                            (BuildContext context,
                                                    VideoPlayerController
                                                        controller) =>
                                                AspectRatioVideo(controller),
                                          )
                                        : Center(
                                            child: Text(_error),
                                          ),
                                    // Container(
                                    //   padding: EdgeInsets.all(16.0),
                                    //   child: IconButton(
                                    //     icon: Icon(Icons.close, color: Colors.white),
                                    //     onPressed: () => Navigator.pop(context),
                                    //   ),
                                    // ),
                                  ],
                                )
                              // This trailing comma makes auto-formatting nicer for build methods.
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    bottom: 00,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        color: Colors.white,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) {
                                    //       return Player(
                                    //         video: video,
                                    //       );
                                    //     },
                                    //   ),
                                    // );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(08),
                                      ),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          'assets/images/appbar.png',
                                        ),
                                      ),
                                    ),
                                    width: 45,
                                    height: 45,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => CameraScreen(_cameras,
                                              userId: widget.userId)
                                          //  CreatePostScreen(
                                          //   imageFile: croppedImage,
                                          // ),
                                          ),
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    'assets/icons/Camera.ai.svg',
                                    height: 45,
                                    width: 45,
                                    color: Colors.black,
                                  ),
                                ),
                                SvgPicture.asset('assets/icons/Tag.ai.svg',
                                    height: 45,
                                    width: 45,
                                    color: Colors.black45),
                              ],
                            ),
                            SizedBox(height: 20),
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
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Center(
                                      child: MyCustomBarItem(
                                          wid[index], index == selectedPage,
                                          () {
                                        contt.animateToPage(index,
                                            duration:
                                                Duration(milliseconds: 200),
                                            curve: Curves.ease);
                                      }),
                                    ),
                                  );
                                },
                                itemCount: wid.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          : Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: new RotatedBox(
                            quarterTurns: 2,
                            child: SvgPicture.asset(
                              'assets/images/Forwardai.svg',
                              width: 25,
                              color: Colors.black,
                            ),
                          )),
                      Text(
                        'Select Recipe',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                        // fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => RecipeCameraScreen(
                                      _cameras,
                                    )),
                          );

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => CreateRecipePostPage()),
                          // );
                        },
                        child: SvgPicture.asset(
                          'assets/images/Addai.svg',
                          width: 25,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              body: Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 05.0, right: 05),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      GridView.count(
                        shrinkWrap: true,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.87,
                        crossAxisCount: 03,
                        children: List.generate(cookbook.length, (index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 05.0, right: 05),
                                child: Container(
                                  width: MediaQuery.of(context).size.height *
                                      0.160,
                                  height: MediaQuery.of(context).size.height *
                                      0.150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              cookbook[index]['image']),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              SizedBox(height: 05),
                              Text(
                                cookbook[index]['title'],
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 30,
                          color: Colors.white,
                          // width: double.infinity,
                          child: PageView.builder(
                            onPageChanged: (index) {
                              setState(() {
                                selectedPage = index;
                              });
                            },
                            controller: contt,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Center(
                                  child: MyCustomBarItem(
                                      wid[index], index == selectedPage, () {
                                    contt.animateToPage(index,
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.ease);
                                  }),
                                ),
                              );
                            },
                            itemCount: wid.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
    } else if (selectedPage == 3 || widget.workoutDetails != null) {
      setState(() {
        contt = PageController(viewportFraction: 0.2, initialPage: 3);
      });
      return widget.workoutDetails != null
          ? Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: new RotatedBox(
                            quarterTurns: 2,
                            child: SvgPicture.asset(
                              'assets/images/Forwardai.svg',
                              width: 25,
                              color: Colors.black,
                            ),
                          )),
                      Text(
                        'Create Workout Post',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                        // fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          _takeVideo(widget.videoFile);
                        },
                        child: Text(
                          'Post',
                          style: TextStyle(
                              color: widget.filePath != null
                                  ? Colors.black
                                  : Colors.black45),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height - 66,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/ibrahim.jpg'),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'nTenseSpence',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  maxLines: 024,
                                  minLines: 02,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.text,
                                  decoration: new InputDecoration(
                                    // contentPadding: EdgeInsets.only(bottom: 10),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintText: 'Whats up?',
                                    hintStyle: TextStyle(
                                      fontSize: 21.0,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => WorkoutView(
                                                workoutDetails:
                                                    widget.workoutDetails,
                                              )
                                          //  CreatePostScreen(
                                          //   imageFile: croppedImage,
                                          // ),
                                          ),
                                    );
                                  },
                                  child: Text(
                                    "Go to Workout",
                                    style: TextStyle(
                                        fontSize: 21.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          widget.filePath != null
                              ? Stack(
                                  children: [
                                    Container(
                                      height: 389,
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.file(
                                        widget.imageFile,
                                        fit: BoxFit.cover,
                                      ),
                                      // child: Image.asset(
                                      //   'assets/images/appbar.png',
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              final String rand =
                                                  '${new Random().nextInt(10000)}';
                                              final imageName = 'image$rand';
                                              print(
                                                  'object-----------------------------------------------');

                                              print(widget.imageFile.path);
                                              String fileName =
                                                  (widget.imageFile.path);
                                              StorageReference
                                                  firebaseStorageRef =
                                                  FirebaseStorage.instance
                                                      .ref()
                                                      .child(imageName);
                                              StorageUploadTask uploadTask =
                                                  firebaseStorageRef.putFile(
                                                      widget.imageFile);
                                              StorageTaskSnapshot taskSnapshot =
                                                  await uploadTask.onComplete;
                                              taskSnapshot.ref
                                                  .getDownloadURL()
                                                  .then((value) {
                                                print("Done: $value");
                                                Firestore.instance
                                                    .collection(
                                                        "users/${widget.userId}/images")
                                                    .document()
                                                    .setData(
                                                        {"DownloadUrl": value});
                                              });

                                              // var p;
                                              // await ImageDownloader.downloadImage(imageFile.path)
                                              //     .then((value) {
                                              //   p = value;
                                              //   print('hello');

                                              //   print(imageFile.path);
                                              //   // ignore: deprecated_member_use
                                              //   Scaffold.of(context).showSnackBar(SnackBar(
                                              //     content: Text('Wallpaper saved'),
                                              //     duration: Duration(seconds: 5),
                                              //   ));
                                              // });
                                              // GallerySaver.saveImage(imageFile.path)
                                              //     .then(( bool path) {
                                              //   print("hello");

                                              // });
                                            },
                                            child: SvgPicture.asset(
                                              "assets/icons/Save Picture.ai.svg",
                                              height: 25,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SvgPicture.asset(
                                            "assets/icons/X.ai.svg",
                                            height: 25,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              : Container(),
                          widget.videoFile != null
                              ? Stack(
                                  children: <Widget>[
                                    _error == null
                                        ? NetworkPlayerLifeCycle(
                                            widget.videoFile,
                                            (BuildContext context,
                                                    VideoPlayerController
                                                        controller) =>
                                                AspectRatioVideo(controller),
                                          )
                                        : Center(
                                            child: Text(_error),
                                          ),
                                    // Container(
                                    //   padding: EdgeInsets.all(16.0),
                                    //   child: IconButton(
                                    //     icon: Icon(Icons.close, color: Colors.white),
                                    //     onPressed: () => Navigator.pop(context),
                                    //   ),
                                    // ),
                                  ],
                                )
                              // This trailing comma makes auto-formatting nicer for build methods.
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    bottom: 00,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        color: Colors.white,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) {
                                    //       return Player(
                                    //         video: video,
                                    //       );
                                    //     },
                                    //   ),
                                    // );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(08),
                                      ),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          'assets/images/appbar.png',
                                        ),
                                      ),
                                    ),
                                    width: 45,
                                    height: 45,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => CameraScreen(_cameras,
                                              userId: widget.userId)
                                          //  CreatePostScreen(
                                          //   imageFile: croppedImage,
                                          // ),
                                          ),
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    'assets/icons/Camera.ai.svg',
                                    height: 45,
                                    width: 45,
                                    color: Colors.black,
                                  ),
                                ),
                                SvgPicture.asset('assets/icons/Tag.ai.svg',
                                    height: 45,
                                    width: 45,
                                    color: Colors.black45),
                              ],
                            ),
                            SizedBox(height: 20),
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
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Center(
                                      child: MyCustomBarItem(
                                          wid[index], index == selectedPage,
                                          () {
                                        contt.animateToPage(index,
                                            duration:
                                                Duration(milliseconds: 200),
                                            curve: Curves.ease);
                                      }),
                                    ),
                                  );
                                },
                                itemCount: wid.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          : Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: new RotatedBox(
                            quarterTurns: 2,
                            child: SvgPicture.asset(
                              'assets/images/Forwardai.svg',
                              width: 25,
                              color: Colors.black,
                            ),
                          )),
                      Text(
                        'Select Workout',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                        // fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => WorkoutCameraScreen(
                                      _cameras,
                                    )),
                          );

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => CreateRecipePostPage()),
                          // );
                        },
                        child: SvgPicture.asset(
                          'assets/images/Addai.svg',
                          width: 25,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              body: Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 05.0, right: 05),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      GridView.count(
                        shrinkWrap: true,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.87,
                        crossAxisCount: 03,
                        children: List.generate(cookbook.length, (index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 05.0, right: 05),
                                child: Container(
                                  width: MediaQuery.of(context).size.height *
                                      0.160,
                                  height: MediaQuery.of(context).size.height *
                                      0.150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      image: DecorationImage(
                                          image:
                                              AssetImage(life[index]['image']),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              SizedBox(height: 05),
                              Text(
                                cookbook[index]['title'],
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 30,
                          color: Colors.white,
                          // width: double.infinity,
                          child: PageView.builder(
                            onPageChanged: (index) {
                              setState(() {
                                selectedPage = index;
                              });
                            },
                            controller: contt,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Center(
                                  child: MyCustomBarItem(
                                      wid[index], index == selectedPage, () {
                                    contt.animateToPage(index,
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.ease);
                                  }),
                                ),
                              );
                            },
                            itemCount: wid.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
    }
  }

  //--------------Video Part-----------
  //
  final thumbWidth = 100;
  final thumbHeight = 150;
  VideoInfo video;
  bool _imagePickerActive = false;
  bool _processing = false;
  bool _canceled = false;
  double _progress = 0.0;
  int _videoDuration = 0;
  // String _processPhase = '';
  final bool _debugMode = false;
  void _onUploadProgress(event) {
    if (event.type == StorageTaskEventType.progress) {
      final double progress =
          event.snapshot.bytesTransferred / event.snapshot.totalByteCount;
      setState(() {
        _progress = progress;
      });
    }
  }

  Future<String> _uploadFile(filePath, folderName) async {
    final file = new File(filePath);
    final basename = p.basename(filePath);

    final StorageReference ref =
        FirebaseStorage.instance.ref().child(folderName).child(basename);
    StorageUploadTask uploadTask = ref.putFile(file);
    uploadTask.events.listen(_onUploadProgress);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String videoUrl = await taskSnapshot.ref.getDownloadURL();
    return videoUrl;
  }

  String getFileExtension(String fileName) {
    final exploded = fileName.split('.');
    return exploded[exploded.length - 1];
  }

  void _updatePlaylistUrls(File file, String videoName) {
    final lines = file.readAsLinesSync();
    var updatedLines = List<String>();

    for (final String line in lines) {
      var updatedLine = line;
      if (line.contains('.ts') || line.contains('.m3u8')) {
        updatedLine = '$videoName%2F$line?alt=media';
      }
      updatedLines.add(updatedLine);
    }
    final updatedContents =
        updatedLines.reduce((value, element) => value + '\n' + element);

    file.writeAsStringSync(updatedContents);
  }

  Future<String> _uploadHLSFiles(dirPath, videoName) async {
    final videosDir = Directory(dirPath);

    var playlistUrl = '';

    final files = videosDir.listSync();
    int i = 1;
    for (FileSystemEntity file in files) {
      final fileName = p.basename(file.path);
      final fileExtension = getFileExtension(fileName);
      if (fileExtension == 'm3u8') _updatePlaylistUrls(file, videoName);

      setState(() {
        // _processPhase = 'Uploading video file $i out of ${files.length}';
        _progress = 0.0;
      });

      final downloadUrl = await _uploadFile(file.path, videoName);

      if (fileName == 'master.m3u8') {
        playlistUrl = downloadUrl;
      }
      i++;
    }

    return playlistUrl;
  }

  Future<void> _processVideo(File rawVideoFile) async {
    final String rand = '${new Random().nextInt(10000)}';
    final videoName = 'video$rand';
    final Directory extDir = await getApplicationDocumentsDirectory();
    final outDirPath = '${extDir.path}/Videos/$videoName';
    final videosDir = new Directory(outDirPath);
    videosDir.createSync(recursive: true);

    final rawVideoPath = rawVideoFile.path;
    final info = await EncodingProvider.getMediaInformation(rawVideoPath);
    final aspectRatio = EncodingProvider.getAspectRatio(info);

    setState(() {
      // _processPhase = 'Generating thumbnail';
      _videoDuration = EncodingProvider.getDuration(info);
      _progress = 0.0;
    });
    String thumbFilePath;
    if (widget.thumbnail != null) {
      thumbFilePath = widget.thumbnail.path;
    } else {
      thumbFilePath = await EncodingProvider.getThumb(rawVideoPath, 400, 500);
    }

    setState(() {
      // _processPhase = 'Encoding video';
      _progress = 0.0;
    });

    final encodedFilesDir =
        await EncodingProvider.encodeHLS(rawVideoPath, outDirPath);

    setState(() {
      // _processPhase = 'Uploading thumbnail to firebase storage';
      _progress = 0.0;
    });
    final thumbUrl = await _uploadFile(thumbFilePath, 'thumbnail');
    final videoUrl = await _uploadHLSFiles(encodedFilesDir, videoName);

    final videoInfo = VideoInfo(
      videoUrl: videoUrl,
      thumbUrl: thumbUrl,
      coverUrl: thumbUrl,
      aspectRatio: aspectRatio,
      uploadedAt: DateTime.now().millisecondsSinceEpoch,
      videoName: videoName,
    );

    setState(() {
      video = videoInfo;
      _progress = 0.0;
    });

    await FirebaseProvider.saveVideo(videoInfo, widget.userId, context);

    setState(() {
      // _processPhase = '';
      _progress = 0.0;
      _processing = false;
    });
  }

  void _takeVideo(videoFile) async {
    if (_imagePickerActive) return;

    // _imagePickerActive = false;
    // videoFile = await ImagePicker.pickVideo(source: ImageSource.camera);
    // _imagePickerActive = false;

    if (videoFile == null) return;

    setState(() {
      _processing = true;
    });

    try {
      await _processVideo(videoFile);
    } catch (e) {
      print('${e.toString()}');
    } finally {
      setState(() {
        _processing = false;
      });
    }
  }
  //-------------------------------------
}
