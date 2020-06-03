import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UploadDialog extends StatelessWidget {
  String warning;
  UploadDialog({@required this.warning});
  List<Widget> waitWidgets = [
    SpinKitRipple(
      color: Colors.orange,
    ),
    SpinKitDoubleBounce(
      color: Colors.orange,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
              top: 16.0,
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            margin: EdgeInsets.only(top: 66.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 16.0),
                waitWidgets[Random().nextInt(waitWidgets.length)],
                Text(
                  'Please Wait!',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  warning,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 24.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
