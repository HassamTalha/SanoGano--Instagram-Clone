import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyBlockAccounts extends StatelessWidget {
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Blocked Accounts",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          BlockedAccountModel(),
          BlockedAccountModel(),
          BlockedAccountModel(),
          BlockedAccountModel(),
          BlockedAccountModel(),
        ],
      ),
    );
  }
}

class BlockedAccountModel extends StatelessWidget {
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
      title: Text("Spancer",
          style: TextStyle(
              fontSize: 17, color: Colors.black, fontWeight: FontWeight.w400)),
      subtitle: Text("spancer",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
          )),
      trailing: Container(
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[400]),
        ),
        child: Text(
          "Unblock",
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
        ),
      ),
    );
  }
}
