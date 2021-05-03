

import 'package:flutter/material.dart';

class MyCustomBarItem extends StatelessWidget {
  final bool isSelected;
  final String title;
  final VoidCallback _selectItemCallBack;
  MyCustomBarItem(this.title, this.isSelected, this._selectItemCallBack);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _selectItemCallBack,
      child: Text(
        title,
        style: TextStyle(
            color: isSelected ? Colors.black : Colors.black45,
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }
}