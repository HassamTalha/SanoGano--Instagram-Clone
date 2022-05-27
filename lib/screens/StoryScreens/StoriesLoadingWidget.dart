import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StoriesLoadingWidget extends StatelessWidget {
  const StoriesLoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 6),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        enabled: true,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.13,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) {
              return Expanded(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    height: MediaQuery.of(context).size.width * 0.2,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(300),
                        color: Colors.grey[700]),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
