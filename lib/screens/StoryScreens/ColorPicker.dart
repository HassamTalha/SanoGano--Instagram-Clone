
import 'package:flutter/material.dart';
import 'package:sanogano/constants.dart';

class ColorPicker extends StatefulWidget {
  final Function changedColor;
  ColorPicker({this.changedColor});
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
 
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: myColors.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              setState(() {
                
                selected = index;
               
              });
               widget.changedColor(myColors[index], index);
            },
                      child: Container(
               height: 30,
                width: 30,
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                color: Colors.white,
                  
                ),
                margin: EdgeInsets.only(right: 16),
              
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
               
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2),],
                  color: myColors[index],
                ),
                height:index == selected ? 25: 30,
                width: index == selected ? 25:30,
              ),
                          ],
                        ),
            ),
          );
        });
  }
}
