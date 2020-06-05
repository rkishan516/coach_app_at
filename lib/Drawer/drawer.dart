import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Authentication/welcome_page.dart';
import 'package:coach_app/Drawer/my_institute.dart';
import 'package:coach_app/Profile/next.dart';
import 'package:coach_app/Student/course_page.dart';
import 'package:coach_app/adminSection/branchRegister.dart';
import 'package:coach_app/adminSection/studentRequest.dart';
import 'package:coach_app/adminSection/teacherRegister.dart';
import 'package:coach_app/InstituteAdmin/branchList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

getDrawer(BuildContext context) {
  FirebaseUser user = FireBaseAuth.instance.user;
  return Drawer(
    child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(user.displayName),
          accountEmail: Text(
            user.email,
          ),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(user.photoUrl),
          ),
        ),
        ListTile(
          title: Text('My Institute'.tr()),
          leading: Icon(Icons.school),
          onTap: () async {
            DataSnapshot dataSnapshot = await FirebaseDatabase.instance
                .reference()
                .child('institute/${FireBaseAuth.instance.instituteid}/logo')
                .once();
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => MyInstitute(
                  dataSnapshot: dataSnapshot.value,
                ),
              ),
            );
          },
        ),
        if (FireBaseAuth.instance.previlagelevel == 2)
          ListTile(
            title: Text('My Profile'.tr()),
            leading: Icon(Icons.person),
            onTap: () async {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => TeacherProfilePage(
                    reference: FirebaseDatabase.instance.reference().child(
                        'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/teachers/${FireBaseAuth.instance.user.uid}'),
                  ),
                ),
              );
            },
          )
        else
          Container(),
        if (FireBaseAuth.instance.previlagelevel == 1)
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                title: Text('My Courses'),
                leading: Icon(Icons.book),
                onTap: () => Navigator.of(context).pushAndRemoveUntil(
                    CupertinoPageRoute(
                      builder: (context) => CoursePage(),
                    ),
                    (route) => false),
              )
            ],
          )
        else
          Container(),
        if (FireBaseAuth.instance.previlagelevel == 4)
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                title: Text(
                  'All brances',
                ),
                leading: Icon(Icons.business),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(builder: (context) => BranchList()),
                      (route) => false);
                },
              ),
              ListTile(
                title: Text('Add new branch'.tr()),
                leading: Icon(Icons.add_box),
                onTap: () {
                  return showCupertinoDialog(
                      context: context, builder: (context) => BranchRegister());
                },
              ),
            ],
          )
        else
          Container(),
        if (FireBaseAuth.instance.previlagelevel >= 3)
          ListView(
            controller: ScrollController(),
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                title: Text('Student Requests'.tr()),
                leading: Icon(Icons.verified_user),
                onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => StudentsRequests())),
              ),
              ListTile(
                title: Text('Add Teacher'.tr()),
                leading: Icon(Icons.person_add),
                onTap: () => showCupertinoDialog(
                    context: context, builder: (context) => TeacherRegister()),
              ),
            ],
          )
        else
          Container(),
        ListTile(
          title: Text('Log Out'.tr()),
          leading: Icon(Icons.exit_to_app),
          onTap: () {
            FireBaseAuth.instance.signoutWithGoogle().then(
              (value) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => WelcomePage()),
                    (route) => false);
              },
            );
          },
        )
      ],
    ),
  );
}
