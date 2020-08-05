import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/FeeSection/StudentSection/feeUpdate.dart';
import 'package:coach_app/FeeSection/ToggleButton.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Profile/student_performance.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double b;
  static double v;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    b = screenWidth / 100;
    v = screenHeight / 100;
  }
}

class StudentProfilePage extends StatelessWidget {
  final Student student;
  final String keyS;
  StudentProfilePage({@required this.student, @required this.keyS});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: getAppBar(context),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: SizeConfig.v * 24, //10 for example
              width: SizeConfig.b * 100, //10 for example
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 243, 107, 40),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(SizeConfig.b * 11.31),
                    bottomLeft: Radius.circular(SizeConfig.b * 11.31)),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: SizeConfig.v * 0.331),
                  Center(
                    child: Text(
                      "Student Profile",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.b * 5.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: SizeConfig.v * 0.475,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: SizeConfig.v * 0.68),
                            Container(
                              child: Text(
                                student.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.b * 6),
                                maxLines: 3,
                              ),
                            ),
                            SizedBox(height: SizeConfig.v * 1.2),
                            Container(
                              child: Text(
                                student.email,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.b * 4.25),
                                maxLines: 2,
                              ),
                            ),
                            SizedBox(height: SizeConfig.v * 0.68),
                            Container(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                  SizedBox(width: SizeConfig.b * 5.98),
                                  Text(
                                    student?.phoneNo ?? "Phone No Not given",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: SizeConfig.b * 4.3),
                                  ),
                                  SizedBox(width: SizeConfig.b * 0.98),
                                  RaisedButton(
                                    child: Icon(
                                      Icons.call,
                                      color: Colors.white,
                                      size: SizeConfig.v * 2.9,
                                    ),
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          SizeConfig.v * 2.04),
                                    ),
                                    color: Color.fromARGB(255, 243, 106, 38),
                                    onPressed: () => {},
                                  )
                                ])),
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(
                              SizeConfig.b * 3.77,
                              SizeConfig.v * 1.25,
                              SizeConfig.b * 7.77,
                              SizeConfig.v * 1.25),
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: CircleAvatar(
                            radius: SizeConfig.b * 11.1,
                            backgroundImage: NetworkImage(student.photoURL),
                          ))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeConfig.v * 5.1),
            if (student.course != null)
              Container(
                height: SizeConfig.v * 40.361,
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
                              ref: FirebaseDatabase.instance.reference().child(
                                  'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${student.course[index].courseID}')),
                        ),
                      ),
                      child: Padding(
                        padding: new EdgeInsets.only(
                            top: 5.0, left: 20.0, right: 20.0, bottom: 5.0),
                        child: Card(
                          color: Color.fromARGB(255, 243, 106, 38),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    width: SizeConfig.b * 52.3,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "Course : ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${student.course[index].courseName}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    width: SizeConfig.b * 52.3,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            "Academic Year : ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "${student.course[index].academicYear}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    width: SizeConfig.b * 52.3,
                                    child: ToggleButton(
                                      studentUid: keyS,
                                      courseId: student.course[index].courseID,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            SizedBox(height: SizeConfig.v * 3),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: SizeConfig.b * 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.location_on, size: SizeConfig.v * 3.8),
                      SizedBox(width: SizeConfig.b * 2.3),
                      Text(
                        "Address : ",
                        style: TextStyle(
                            fontSize: SizeConfig.b * 5.5,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Text(
                    student.address,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: SizeConfig.b * 3.93,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 243, 106, 38),
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeConfig.v * 2),
            Container(
              width: SizeConfig.b * 72,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 243, 107, 38),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    SizeConfig.b * 7,
                  ),
                ),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: SizeConfig.v * 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Student Status : ",
                          style: TextStyle(
                            fontSize: SizeConfig.b * 4.53,
                            fontWeight: FontWeight.w700,
                          )),
                      Text(
                        student.status,
                        style: TextStyle(
                          fontSize: SizeConfig.b * 4.53,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.v * 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
