import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/InstituteAdmin/branchList.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Student/WaitScreen.dart';
import 'package:coach_app/Student/all_course_view.dart';
import 'package:coach_app/Student/registration_form.dart';
import 'package:coach_app/adminSection/adminCoursePage.dart';
import 'package:coach_app/courses/course_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:coach_app/Student/course_page.dart' as st_cp;

class WelcomeNavigation {
  static signInWithGoogleAndGetPage(BuildContext context) {
    print('WelcomeNavigation');
    FireBaseAuth.instance.signInWithGoogle().then(
      (value) {
        if (value == null) {
          return;
        }
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) {
            if (FireBaseAuth.instance.previlagelevel == 4) {
              return BranchList();
            } else if (FireBaseAuth.instance.previlagelevel == 3) {
              return AdminCoursePage();
            } else if (FireBaseAuth.instance.previlagelevel == 2) {
              return StreamBuilder<Event>(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child(
                        "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/teachers/${value.uid}")
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CoursePage(
                      teacher: Teacher.fromJson(snapshot.data.snapshot.value),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            } else if (FireBaseAuth.instance.previlagelevel == 1) {
              return st_cp.CoursePage();
            } else {
              return StreamBuilder<Event>(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child(
                        'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/${value.uid}')
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if(snapshot.data.snapshot.value == null){
                      return RegistrationPage();
                    }
                    if (snapshot.data.snapshot.value['status'] ==
                        'New Student') {
                      return AllCoursePage(
                          ref: FirebaseDatabase.instance.reference().child(
                              'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}'));
                    } else if (snapshot.data.snapshot.value['status'] ==
                        'Existing Student') {
                      return WaitScreen();
                    }
                    return RegistrationPage();
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            }
          },
        ), (route) => false);
      },
    );
  }
}
