import 'package:flutter/material.dart';
import 'package:sanogano/constants.dart';


class Loading extends StatelessWidget {
  const Loading();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(kRedColor),
        ),
      ),
      color: Colors.white.withOpacity(0.8),
    );
  }
}
