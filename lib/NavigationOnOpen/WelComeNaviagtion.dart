import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Authentication/welcome_page.dart';
import 'package:coach_app/InstituteAdmin/branchList.dart';
import 'package:coach_app/InstituteAdmin/branchPage.dart';
import 'package:coach_app/InstituteAdmin/midAdminBranchList.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Student/WaitScreen.dart';
import 'package:coach_app/Student/all_course_view.dart';
import 'package:coach_app/Student/registration_form.dart';
import 'package:coach_app/courses/course_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:coach_app/Student/course_page.dart' as st_cp;
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeNavigation {
  static signInWithGoogleAndGetPage(BuildContext context) {
    print('WelcomeNavigation');
    FireBaseAuth.instance.signInWithGoogle(context).then(
      (value) async {
        if (value == null) {
          return;
        }
        SharedPreferences preferences = await SharedPreferences.getInstance();
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) {
            if (FireBaseAuth.instance.previlagelevel == 4) {
              FirebaseDatabase.instance
                  .reference()
                  .child("institute/${FireBaseAuth.instance.instituteid}")
                  .keepSynced(true);
              return BranchList();
            } else if (FireBaseAuth.instance.previlagelevel == 34) {
              return MidAdminBranchList();
            } else if (FireBaseAuth.instance.previlagelevel == 3) {
              FirebaseDatabase.instance
                  .reference()
                  .child(
                      "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}")
                  .keepSynced(true);
              return BranchPage();
            } else if (FireBaseAuth.instance.previlagelevel == 2) {
              return StreamBuilder<Event>(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child(
                        "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/teachers/${value.uid}")
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.snapshot.value == null) {
                      FireBaseAuth.instance.signoutWithGoogle();
                      return WelcomePage();
                    }
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
              FirebaseDatabase.instance
                      .reference()
                      .child(
                          'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/${FireBaseAuth.instance.user.uid}').keepSynced(true);
              return st_cp.CoursePage();
            } else {
              if (preferences.getString('insCode') == null ||
                  preferences.getString('branchCode') == null) {
                return RegistrationPage();
              }
              return StreamBuilder<Event>(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child(
                        "institute/${preferences.getString('insCode')}/branches/${preferences.getString('branchCode')}/students/${value.uid}/status")
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.snapshot.value == null) {
                      return RegistrationPage();
                    }
                    if (snapshot.data.snapshot.value == 'New Student') {
                      return AllCoursePage(
                          ref: FirebaseDatabase.instance.reference().child(
                              'institute/${preferences.getString('insCode')}/branches/${preferences.getString('branchCode')}'));
                    } else if (snapshot.data.snapshot.value ==
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
