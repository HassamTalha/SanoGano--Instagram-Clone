import 'package:flutter/material.dart';

class ConfirmNewPassword extends StatelessWidget {
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
              child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    "Create New Password",
                    style: TextStyle(
                        color: Color(0xFF943E3D),
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  // SizedBox(height: 10),
                  // Text(
                  //   """A code has been sent to your phone. Please enter that code here""",
                  //   textAlign: TextAlign.center,
                  // ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: newPassController,
                        textAlign: TextAlign.center ,
                        decoration: InputDecoration(
                            border: InputBorder.none,

                            hintText: "Type New Password"),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: confirmPassController,
                        textAlign: TextAlign.center ,
                        decoration: InputDecoration(
                            border: InputBorder.none,

                            hintText: "Confirm New Password"),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 20),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color:  Color(0xFF943E3D),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
