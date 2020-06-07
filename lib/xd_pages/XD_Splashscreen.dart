import 'package:flutter/material.dart';

class XD_Splashscreen extends StatelessWidget {
  XD_Splashscreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('assets/images/splash.jpeg'), context);
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
            offset: Offset(MediaQuery.of(context).size.width/2-128,MediaQuery.of(context).size.height/2-(128+64)),
            child:
                // Adobe XD layer: 'gurucool3png' (shape)
                Container(
              width: 256.0,
              height: 256.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/splash.jpeg'),
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
