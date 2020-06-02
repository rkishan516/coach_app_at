import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/InstituteAdmin/branchList.dart';
import 'package:coach_app/Models/model.dart';
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
              return StreamBuilder<Event>(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child(
                        'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/${value.uid}')
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return st_cp.CoursePage(
                        student:
                            Student.fromJson(snapshot.data.snapshot.value));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            } else {
              return RegistrationPage();
            }
          },
        ), (route) => false);
      },
    );
  }
}
