import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Groups extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset(
              "assets/icons/Back.ai.svg",
              height: 25,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          title: Text(
            "Groups",
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  MygroupsList(),
                  SizedBox(
                    height: 10,
                  ),
                  MygroupsList(),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.grey[200],
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(300),
                            border: Border.all(color: Colors.pink),
                            image: DecorationImage(
                                image: NetworkImage(
                                  "https://media.istockphoto.com/photos/macho-man-picture-id1202142519?k=6&m=1202142519&s=612x612&w=0&h=7aTJXgG-0REO-DurbvMr1X6JcrDeGi784Vdkr-esjEA=",
                                ),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    title: Text("Poetry Group",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w400)),
                    subtitle: Text("Private\n18 members",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        )),
                    trailing: SvgPicture.asset(
                      "assets/icons/Privacy.ai.svg",
                      height: 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MygroupsList(),
                  SizedBox(
                    height: 10,
                  ),
                  MygroupsList(),
                  SizedBox(
                    height: 10,
                  ),
                  MygroupsList(),
                  SizedBox(
                    height: 10,
                  ),
                  MygroupsList(),
                ],
              ),
            ],
          ),
        ));
  }
}

class MygroupsList extends StatefulWidget {
  @override
  _MygroupsListState createState() => _MygroupsListState();
}

class _MygroupsListState extends State<MygroupsList> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: Colors.grey[200],
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(300),
              border: Border.all(color: Colors.pink),
              image: DecorationImage(
                  image: NetworkImage(
                    "https://media.istockphoto.com/photos/macho-man-picture-id1202142519?k=6&m=1202142519&s=612x612&w=0&h=7aTJXgG-0REO-DurbvMr1X6JcrDeGi784Vdkr-esjEA=",
                  ),
                  fit: BoxFit.cover)),
        ),
      ),
      title: Text("Poetry Group",
          style: TextStyle(
              fontSize: 17, color: Colors.black, fontWeight: FontWeight.w400)),
      subtitle: Text("Public\n18 members",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          )),
      trailing: SvgPicture.asset(
        "assets/icons/Forward.ai.svg",
        height: 20,
        color: Colors.black,
      ),
    );
  }
}
