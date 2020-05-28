import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Student/course_page.dart' as st_cp;
import 'package:coach_app/Student/registration_form.dart';
import 'package:coach_app/adminSection/adminCoursePage.dart';
import 'package:coach_app/courses/course_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'C',
          style: GoogleFonts.portLligatSans(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: 'oa',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'ch',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _skey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _skey,
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 5),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff519ddb), Color(0xff54d179)])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _title(),
            SignInButton(
              Buttons.Google,
              text: 'Sign In With Google'.tr(),
              onPressed: () {
                FireBaseAuth.instance.signInWithGoogle().then(
                  (value) {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                      builder: (context) {
                        return FutureBuilder(
                          future: value.getIdToken(refresh: true),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.claims['admin']) {
                                return AdminCoursePage();
                              } else if (snapshot.data.claims['teacher']) {
                                return StreamBuilder(
                                  stream: FirebaseDatabase.instance
                                      .reference()
                                      .child('institute/0/branches/0/teachers')
                                      .orderByChild('email')
                                      .equalTo(value.email)
                                      .onValue,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return CoursePage(
                                        teacher: Teacher.fromJson(
                                            snapshot.data.value[0]),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                );
                              }else if(snapshot.data.claims['student']){
                                return st_cp.CoursePage(student: Student());
                              }else{
                                return RegistrationPage();
                              }
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        );
                      },
                    ), (route) => false);
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
