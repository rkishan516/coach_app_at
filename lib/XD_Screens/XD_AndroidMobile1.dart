import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class XD_AndroidMobile1 extends StatelessWidget {
  XD_AndroidMobile1({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(50.0, 117.0),
            child:
                // Adobe XD layer: 'GC' (shape)
                Container(
              width: 261.0,
              height: 261.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(''),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(51.0, 572.0),
            child: SizedBox(
              width: 258.0,
              child: Text(
                'BY\nVYSION TECHNOLOGIES',
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 20,
                  color: const Color(0xff707070),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
