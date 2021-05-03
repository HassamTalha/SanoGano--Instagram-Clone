// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class MyLogout extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // backgroundColor: Colors.grey,
//         appBar: AppBar(
//           centerTitle: true,
//           backgroundColor: Colors.white12,
//           elevation: 0,
//           leading: IconButton(
//             icon: SvgPicture.asset(
//               "assets/icons/Back.ai.svg",
//               height: 25,
//               color: Colors.black,
//             ),
//             onPressed: () {},
//           ),
//           title: Text(
//             "Logout",
//             style: TextStyle(
//                 fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
//           ),
//         ),
//         body: Stack(
//           children: [
//             // Column(
//             //   children: [
//             //     Row(
//             //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //       children: [
//             //         Text("Status"),
//             //         Text("64%"),
//             //       ],
//             //     ),
//             //     Container(
//             //       width: 250,
//             //       child: LinearProgressIndicator(),
//             //     )
//             //   ],
//             // ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 15),
//               child: Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10, right: 10),
//                   child: InkWell(
//                     onTap: () {
//                       showMessage(context);
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.5),
//                               spreadRadius: 2,
//                               offset: Offset(0, 2),
//                             )
//                           ],
//                           borderRadius: BorderRadius.circular(30),
//                           border: Border.all(color: Colors.white, width: 4),
//                           color: Colors.black),
//                       height: 50,
//                       width: MediaQuery.of(context).size.width,
//                       child: Center(
//                         child: Text(
//                           "Log out",
//                           style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ));
//   }

//   void showMessage(context) {
//     showCupertinoDialog(
//         context: context,
//         builder: (context) {
//           return CupertinoAlertDialog(
//             title: Text("Hassam Talha"),
//             content: Text("Are you sure you want to log out of Sano Gano?"),
//             actions: <Widget>[
//               CupertinoDialogAction(
//                 isDefaultAction: true,
//                 child: Text("Cancel"),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               CupertinoDialogAction(
//                 child: Text(
//                   "Log out",
//                   style: TextStyle(color: Colors.red),
//                 ),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               )
//             ],
//           );
//         });
//   }
// }
