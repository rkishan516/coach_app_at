import 'dart:async';

import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/FeeSection/StudentReport/PaymentType.dart';
import 'package:coach_app/FeeSection/StudentSection/installmentList.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/NavigationOnOpen/WelComeNaviagtion.dart';
import 'package:coach_app/Student/WaitScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upi_india/upi_india.dart';

class CourseRegistrationPage extends StatefulWidget {
  final DatabaseReference ref;
  final String name;
  final String courseID;
  CourseRegistrationPage(
      {@required this.ref, @required this.name, @required this.courseID});
  @override
  _CourseRegistrationPageState createState() => _CourseRegistrationPageState();
}

class _CourseRegistrationPageState extends State<CourseRegistrationPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    int price;
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text(
            'Course Description'.tr(),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          elevation: 0,
          iconTheme: IconThemeData.fallback().copyWith(color: Colors.white)),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<Event>(
          stream: widget.ref.child('description').onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      color: Colors.black87,
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              widget.name,
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            snapshot.data.snapshot.value,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    flex: 10,
                  ),
                  Expanded(
                    child: Card(
                        child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0, left: 8),
                          child: Text(
                            'This course includes'.tr(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.dvr,
                                size: 45,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  '24 hours on-demand video'.tr(),
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.question_answer,
                                size: 45,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Quizzes and PDFs'.tr(),
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.place,
                                size: 45,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Access from anywhere'.tr(),
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
                    flex: 10,
                  ),
                  Expanded(
                    child: StreamBuilder<Event>(
                        stream: widget.ref
                            .parent()
                            .parent()
                            .child(
                                '/students/${FireBaseAuth.instance.user.uid}/course/${widget.courseID}')
                            .onValue,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          }
                          bool isOld = snapshot.data.snapshot.value != null;
                          return ListView(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  if (!isOld)
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                      ),
                                      child: FlatButton(
                                        onPressed: () {
                                          //TODO: Remove till next todo
                                          widget.ref
                                              .parent()
                                              .parent()
                                              .child(
                                                  '/students/${FireBaseAuth.instance.user.uid}/class')
                                              .set(widget.courseID);
                                          widget.ref
                                              .parent()
                                              .parent()
                                              .child(
                                                  '/students/${FireBaseAuth.instance.user.uid}/status')
                                              .set('Existing Student');
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return WaitScreen();
                                              },
                                            ),
                                            (route) => false,
                                          );
                                          //TODO: remove till here and umcomment below navigator
                                          // Navigator.of(context).push(
                                          //   MaterialPageRoute(
                                          //     builder: (context) {
                                          //       return InstallMentList(
                                          //         ref: widget.ref,
                                          //         courseID: widget.courseID,
                                          //       );
                                          //     },
                                          //   ),
                                          // );
                                        },
                                        child: Text(
                                          'Paid Offline',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Color(0xffF36C24),
                                      ),
                                    ),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: FlatButton(
                                      color: Color(0xffF36C24),
                                      child: StreamBuilder<Event>(
                                          stream:
                                              widget.ref.child('price').onValue,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              price =
                                                  snapshot.data.snapshot.value;
                                              return Text(
                                                'Buy Course @ Rs.'.tr() +
                                                    ' ${snapshot.data.snapshot.value}',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              );
                                            } else {
                                              return CircularProgressIndicator();
                                            }
                                          }),
                                      onPressed: () async {
                                        bool isPaid;
                                        var value = await SharedPreferences
                                            .getInstance();
                                        FireBaseAuth.instance.instituteid =
                                            value.get('insCode');
                                        FireBaseAuth.instance.branchid =
                                            value.get('branchCode');

                                        await Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PaymentType(
                                                      courseId: widget.courseID,
                                                      courseName: widget.name,
                                                    )));
                                        await widget.ref
                                            .parent()
                                            .parent()
                                            .child(
                                                "students/${FireBaseAuth.instance.user.uid}/course/${widget.courseID}/fees/Installments/AllowedThrough")
                                            .once()
                                            .then((value) {
                                          if (value.value != null) {
                                            isPaid = true;
                                          } else {
                                            isPaid = false;
                                          }
                                        });
                                        if (isPaid == false) {
                                          return;
                                        }
                                        if (price == null) {
                                          return;
                                        }
                                        if (price < 1) {
                                          Course rCourse = Course(
                                            academicYear:
                                                DateTime.now().year.toString() +
                                                    '-' +
                                                    (DateTime.now().year + 1)
                                                        .toString(),
                                            courseID: widget.courseID,
                                            courseName: widget.name,
                                            paymentToken:
                                                "It's a free course for student"
                                                    .tr(),
                                          );
                                          showDialog(
                                              context: context,
                                              builder: (context) => UploadDialog(
                                                  warning:
                                                      'Registering, Please do not close'
                                                          .tr()));
                                          await widget.ref
                                              .parent()
                                              .parent()
                                              .child(
                                                'students/${FireBaseAuth.instance.user.uid}/course/${widget.courseID}',
                                              )
                                              .update(rCourse.toJson());
                                          await widget.ref
                                              .parent()
                                              .parent()
                                              .child(
                                                  '/students/${FireBaseAuth.instance.user.uid}')
                                              .update({'status': 'Registered'});
                                          await Future.delayed(
                                              Duration(seconds: 5));
                                          WelcomeNavigation
                                              .signInWithGoogleAndGetPage(
                                                  context);
                                          return;
                                        }
                                        if (isPaid) {
                                          Course rCourse = Course(
                                              academicYear: DateTime.now()
                                                      .year
                                                      .toString() +
                                                  '-' +
                                                  (DateTime.now().year + 1)
                                                      .toString(),
                                              courseID: widget.courseID,
                                              courseName: widget.name,
                                              paymentToken:
                                                  '${widget.name.hashCode}${widget.courseID.hashCode}${FireBaseAuth.instance.user.uid.hashCode}');
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  UploadDialog(
                                                      warning:
                                                          'Registering'.tr()));
                                          await widget.ref
                                              .parent()
                                              .parent()
                                              .child(
                                                  'students/${FireBaseAuth.instance.user.uid}/course')
                                              .child(widget.courseID)
                                              .update(rCourse.toJson());
                                          await widget.ref
                                              .parent()
                                              .parent()
                                              .child(
                                                '/students/${FireBaseAuth.instance.user.uid}/',
                                              )
                                              .update({'status': 'Registered'});
                                          await Future.delayed(
                                              Duration(seconds: 5));
                                          WelcomeNavigation
                                              .signInWithGoogleAndGetPage(
                                                  context);
                                        } else {
                                          Alert.instance.alert(context,
                                              'Registration Failed'.tr());
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                    flex: 2,
                  ),
                ],
              );
            } else {
              return UploadDialog(warning: 'Fetching'.tr());
            }
          },
        ),
      ),
    );
  }
}

// class Screen extends StatefulWidget {
//   @override
//   _ScreenState createState() => _ScreenState();
// }

// class _ScreenState extends State<Screen> {
//   Future<List<ApplicationMeta>> _appsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _appsFuture = UpiPay.getInstalledUpiApplications();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.width,
//         child: ListView(
//           children: <Widget>[
//             Container(
//               margin: EdgeInsets.only(top: 20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Container(
//                     margin: EdgeInsets.only(bottom: 12),
//                     child: Text(
//                       'Pay Using'.tr(),
//                       style: Theme.of(context).textTheme.caption,
//                     ),
//                   ),
//                   FutureBuilder<List<ApplicationMeta>>(
//                     future: _appsFuture,
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState != ConnectionState.done) {
//                         return UploadDialog(
//                           warning: 'Fetching Apps'.tr(),
//                         );
//                       }
//                       if (snapshot.data.length == 0) {
//                         Timer(Duration(seconds: 1), () {
//                           Navigator.of(context).pop();
//                         });
//                         return UploadDialog(
//                           warning: 'Fetching Apps'.tr(),
//                         );
//                       }

//                       return GridView.count(
//                         crossAxisCount: 2,
//                         shrinkWrap: true,
//                         mainAxisSpacing: 8,
//                         crossAxisSpacing: 8,
//                         childAspectRatio: 1,
//                         physics: NeverScrollableScrollPhysics(),
//                         children: snapshot.data
//                             .map((it) => Material(
//                                   key: ObjectKey(it.upiApplication),
//                                   color: Colors.white,
//                                   child: InkWell(
//                                     onTap: () => Navigator.of(context)
//                                         .pop(it.upiApplication),
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: <Widget>[
//                                         Image.memory(
//                                           it.icon,
//                                           width: 64,
//                                           height: 64,
//                                         ),
//                                         Container(
//                                           margin: EdgeInsets.only(top: 4),
//                                           child: Text(
//                                             it.upiApplication.getAppName(),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ))
//                             .toList(),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  Future<List<UpiApp>> _appsFuture;

  @override
  void initState() {
    super.initState();
    _appsFuture = UpiIndia().getAllUpiApps();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Pay Using'.tr(),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  FutureBuilder<List<UpiApp>>(
                    future: _appsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return UploadDialog(
                          warning: 'Fetching Apps'.tr(),
                        );
                      }
                      if (snapshot.data.length == 0) {
                        Timer(Duration(seconds: 1), () {
                          Navigator.of(context).pop();
                        });
                        return UploadDialog(
                          warning: 'Fetching Apps'.tr(),
                        );
                      }

                      return GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 1,
                        physics: NeverScrollableScrollPhysics(),
                        children: snapshot.data
                            .map((it) => Material(
                                  key: ObjectKey(it.app),
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () =>
                                        Navigator.of(context).pop(it.app),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.memory(
                                          it.icon,
                                          width: 64,
                                          height: 64,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 4),
                                          child: Text(it.name),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
