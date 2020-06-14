import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Authentication/welcome_page.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:coach_app/Dialogs/languageDialog.dart';
import 'package:coach_app/Dialogs/replaceSubAdmin.dart';
import 'package:coach_app/Drawer/my_institute.dart';
import 'package:coach_app/Drawer/privacyNPolicies.dart';
import 'package:coach_app/Profile/next.dart';
import 'package:coach_app/Student/course_page.dart';
import 'package:coach_app/adminCorner/noticeBoard.dart';
import 'package:coach_app/adminSection/branchRegister.dart';
import 'package:coach_app/adminSection/studentRequest.dart';
import 'package:coach_app/adminSection/teacherRegister.dart';
import 'package:coach_app/InstituteAdmin/branchList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';

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
          onDetailsPressed: (FireBaseAuth.instance.previlagelevel == 2)
              ? () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => TeacherProfilePage(
                        reference: FirebaseDatabase.instance.reference().child(
                            'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/teachers/${FireBaseAuth.instance.user.uid}'),
                      ),
                    ),
                  );
                }
              : null,
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
        if (FireBaseAuth.instance.previlagelevel == 1)
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                title: Text('My Courses'.tr()),
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
        ListTile(
          title: Text('Notice Board'.tr()),
          leading: Icon(Icons.notifications_active),
          onTap: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => NoticeBoard())),
        ),
        if (FireBaseAuth.instance.previlagelevel == 4)
          ListTile(
            title: Text(
              'All branches'.tr(),
            ),
            leading: Icon(Icons.business),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  CupertinoPageRoute(builder: (context) => BranchList()),
                  (route) => false);
            },
          )
        else
          Container(),
        if (FireBaseAuth.instance.previlagelevel >= 4)
          ListTile(
            title: Text(
              'Replace Sub Admin'.tr(),
            ),
            leading: Icon(Icons.business),
            onTap: () {
              showDialog(
                  context: context, builder: (context) => ReplaceSubAdmin());
            },
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
            ],
          )
        else
          Container(),
        ListTile(
          title: Text('Privacy & Policy'.tr()),
          leading: Icon(Icons.local_parking),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PrivacyPolicy()),
            );
          },
        ),
        ListTile(
          title: Text('Language'.tr()),
          leading: Icon(Icons.language),
          onTap: () {
            showDialog(
                context: context, builder: (context) => LanguageDialog());
          },
        ),
        ListTile(
          title: Text('Log Out'.tr()),
          leading: Icon(Icons.exit_to_app),
          onTap: () async {
            String res = await showDialog(
                context: context, builder: (context) => AreYouSure());
            if (res != 'Yes') {
              return;
            }
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

getAppBar(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return AppBar(
    backgroundColor: Color(0xffF36C24),
    title: StreamBuilder<Event>(
      stream: FirebaseDatabase.instance
          .reference()
          .child(
              'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/name')
          .onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data.snapshot.value,
            style: GoogleFonts.portLligatSans(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          );
        }
        return Container();
      },
    ),
    flexibleSpace: Stack(
      children: <Widget>[
        Transform.translate(
          offset: Offset(0, kToolbarHeight + 24.0),
          child: StreamBuilder<Event>(
            stream: FirebaseDatabase.instance
                .reference()
                .child('latestVersion')
                .onValue,
            builder: (context, snap) {
              if (snap.hasData) {
                return StreamBuilder<Event>(
                  stream: FirebaseDatabase.instance
                      .reference()
                      .child('publicNotice')
                      .onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.snapshot.value == '') {
                        return Container();
                      }
                      if (snap.data.snapshot.value >
                          int.parse(
                              FireBaseAuth.instance.packageInfo.buildNumber)) {
                        return Container(
                          height: 30.0,
                          width: size.width,
                          color: Colors.red,
                          child: Center(
                            child: Text(
                              snapshot.data.snapshot.value,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    } else {
                      return Container();
                    }
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ),
        Transform.translate(
          offset: Offset(size.width - 70.0, 56.0),
          child: FutureBuilder<dynamic>(
            future: FirebaseStorage.instance
                .ref()
                .child('/instituteLogo/${FireBaseAuth.instance.instituteid}')
                .getDownloadURL(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        45.0,
                      ),
                      border: Border.all(color: Colors.white, width: 3.0)),
                  child: CircleAvatar(
                    radius: 23.0,
                    backgroundImage: NetworkImage(
                      snapshot.data,
                    ),
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ],
    ),
    elevation: 0.0,
    iconTheme: IconThemeData.fallback().copyWith(color: Colors.white),
  );
}
