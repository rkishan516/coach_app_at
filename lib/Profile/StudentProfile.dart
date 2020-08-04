import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/FeeSection/StudentSection/feeUpdate.dart';
import 'package:coach_app/FeeSection/ToggleButton.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Profile/student_performance.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class StudentProfile extends StatelessWidget {
  final Student student;
  final String keyS;
  StudentProfile({@required this.student, @required this.keyS});
  @override
  Widget build(BuildContext context) {
    var b = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: getAppBar(context),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.bottomRight,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.92,
              height: MediaQuery.of(context).size.height * 0.78,
              child: Card(
                margin: EdgeInsets.fromLTRB(
                    b * 0.063, h * 0.02, b * 0.063, h * 0.0068),
                color: Color.fromARGB(255, 255, 110, 40),
                elevation: 100,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: h * 0.028,
                    ),
                    Container(
                      height: h * 0.05,
                      padding:
                          EdgeInsets.only(left: b * 0.2125, right: b * 0.025),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(student.name,
                            textScaleFactor: 2,
                            textAlign: TextAlign.justify,
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    SizedBox(height: h * 0.01762),
                    Container(
                      height: h * 0.147,
                      width: b * 0.7,
                      child: Card(
                        color: Color.fromARGB(255, 255, 145, 72),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(width: b * 0.025),
                                Icon(
                                  Icons.local_post_office,
                                  color: Colors.black,
                                  size: b * 0.065,
                                ),
                                SizedBox(width: b * 0.033),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          student.email,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: b * 0.04,
                                          ),
                                        )),
                                  ],
                                )),
                              ],
                            ),
                            SizedBox(height: h * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(width: b * 0.0253),
                                Icon(
                                  Icons.call,
                                  color: Colors.black,
                                  size: b * 0.0637,
                                ),
                                SizedBox(width: b * 0.033),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                            student?.phoneNo ?? "Not Given",
                                            style: TextStyle(
                                                fontSize: b * 0.037688,
                                                color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: h * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(width: b * 0.0252),
                                Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                  size: b * 0.0654,
                                ),
                                SizedBox(width: b * 0.033),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(student.address,
                                            style: TextStyle(
                                                fontSize: b * 0.0377,
                                                color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.01355,
                    ),
                    if (student.course != null)
                      Container(
                        height: h * 0.361,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: student.course.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => StudentPerformance(
                                    uid: keyS,
                                    courseId: student.course[index].courseID,
                                  ),
                                ),
                              ),
                              onLongPress: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => FeeUpdate(
                                      courseID: student.course[index].courseID,
                                      keyS: keyS,
                                      ref: FirebaseDatabase.instance
                                          .reference()
                                          .child(
                                              'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${student.course[index].courseID}')),
                                ),
                              ),
                              child: Padding(
                                padding: new EdgeInsets.only(
                                    top: 5.0,
                                    left: 20.0,
                                    right: 20.0,
                                    bottom: 5.0),
                                child: Card(
                                  color: Color.fromARGB(255, 255, 145, 72),
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "Course : ${student.course[index].courseName}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "Academic Year : ${student.course[index].academicYear}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "Payment : ${student.course[index].paymentToken}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      ),
                                      ToggleButton(
                                        studentUid: keyS,
                                        courseId:
                                            student.course[index].courseID,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    SizedBox(height: h * 0.01),
                    Container(
                      width: b * 0.7,
                      height: h * 0.119,
                      child: Card(
                        color: Color.fromARGB(255, 255, 145, 72),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.only(
                                        left: b * 0.063, top: h * 0.0204),
                                    child: Row(
                                      children: <Widget>[
                                        Text("Student Status:",
                                            style: TextStyle(
                                                fontSize: b * 0.042,
                                                color: Colors.black)),
                                        SizedBox(
                                          width: b * 0.02512,
                                        ),
                                        Text(student.status,
                                            style: TextStyle(
                                                fontSize: b * 0.0402,
                                                color: Colors.white)),
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: b * 0.050251,
            bottom: h * 0.692,
            child: Image.network(
              student.photoURL,
              height: h * 0.16261,
              width: b * 0.3016,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
