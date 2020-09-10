import 'package:flutter/material.dart';

class CountDot extends StatelessWidget {
  final int count;
  CountDot({@required this.count});

  @override
  Widget build(BuildContext context) {
    return count != 0
        ? Container(
            height: 21.0,
            width: 21.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
              color: Colors.red,
            ),
            child: Center(
              child: Text(
                count.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                ),
              ),
            ),
          )
        : SizedBox(
            width: 4.0,
          );
  }
}
