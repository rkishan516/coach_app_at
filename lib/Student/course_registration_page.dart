import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:upi_pay/upi_pay.dart';

class CourseRegistrationPage extends StatefulWidget {
  final Courses course;
  DatabaseReference ref;
  CourseRegistrationPage({@required this.course, @required this.ref});
  @override
  _CourseRegistrationPageState createState() => _CourseRegistrationPageState();
}

class _CourseRegistrationPageState extends State<CourseRegistrationPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<String> teachers = List<String>();
    widget.course.subjects?.forEach((subject) {
      subject.mentor.forEach((mentor) {
        teachers.add(mentor);
      });
    });
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
          child: ListView(
            children: <Widget>[
              Center(
                child: Text(
                  widget.course.name,
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
                        widget.course.description,
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
                      Text('Buy Course @ Rs.'.tr() + ' ${widget.course.price}'),
                  onPressed: () async {
                    UpiApplication data = await showDialog(
                        context: context,
                        child: Dialog(
                          child: Screen(),
                        ));
                    UpiTransactionResponse txnResponse =
                        await UpiPay.initiateTransaction(
                      amount: "${widget.course.price}.00",
                      app: data,
                      receiverName: "Kishan",
                      receiverUpiAddress: "rkishan516-1@okhdfcbank",
                      transactionRef:
                          '${widget.course.name.hashCode}${widget.course.hashCode}${FireBaseAuth.instance.user.uid.hashCode}',
                      merchantCode: '1032',
                      transactionNote:
                          'You are purchaing the course ${widget.course.name}.',
                    );
                    if (txnResponse.status == UpiTransactionStatus.failure) {
                      widget.ref
                          .child(
                              'students/${FireBaseAuth.instance.user.uid}/course')
                          .push()
                          .set({
                        "Academic Year": DateTime.now().year.toString() +
                            '-' +
                            (DateTime.now().year + 1).toString(),
                        "courseID": widget.course.id,
                        "courseName": widget.course.name,
                        "paymentToken": txnResponse.txnRef,
                      });
                      _globalKey.currentState.showSnackBar(SnackBar(
                          content: Text(
                        'Registration Successful'.tr(),
                        style: TextStyle(color: Colors.orange),
                      )));
                    } else {
                      _globalKey.currentState.showSnackBar(SnackBar(
                          content: Text(
                        'Registration Failed'.tr(),
                        style: TextStyle(color: Colors.orange),
                      )));
                    }
                  },
                ),
              ),
            ],
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
  bool _isUpiEditable = false;
  Future<List<ApplicationMeta>> _appsFuture;

  @override
  void initState() {
    super.initState();
    _appsFuture = UpiPay.getInstalledUpiApplications();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      childAspectRatio: 1.6,
                      physics: NeverScrollableScrollPhysics(),
                      children: snapshot.data
                          .map((it) => Material(
                                key: ObjectKey(it.upiApplication),
                                color: Colors.grey[200],
                                child: InkWell(
                                  onTap: () => Navigator.of(context)
                                      .pop(it.upiApplication),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
