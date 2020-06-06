import 'package:flutter/material.dart';

class XD_Splashscreen extends StatelessWidget {
  XD_Splashscreen({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(70.0, 586.0),
            child: SizedBox(
              width: 220.0,
              child: Text(
                'BY\nVYSION TECHNOLOGIES',
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 17,
                  color: const Color(0xff707070),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(91.0, 214.0),
            child:
                // Adobe XD layer: 'gurucool3png' (shape)
                Container(
              width: 178.0,
              height: 178.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(''),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
