import 'package:coach_app/NavigationOnOpen/WelComeNaviagtion.dart';
import 'package:coach_app/Utils/SizeConfig.dart';
import 'package:coach_app/noInternet/instiute_register.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: -(sizeConfig.screenWidth * 130 / 360),
            top: -(sizeConfig.screenHeight * 86 / 640),
            child: Container(
              height: sizeConfig.screenWidth * 246 / 360,
              width: sizeConfig.screenWidth * 246 / 360,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffecedee),
              ),
            ),
          ),
          Positioned(
            left: (sizeConfig.screenWidth * 242 / 360),
            top: (sizeConfig.screenHeight * 204 / 640),
            child: Container(
              height: sizeConfig.screenWidth * 246 / 360,
              width: sizeConfig.screenWidth * 246 / 360,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xfffef4ef),
              ),
            ),
          ),
          Positioned(
            left: (sizeConfig.screenWidth * 202 / 360),
            top: (sizeConfig.screenHeight * 40 / 640),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => InstituteRegister(),
                  ),
                );
              },
              child: Container(
                height: sizeConfig.screenHeight * 25 / 640,
                width: sizeConfig.screenWidth * 170 / 360,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: Offset(0.0, 2.0),
                      spreadRadius: sizeConfig.screenWidth * 0.005556 / 2,
                      blurRadius: sizeConfig.screenWidth * 0.005556 / 2,
                    ),
                  ],
                  color: Color(0xfff36c24),
                ),
                child: Container(
                  child: Row(
                    children: [
                      SizedBox(width: sizeConfig.screenWidth * 10 / 360),
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: sizeConfig.screenWidth * 15 / 360,
                      ),
                      SizedBox(width: sizeConfig.screenWidth * 4 / 360),
                      Text(
                        'Register your Institute',
                        style: TextStyle(
                          fontSize: sizeConfig.screenWidth * 12 / 360,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: (sizeConfig.screenWidth * 100 / 360),
            right: (sizeConfig.screenWidth * 100 / 360),
            top: (sizeConfig.screenHeight * 136 / 640),
            child: Container(
              height: sizeConfig.screenHeight * 181 / 640,
              width: sizeConfig.screenWidth * 153 / 360,
              child: Image.asset('assets/images/logopng.png'),
            ),
          ),
          Positioned(
            bottom: (sizeConfig.screenHeight * 60 / 640),
            left: (sizeConfig.screenWidth * 36 / 360),
            right: (sizeConfig.screenWidth * 36 / 360),
            child: GestureDetector(
              onTap: () {
                WelcomeNavigation.signInWithGoogleAndGetPage(context);
              },
              child: Container(
                height: sizeConfig.screenHeight * 34 / 640,
                width: sizeConfig.screenWidth * 268 / 360,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(sizeConfig.screenWidth * 5 / 360),
                  color: Color(0xfff36c24),
                ),
                child: Center(
                  child: Container(
                      child: Text(
                    'Let\'s Get Started',
                    style: TextStyle(
                      fontSize: sizeConfig.screenWidth * 14 / 360,
                      color: Colors.white,
                    ),
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
