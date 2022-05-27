import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class StoryItem extends StatelessWidget {
  final String img;
  final String name;
  final bool flag;
  const StoryItem({Key key, this.img, this.name, this.flag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 08, left: 10.0),
      child: Column(
        children: <Widget>[
          Container(
            width: 66,
            height: 66,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54, width: 1.5),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/images/ibrahim.jpg'),
                        fit: BoxFit.cover)),
                child: flag == true
                    ? Align(
                        child: InkWell(
                          onTap: () {
                            //TODO : yahan par stories implement karni hain
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => StoryScreen()),
                            // );
                            print('hello');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SvgPicture.asset(
                                'assets/images/Addai.svg',
                                width: 07,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        alignment: Alignment.bottomRight,
                      )
                    : Container(),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          SizedBox(
            width: 50,
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
