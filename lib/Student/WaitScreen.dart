import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Utils/Colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WaitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: GuruCoolLightColor.backgroundShade,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2,
                )
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [GuruCoolLightColor.whiteColor, Color(0xffF36C24)])),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'You will get admission in your digital institute as soon as administrator permits you',
                      style: TextStyle(
                          color: GuruCoolLightColor.whiteColor, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (FireBaseAuth.instance.instituteid != null &&
                          FireBaseAuth.instance.branchid != null)
                        FirebaseDatabase.instance
                            .reference()
                            .child(
                                'instiute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/${FireBaseAuth.instance.user.uid}/status')
                            .set("New Student");
                      FireBaseAuth.instance.signoutWithGoogle();
                      // Navigator.of(context).pushAndRemoveUntil(
                      //     MaterialPageRoute(
                      //         builder: (context) => NewWelcomePage()),
                      //     (route) => false);
                    },
                    child: Text(
                      'Withdraw Request',
                      style: TextStyle(color: GuruCoolLightColor.whiteColor),
                    ),
                    color: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
