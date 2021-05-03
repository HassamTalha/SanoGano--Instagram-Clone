// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';


// class Profile extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 5,
//       initialIndex: 0,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           centerTitle: true,
//           backgroundColor: Colors.white,
//           elevation: 0,
//           leading: IconButton(
//             icon: SvgPicture.asset(
//               "assets/icons/Add.ai.svg",
//               height: 25,
//               color: Colors.black,
//             ),
//             onPressed: () {},
//           ),
//           title: Text(
//             "Spancer",
//             style: TextStyle(
//                 fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
//           ),
//           actions: [
//             IconButton(
//                 padding: EdgeInsets.only(right: 20),
//                 icon: SvgPicture.asset(
//                   "assets/icons/Settings.ai.svg",
//                   height: 25,
//                   color: Colors.black,
//                 ),
//                 onPressed: () {})
//           ],
//         ),
//         body: SingleChildScrollView(

//                   child: Container(
//             height: MediaQuery.of(context).size.height+150,
//             width: MediaQuery.of(context).size.width,
//             child: Column(
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height / 4 + 125,
//                   width: MediaQuery.of(context).size.width,
//                   // color: Colors.blue,
//                   child: Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       Column(
//                         children: [
//                           Container(
//                               height: MediaQuery.of(context).size.height / 8 + 40,
//                               width: MediaQuery.of(context).size.width,
//                               child: Image.network(
//                                 "https://media.istockphoto.com/photos/barber-cutting-hair-picture-id469827551?k=6&m=469827551&s=170667a&w=0&h=0DqXN8f3qofQbs_Z8RLs--SFlM0HALEqwwfVEuPoGI8=",
//                                 fit: BoxFit.cover,
//                               )),
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 50),
//                         child: Align(
//                           alignment: Alignment.center,
//                           child: Container(
//                             height: 150,
//                             width: 150,
//                             child: Stack(
//                               children: [
//                                 Center(
//                                   child: CircleAvatar(
//                                     radius:
//                                         MediaQuery.of(context).size.height / 16 +
//                                             25,
//                                     backgroundColor: Colors.grey[200],
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(300),
//                                           border: Border.all(color: Colors.black),
//                                           image: DecorationImage(
//                                               image: NetworkImage(
//                                                 "https://media.istockphoto.com/photos/macho-man-picture-id1202142519?k=6&m=1202142519&s=612x612&w=0&h=7aTJXgG-0REO-DurbvMr1X6JcrDeGi784Vdkr-esjEA=",
//                                               ),
//                                               fit: BoxFit.cover)),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height / 8 + 40,),
//                         child: Align(
//                           alignment: Alignment.bottomCenter,
//                           child: ColumnModel(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
               
//                 Text(
//                   "Spancer",
//                   style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   "Dont walk infront of me..i may not follow",
//                   style: TextStyle(color: Colors.grey[600]),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   "www.google.com",
//                   style: TextStyle(color: Colors.blue),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   "ESTEBLISHED DECEMBER,2020",
//                   style: TextStyle(fontWeight: FontWeight.w500),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 TabBar(
//                     labelStyle: TextStyle(fontSize: 13),
//                     unselectedLabelColor: Colors.grey[600],
//                     indicatorColor: Colors.black,
//                     labelColor: Colors.black,
//                     tabs: <Widget>[
//                       Tab(
//                         text: "All",
//                       ),
//                       Tab(
//                         text: "Media",
//                       ),
//                       Tab(
//                         text: "Reciepe",
//                       ),
//                       Tab(
//                         text: "Workout",
//                       ),
//                       Tab(
//                         text: "Tagged",
//                       ),
//                     ]),
//                 Expanded(
//                   child: TabBarView(children: <Widget>[
//                     MyAll(),
//                      MyAll(),
//                       MyAll(),
//                        MyAll(),
//                         MyAll(),
//                     // MyMedia(),
//                     // MyReciepe(),
//                     // MyWorkout(),
//                     // MyTagged(),
//                   ]),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ColumnModel extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 65, right: 65),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 children: [
//                   Center(
//                     child: Text(
//                       "100",
//                       style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Text("Followers",
//                       style: TextStyle(fontSize: 10, color: Colors.black),)
//                 ],
//               ),
//               Column(
//                 children: [
//                   Container(
                      
                      
//                       child: Center(
//                         child: Text(
//                           "20",
//                           style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
//                         ),
//                       )),
//                   Text("Followings",
//                       style: TextStyle(fontSize: 10, color: Colors.black),)
//                 ],
//               )
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 105, right: 105),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 children: [
//                   Container(
//                     height: 40,
//                     width: 40,
                    
//                     child: Image.asset(
//                       "assets/icons/See Groups-svg.png",
//                       color: Colors.black,
                     
//                     ),
//                   ),
//                   Text("Groups",
//                       style: TextStyle(fontSize: 10, color: Colors.black),)
//                 ],
//               ),
//               Column(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(6),
//                     height: 40,
//                     width: 40,
                   
//                     child: SvgPicture.asset(
//                       "assets/icons/Save.ai.svg",
//                       height: 1,
//                       color: Colors.black,
//                     ),
//                   ),
//                   Text("Save",
//                       style: TextStyle(fontSize: 10, color: Colors.black),)
//                 ],
//               )
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 155, right: 155),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(6),
//                     height: 40,
//                     width: 40,
                   
//                     child: SvgPicture.asset(
//                       "assets/icons/Cookbook.ai.svg",
//                       height: 2,
//                       color: Colors.black,
//                     ),
//                   ),
//                   Text("Cookbook",
//                       style: TextStyle(fontSize: 10, color: Colors.black),)
//                 ],
//               ),
//               Column(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(6),
//                     height: 40,
//                     width: 40,
                   
//                     child: SvgPicture.asset(
//                       "assets/icons/Gym.ai.svg",
//                       height: 4,
//                       color: Colors.black,
//                     ),
//                   ),
//                   Text("Gym",
//                       style: TextStyle(fontSize: 10, color: Colors.black),)
//                 ],
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
