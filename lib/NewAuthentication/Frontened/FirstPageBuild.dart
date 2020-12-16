import 'package:coach_app/NavigationOnOpen/WelComeNaviagtion.dart';
import 'package:flutter/material.dart';

class FirstPageBuild extends StatefulWidget {
  @override
  _FirstPageBuildState createState() => _FirstPageBuildState();
}

class _FirstPageBuildState extends State<FirstPageBuild> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.fromLTRB(28.0, 0.0, 28.0, 0.0),
      key: UniqueKey(),
      children: [
        InkWell(
          onTap: () {
            WelcomeNavigation.signInWithGoogleAndGetPage(context);
          },
          child: Container(
            padding: EdgeInsets.all(4.0),
            height: 40.0,
            width: 300.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: Color(
                  0xFF868A8F,
                ),
              ),
            ),
            child: Center(
              child: Text(
                'GET STARTED',
                style: TextStyle(color: Color(0xFF868A8F)),
              ),
            ),
          ),
        ),
        // SizedBox(
        //   height: 20.0,
        // ),
        // InkWell(
        //   onTap: () {
        //     TypeSelection.typeOfPage = "LoginPage";
        //     Provider.of<Counter>(context, listen: false)
        //         .increment(TypeSelection.typeOfPage);
        //   },
        //   child: Container(
        //     padding: EdgeInsets.all(4.0),
        //     height: 40.0,
        //     width: 300.0,
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(12.0),
        //         border: Border.all(color: Color(0xFFEF7334))),
        //     child: Center(
        //         child: Text(
        //       "I'LL USE MY EMAIL",
        //       style: TextStyle(color: Color(0xFFEF7334)),
        //     )),
        //   ),
        // ),
        // SizedBox(
        //   height: 50.0,
        // ),
        // GestureDetector(
        //   onTap: () {
        //     TypeSelection.typeOfPage = "SignUpPage";
        //     Provider.of<Counter>(context, listen: false)
        //         .increment(TypeSelection.typeOfPage);
        //   },
        //   child: Center(
        //     child: RichText(
        //       text: TextSpan(
        //           text: "Don't have an Account ? ",
        //           style: TextStyle(color: Color(0xFF868A8F), fontSize: 16),
        //           children: [
        //             TextSpan(
        //                 text: 'Signup',
        //                 style:
        //                     TextStyle(color: Colors.blueAccent, fontSize: 16))
        //           ]),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
