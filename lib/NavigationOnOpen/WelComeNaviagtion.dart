import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Authentication/welcome_page.dart';
import 'package:coach_app/InstituteAdmin/branchList.dart';
import 'package:coach_app/InstituteAdmin/branchPage.dart';
import 'package:coach_app/InstituteAdmin/midAdminBranchList.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Provider/AdminProvider.dart';
import 'package:coach_app/Student/WaitScreen.dart';
import 'package:coach_app/Student/all_course_view.dart';
import 'package:coach_app/Student/course_page.dart' as st_cp;
import 'package:coach_app/Student/registration_form.dart';
import 'package:coach_app/courses/course_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeNavigation {
  static signInWithGoogleAndGetPage(BuildContext context) {
    print('WelcomeNavigation');
    AppwriteAuth.instance.signInWithGoogle(context).then(
      (value) async {
        if (value == null) {
          return;
        }
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) {
            if (AppwriteAuth.instance.previlagelevel == 4) {
              FirebaseDatabase.instance
                  .ref()
                  .child("institute/${AppwriteAuth.instance.instituteid}")
                  .keepSynced(true);
              return ChangeNotifierProvider(
                create: (context) => AdminProvider(),
                child: BranchList(),
              );
            } else if (AppwriteAuth.instance.previlagelevel == 34) {
              return MidAdminBranchList();
            } else if (AppwriteAuth.instance.previlagelevel == 3) {
              FirebaseDatabase.instance
                  .ref()
                  .child(
                      "institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}")
                  .keepSynced(true);
              return BranchPage();
            } else if (AppwriteAuth.instance.previlagelevel == 2) {
              return StreamBuilder<DatabaseEvent>(
                stream: FirebaseDatabase.instance
                    .ref()
                    .child(
                        "institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/teachers/${value.$id}")
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data?.snapshot.value == null) {
                      AppwriteAuth.instance.signoutWithGoogle();
                      return WelcomePage();
                    }
                    return CoursePage(
                      teacher: Teacher.fromJson(
                        snapshot.data!.snapshot.value as Map,
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            } else if (AppwriteAuth.instance.previlagelevel == 1) {
              FirebaseDatabase.instance
                  .ref()
                  .child(
                      'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/students/${AppwriteAuth.instance.user!.$id}')
                  .keepSynced(true);
              return st_cp.CoursePage();
            } else {
              if (AppwriteAuth.instance.prefs!.getString('insCode') == null ||
                  AppwriteAuth.instance.prefs!.getString('branchCode') ==
                      null) {
                return RegistrationPage();
              }
              return StreamBuilder<DatabaseEvent>(
                stream: FirebaseDatabase.instance
                    .ref()
                    .child(
                        "institute/${AppwriteAuth.instance.prefs!.getString('insCode')}/branches/${AppwriteAuth.instance.prefs!.getString('branchCode')}/students/${value.$id}/status")
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data?.snapshot.value == null) {
                      return RegistrationPage();
                    }
                    if (snapshot.data!.snapshot.value == 'New Student') {
                      return AllCoursePage(
                          ref: FirebaseDatabase.instance.ref().child(
                              'institute/${AppwriteAuth.instance.prefs!.getString('insCode')}/branches/${AppwriteAuth.instance.prefs!.getString('branchCode')}'));
                    } else if (snapshot.data!.snapshot.value ==
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
