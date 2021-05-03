import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sanogano/pages/cookbook_page.dart';
import 'package:sanogano/pages/life_page.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  int pageIndex = 0;

// color(int index){
//     if (index==0){
//       setState(() {
//         pageIndex=12
//       });
//     };
//   }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 04,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                labelStyle: TextStyle(fontSize: 15),
                unselectedLabelColor: Colors.grey[600],
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                onTap: (value) {
                  setState(() {
                    pageIndex = value;
                  });
                },
                tabs: [
                  Tab(
                    text: "Accounts",
                  ),
                  Tab(
                    text: 'Hashtags',
                  ),
                  Tab(
                    text: 'Recipes',
                  ),
                  Tab(
                    text: 'Workouts',
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    LifePage(),
                    CookbookPage(),
                    LifePage(),
                    CookbookPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: new RotatedBox(
                      quarterTurns: 2,
                      child: SvgPicture.asset(
                        'assets/images/Forwardai.svg',
                        width: 20,
                        color: Colors.black,
                      ),
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 40,
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.top,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                          hintStyle: TextStyle(
                            height: 2.8,
                          ),
                          border: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              width: 2,
                              style: BorderStyle.none,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[200]),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[200]),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          errorBorder: InputBorder.none,
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Search"),
                    )),
              ],
            )),
      ),
    );
  }
}
