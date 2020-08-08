import 'dart:async';

import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/FeeSection/StudentReport/PaymentType.dart';
import 'package:coach_app/FeeSection/StudentSection/installmentList.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/NavigationOnOpen/WelComeNaviagtion.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return InstallMentList(
                                                  ref: widget.ref,
                                                  courseID: widget.courseID,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Paid Offline',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Color(0xffF36C24),
                                      ),
                                    ),
                                  StreamBuilder<Event>(
                                      stream: widget.ref
                                          .parent()
                                          .parent()
                                          .child("accountId")
                                          .onValue,
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Container();
                                        }
                                        if (snapshot.data.snapshot.value ==
                                            null) {
                                          return Container();
                                        }
                                        return Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: FlatButton(
                                            color: Color(0xffF36C24),
                                            child: StreamBuilder<Event>(
                                                stream: widget.ref
                                                    .child('price')
                                                    .onValue,
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    price = snapshot
                                                        .data.snapshot.value;
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
                                              var value =
                                                  await SharedPreferences
                                                      .getInstance();
                                              if (FireBaseAuth
                                                      .instance.instituteid ==
                                                  null) {
                                                FireBaseAuth
                                                        .instance.instituteid =
                                                    value.get('insCode');
                                              }
                                              if (FireBaseAuth
                                                      .instance.branchid ==
                                                  null) {
                                                FireBaseAuth.instance.branchid =
                                                    value.get('branchCode');
                                              }

                                              await Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PaymentType(
                                                            courseId:
                                                                widget.courseID,
                                                            courseName:
                                                                widget.name,
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
                                                  academicYear: DateTime.now()
                                                          .year
                                                          .toString() +
                                                      '-' +
                                                      (DateTime.now().year + 1)
                                                          .toString(),
                                                  courseID: widget.courseID,
                                                  courseName: widget.name,
                                                  paymentType: "Online",
                                                  paymentToken:
                                                      "It's a free course for student"
                                                          .tr(),
                                                );
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        UploadDialog(
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
                                                    .update({
                                                  'status': 'Registered'
                                                });
                                                await Future.delayed(
                                                    Duration(seconds: 1));
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
                                                        (DateTime.now().year +
                                                                1)
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
                                                                'Registering'
                                                                    .tr()));
                                                widget.ref
                                                    .parent()
                                                    .parent()
                                                    .child(
                                                        'students/${FireBaseAuth.instance.user.uid}/course')
                                                    .child(widget.courseID)
                                                    .update(rCourse.toJson());
                                                try {
                                                  await widget.ref
                                                      .parent()
                                                      .parent()
                                                      .child(
                                                        '/students/${FireBaseAuth.instance.user.uid}/status',
                                                      )
                                                      .set('Registered');
                                                } catch (e) {} finally {
                                                  Navigator.of(context).pop();
                                                }
                                                await Future.delayed(
                                                    Duration(seconds: 1));
                                                WelcomeNavigation
                                                    .signInWithGoogleAndGetPage(
                                                        context);
                                              } else {
                                                Alert.instance.alert(context,
                                                    'Registration Failed'.tr());
                                              }
                                            },
                                          ),
                                        );
                                      }),
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
