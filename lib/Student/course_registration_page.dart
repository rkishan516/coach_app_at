import 'dart:async';

import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/NavigationOnOpen/WelComeNaviagtion.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:upi_pay/upi_pay.dart';

class CourseRegistrationPage extends StatefulWidget {
  DatabaseReference ref;
  String name;
  String courseID;
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
                    child: ListView(
                      children: <Widget>[
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: FlatButton(
                            color: Colors.orange,
                            child: StreamBuilder<Event>(
                                stream: widget.ref.child('price').onValue,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    price = snapshot.data.snapshot.value;
                                    return Text(
                                      'Buy Course @ Rs.'.tr() +
                                          ' ${snapshot.data.snapshot.value}',
                                      style: TextStyle(color: Colors.white),
                                    );
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                }),
                            onPressed: () async {
                              if (price == null) {
                                return;
                              }
                              if (price < 1) {
                                Course rCourse = Course(
                                  academicYear: DateTime.now().year.toString() +
                                      '-' +
                                      (DateTime.now().year + 1).toString(),
                                  courseID: widget.courseID,
                                  courseName: widget.name,
                                  paymentToken:
                                      "It's a free course for student".tr(),
                                );
                                showDialog(
                                    context: context,
                                    builder: (context) => UploadDialog(
                                        warning: 'Registering'.tr()));
                                await widget.ref
                                    .parent()
                                    .parent()
                                    .child(
                                      'students/${FireBaseAuth.instance.user.uid}/course/${widget.courseID}',
                                    )
                                    .set(rCourse.toJson());
                                await widget.ref
                                    .parent()
                                    .parent()
                                    .child(
                                        '/students/${FireBaseAuth.instance.user.uid}/status')
                                    .set('Registered');
                                await Future.delayed(Duration(seconds: 5));
                                WelcomeNavigation.signInWithGoogleAndGetPage(
                                    context);
                                return;
                              }
                              String upi;
                              widget.ref
                                  .parent()
                                  .parent()
                                  .child('upiId')
                                  .once()
                                  .then((value) {
                                upi = value.value;
                              });
                              UpiApplication application = await showDialog(
                                context: context,
                                child: Dialog(
                                  child: Screen(),
                                ),
                              );
                              if (application == null) {
                                Alert.instance.alert(
                                    context,
                                    'No application selected or available'
                                        .tr());
                                return;
                              }
                              UpiTransactionResponse txnResponse =
                                  await UpiPay.initiateTransaction(
                                amount: "$price.00",
                                app: application,
                                receiverName: upi.split('@')[0],
                                receiverUpiAddress: upi,
                                transactionRef:
                                    '${widget.name.hashCode}${widget.courseID.hashCode}${FireBaseAuth.instance.user.uid.hashCode}',
                                transactionNote:
                                    'You are purchaing the course ${widget.name}.',
                              );
                              if (txnResponse.status ==
                                  UpiTransactionStatus.success) {
                                Course rCourse = Course(
                                    academicYear: DateTime.now()
                                            .year
                                            .toString() +
                                        '-' +
                                        (DateTime.now().year + 1).toString(),
                                    courseID: widget.courseID,
                                    courseName: widget.name,
                                    paymentToken: txnResponse.txnRef);
                                showDialog(
                                    context: context,
                                    builder: (context) => UploadDialog(
                                        warning: 'Registering'.tr()));
                                await widget.ref
                                    .parent()
                                    .parent()
                                    .child(
                                        'students/${FireBaseAuth.instance.user.uid}/course')
                                    .child(widget.courseID)
                                    .set(rCourse.toJson());
                                await widget.ref
                                    .parent()
                                    .parent()
                                    .child(
                                      '/students/${FireBaseAuth.instance.user.uid}/status',
                                    )
                                    .set('Registered');
                                await Future.delayed(Duration(seconds: 5));
                                WelcomeNavigation.signInWithGoogleAndGetPage(
                                    context);
                              } else {
                                Alert.instance
                                    .alert(context, 'Registration Failed'.tr());
                              }
                            },
                          ),
                        ),
                      ],
                    ),
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

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  Future<List<ApplicationMeta>> _appsFuture;

  @override
  void initState() {
    super.initState();
    _appsFuture = UpiPay.getInstalledUpiApplications();
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
                  FutureBuilder<List<ApplicationMeta>>(
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
                                  key: ObjectKey(it.upiApplication),
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () => Navigator.of(context)
                                        .pop(it.upiApplication),
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
                                          child: Text(
                                            it.upiApplication.getAppName(),
                                          ),
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
