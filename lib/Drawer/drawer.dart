import 'package:auto_size_text/auto_size_text.dart';
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Authentication/welcome_page.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:coach_app/Dialogs/languageDialog.dart';
import 'package:coach_app/Dialogs/replaceSubAdmin.dart';
import 'package:coach_app/Drawer/my_institute.dart';
import 'package:coach_app/Drawer/privacyNPolicies.dart';
import 'package:coach_app/FeeSection/CouponSection/CouponList.dart';
import 'package:coach_app/FeeSection/FeeReportPages/DueFeeReport.dart';
import 'package:coach_app/FeeSection/FeeStructure.dart';
import 'package:coach_app/Meeting/Calender.dart';
import 'package:coach_app/Meeting/StudentEvent.dart';
import 'package:coach_app/Profile/next.dart';
import 'package:coach_app/Profile/subAdminProfile.dart';
import 'package:coach_app/Student/all_course_view.dart';
import 'package:coach_app/Student/course_page.dart';
import 'package:coach_app/adminCorner/noticeBoard.dart';
import 'package:coach_app/adminSection/studentRequest.dart';
import 'package:coach_app/InstituteAdmin/branchList.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

getDrawer(BuildContext context) {
  FirebaseUser user = FireBaseAuth.instance.user;
  return GuruCoolDrawer(user: user);
}

class GuruCoolDrawer extends StatefulWidget {
  const GuruCoolDrawer({
    Key key,
    @required this.user,
  }) : super(key: key);

  final FirebaseUser user;

  @override
  _GuruCoolDrawerState createState() => _GuruCoolDrawerState();
}

class _GuruCoolDrawerState extends State<GuruCoolDrawer> {
  bool isExpandedSS = false, isExpandedFS = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(widget.user.displayName),
            accountEmail: Text(
              widget.user.email,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(widget.user.photoUrl),
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
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text('My Institute'.tr()),
                  leading: Icon(Icons.school),
                  trailing: IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () async {
                      var key;
                      await FirebaseDatabase.instance
                          .reference()
                          .child('/instituteList/')
                          .orderByValue()
                          .equalTo(FireBaseAuth.instance.instituteid)
                          .once()
                          .then((value) => key = value.value.keys.toList()[0]);
                      try {
                        final ByteData bytes =
                            await rootBundle.load('assets/images/logo.png');
                        await Share.file('Share The Institute', 'esys.jpg',
                            bytes.buffer.asUint8List(), 'logo/png',
                            text:
                                'Hello, Our digital institute is on GuruCool, Download GuruCool from Following link:\n\n https://play.google.com/store/apps/details?id=com.VysionTech.gurucool\n\n and register with our Institute Code: ${key}${FireBaseAuth.instance.branchid}');
                      } catch (e) {
                        print('error: $e');
                      }
                    },
                  ),
                  onTap: () async {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => MyInstitute(),
                      ),
                    );
                  },
                ),
                if (FireBaseAuth.instance.previlagelevel == 1)
                  ListTile(
                    title: Text('All Courses'.tr()),
                    leading: Icon(Icons.book),
                    onTap: () => Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(
                          builder: (context) => AllCoursePage(
                            ref: FirebaseDatabase.instance.reference().child(
                                '/institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}'),
                          ),
                        ),
                        (route) => false),
                  ),
                if (FireBaseAuth.instance.previlagelevel == 1)
                  ListTile(
                    title: Text('My Courses'.tr()),
                    leading: Icon(Icons.book),
                    onTap: () => Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(
                          builder: (context) => CoursePage(),
                        ),
                        (route) => false),
                  ),
                if (FireBaseAuth.instance.previlagelevel == 1)
                  ListTile(
                    title: Text('Fee Section'),
                    leading: Icon(Icons.attach_money),
                    onTap: () => Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(
                          builder: (context) => CoursePage(
                            isFromDrawer: true,
                          ),
                        ),
                        (route) => false),
                  ),
                ListTile(
                  title: Text('Admin Corner'.tr()),
                  leading: Icon(Icons.notifications_active),
                  onTap: () => Navigator.of(context).push(
                      CupertinoPageRoute(builder: (context) => NoticeBoard())),
                ),
                if (FireBaseAuth.instance.previlagelevel == 4)
                  ListTile(
                    title: Text(
                      'All branches'.tr(),
                    ),
                    leading: Icon(Icons.business),
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          CupertinoPageRoute(
                              builder: (context) => BranchList()),
                          (route) => false);
                    },
                  ),
                if (FireBaseAuth.instance.previlagelevel >= 4)
                  ExpansionTile(
                    title: Text(
                      'SubAdmin Section',
                    ),
                    leading: Icon(Icons.person),
                    onExpansionChanged: (val) {
                      setState(() {
                        isExpandedSS = !isExpandedSS;
                      });
                    },
                    backgroundColor: Colors.grey[200],
                    initiallyExpanded: false,
                    children: [
                      ListTile(
                        title: Text(
                          'Replace Sub Admin'.tr(),
                        ),
                        leading: Icon(Icons.business),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => ReplaceSubAdmin());
                        },
                      ),
                      ListTile(
                        title: Text(
                          'Sub Admin Profile',
                        ),
                        leading: Icon(Icons.person),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => SubAdminProfile());
                        },
                      ),
                    ],
                  ),
                if (FireBaseAuth.instance.previlagelevel != 4 &&
                    FireBaseAuth.instance.previlagelevel != 1)
                  ListTile(
                    title: Text('Show Meeting'),
                    leading: Icon(Icons.video_call),
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => StudentEvent(),
                        ),
                      );
                    },
                  ),
                if (FireBaseAuth.instance.previlagelevel >= 3)
                  ListView(
                    controller: ScrollController(),
                    shrinkWrap: true,
                    children: <Widget>[
                      ListTile(
                        title: Text('Arrange Meeting'),
                        leading: Icon(Icons.video_call),
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => Calender(),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        title: Text('Student Requests'.tr()),
                        leading: Icon(Icons.verified_user),
                        onTap: () => Navigator.of(context).push(
                            CupertinoPageRoute(
                                builder: (context) => StudentsRequests())),
                      ),
                      if (FireBaseAuth.instance.previlagelevel >= 3)
                        ExpansionTile(
                          title: Text(
                            'Fee Section',
                          ),
                          leading: Icon(MdiIcons.currencyInr),
                          onExpansionChanged: (val) {
                            setState(() {
                              isExpandedFS = !isExpandedFS;
                            });
                          },
                          backgroundColor: Colors.grey[200],
                          initiallyExpanded: false,
                          children: [
                            ListTile(
                              title: Text('Coupon List'),
                              leading: Icon(Icons.crop_landscape),
                              onTap: () async {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => CouponList(),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              title: Text('Due Fee Report'),
                              leading: Icon(Icons.crop_landscape),
                              onTap: () async {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => FeeReport(
                                      type: "Due Fee Report",
                                    ),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              title: Text('Payment Report'),
                              leading: Icon(Icons.crop_landscape),
                              onTap: () async {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => FeeReport(
                                      type: "Payment Report",
                                    ),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              title: Text('Discount Report'),
                              leading: Icon(Icons.crop_landscape),
                              onTap: () async {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => FeeReport(
                                      type: "Discount Report",
                                    ),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              title: Text('Fine Report'),
                              leading: Icon(Icons.crop_landscape),
                              onTap: () async {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => FeeReport(
                                      type: "Fine Report",
                                    ),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              title: Text('Paid Report'),
                              leading: Icon(Icons.crop_landscape),
                              onTap: () async {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => FeeReport(
                                      type: "Paid Report",
                                    ),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              title: Text('OneTime Paid Report'),
                              leading: Icon(Icons.crop_landscape),
                              onTap: () async {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => FeeReport(
                                      type: "OneTime Paid Report",
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
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
                        context: context,
                        builder: (context) => LanguageDialog());
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
                            MaterialPageRoute(
                                builder: (context) => WelcomePage()),
                            (route) => false);
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
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
          return AutoSizeText(
            snapshot.data.snapshot.value,
            maxLines: 2,
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
