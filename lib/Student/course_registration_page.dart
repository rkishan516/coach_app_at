import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:upi_pay/upi_pay.dart';

class CourseRegistrationPage extends StatefulWidget {
  DatabaseReference ref;
  CourseRegistrationPage({@required this.ref});
  @override
  _CourseRegistrationPageState createState() => _CourseRegistrationPageState();
}

class _CourseRegistrationPageState extends State<CourseRegistrationPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _globalKey,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2,
              )
            ],
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.orange, Colors.deepOrange],
            ),
          ),
          child: StreamBuilder<Event>(
            stream: widget.ref.onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Courses course = Courses.fromJson(snapshot.data.snapshot.value);
                List<String> teachers = List<String>();
                course.subjects?.forEach((subject) {
                  subject.mentor.forEach((mentor) {
                    teachers.add(mentor);
                  });
                });
                return ListView(
                  children: <Widget>[
                    Center(
                      child: Text(
                        course.name,
                        style: TextStyle(color: Colors.white, fontSize: 32.0),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      child: Container(
                        margin: EdgeInsets.all(20.0),
                        child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            Center(
                                child: Text(
                              'Course Description'.tr(),
                              style: TextStyle(fontSize: 22.0),
                            )),
                            SizedBox(height: 20.0),
                            Text(
                              course.description,
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 20.0),
                            Center(
                              child: Text(
                                'Mentors'.tr(),
                                style: TextStyle(fontSize: 22.0),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: teachers.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text(
                                    '${index + 1}. ${teachers[index]}',
                                    style: TextStyle(fontSize: 16.0),
                                  );
                                }),
                          ],
                        ),
                        width: size.width,
                        height: 400,
                        color: Colors.white,
                      ),
                    ),
                    Card(
                      child: FlatButton(
                        child:
                            Text('Buy Course @ Rs.'.tr() + ' ${course.price}'),
                        onPressed: () async {
                          if (course.price < 1) {
                            Course rCourse = Course(
                              academicYear: DateTime.now().year.toString() +
                                  '-' +
                                  (DateTime.now().year + 1).toString(),
                              courseID: course.id,
                              courseName: course.name,
                              paymentToken: "It's a free course for student",
                            );
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    UploadDialog(warning: 'Registering'));
                            await widget.ref
                                .parent()
                                .parent()
                                .child(
                                  'students/${FireBaseAuth.instance.user.uid}/course/${course.id}',
                                )
                                .set(rCourse.toJson());
                            await widget.ref
                                .parent()
                                .parent()
                                .child(
                                    '/students/${FireBaseAuth.instance.user.uid}/status')
                                .set('Registered');
                            Navigator.of(context).pop();
                            return;
                          }
                          String upi;
                          widget.ref.parent().parent().child('upiId').once().then((value){
                            upi = value.value;
                          });
                          UpiApplication application = await showDialog(
                            context: context,
                            child: Dialog(
                              child: Screen(),
                            ),
                          );
                          if (application == null) {
                            Alert.instance.alert(context,
                                'No application selected or available');
                            return;
                          }
                          UpiTransactionResponse txnResponse =
                              await UpiPay.initiateTransaction(
                            amount: "${course.price}.00",
                            app: application,
                            receiverName: "Kishan",
                            receiverUpiAddress: "rkishan516-1@okhdfcbank",
                            transactionRef:
                                '${course.name.hashCode}${course.hashCode}${FireBaseAuth.instance.user.uid.hashCode}',
                            transactionNote:
                                'You are purchaing the course ${course.name}.',
                          );
                          if (txnResponse.status ==
                              UpiTransactionStatus.success) {
                            Course rCourse = Course(
                                academicYear: DateTime.now().year.toString() +
                                    '-' +
                                    (DateTime.now().year + 1).toString(),
                                courseID: course.id,
                                courseName: course.name,
                                paymentToken: txnResponse.txnRef);
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    UploadDialog(warning: 'Registering'));
                            await widget.ref
                                .parent()
                                .parent()
                                .child(
                                    'students/${FireBaseAuth.instance.user.uid}/course')
                                .child(course.id)
                                .set(rCourse.toJson());
                            await widget.ref
                                .parent()
                                .parent()
                                .child(
                                  '/students/${FireBaseAuth.instance.user.uid}/status',
                                )
                                .set('Registered');
                            Navigator.of(context).pop();
                          } else {
                            Alert.instance
                                .alert(context, 'Registration Failed'.tr());
                          }
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return UploadDialog(warning: 'Fetching Details');
              }
            },
          ),
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
                      'Pay Using',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  FutureBuilder<List<ApplicationMeta>>(
                    future: _appsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Container();
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
