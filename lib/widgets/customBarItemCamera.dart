

import 'package:flutter/material.dart';

class MyCustomBarItem1 extends StatelessWidget {
  final bool isSelected;
  final String title;
  final VoidCallback _selectItemCallBack;
  MyCustomBarItem1(this.title, this.isSelected, this._selectItemCallBack);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _selectItemCallBack,
      child: Text(
        title,
        style: TextStyle(
            color: isSelected ? Colors.white : Colors.white54,
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }
}