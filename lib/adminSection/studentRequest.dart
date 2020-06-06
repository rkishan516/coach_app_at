import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class StudentsRequests extends StatefulWidget {
  @override
  _StudentsRequestsState createState() => _StudentsRequestsState();
}

class _StudentsRequestsState extends State<StudentsRequests> {
  DatabaseReference ref = FirebaseDatabase.instance.reference().child(
      'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students');
  GlobalKey<ScaffoldState> _scKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scKey,
      drawer: getDrawer(context),
      appBar: getAppBar(context),
      body: Container(
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
                spreadRadius: 2)
          ],
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 12,
              child: StreamBuilder<Event>(
                stream: ref.onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, Student> students = Map<String, Student>();
                    snapshot.data.snapshot.value?.forEach((key, student) {
                      Student studentp = Student.fromJson(student);
                      if (studentp.status == 'Existing Student') {
                        students[key] = studentp;
                      }
                    });
                    return ListView.builder(
                      itemCount: students?.length,
                      itemBuilder: (BuildContext context, int index) {
                        String selectedCourseID =
                            students[students.keys.toList()[index]].classs;
                        Courses selectedCourse;
                        return Card(
                          child: ListTile(
                            title: Text(
                              'Name'.tr() +
                                  ' : \t\t\t' +
                                  '${students[students.keys.toList()[index]].name}\n' +
                                  'Email'.tr() +
                                  ' : \t' +
                                  '${students[students.keys.toList()[index]].email}\n' +
                                  'Address'.tr() +
                                  ' : \t\t\t' +
                                  '${students[students.keys.toList()[index]].address}',
                              style: TextStyle(color: Colors.orange),
                            ),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  students[students.keys.toList()[index]]
                                      .photoURL),
                            ),
                            dense: true,
                            isThreeLine: true,
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.orange,
                              ),
                              onPressed: () {
                                ref
                                    .child(students.keys.toList()[index] +
                                        '/status')
                                    .set('Rejected');
                              },
                            ),
                            subtitle: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 9,
                                  child: StreamBuilder<Event>(
                                      stream: ref
                                          .parent()
                                          .child('/courses')
                                          .onValue,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          List<Courses> courses =
                                              List<Courses>();
                                          snapshot.data.snapshot.value
                                              .forEach((k, v) {
                                            courses.add(Courses.fromJson(v));
                                            if (k.toString() ==
                                                students[students.keys
                                                        .toList()[index]]
                                                    .classs) {
                                              selectedCourse =
                                                  Courses.fromJson(v);
                                            }
                                          });
                                          return DropdownButton(
                                              value: selectedCourseID,
                                              hint: Text('Select Course'.tr()),
                                              items: courses
                                                  .map(
                                                    (e) => DropdownMenuItem(
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            5,
                                                        child: Text(
                                                          e.name,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      value: e.id,
                                                      onTap: () {
                                                        setState(() {
                                                          selectedCourse = e;
                                                        });
                                                      },
                                                    ),
                                                  )
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedCourseID = value;
                                                });
                                              });
                                        } else {
                                          return Container();
                                        }
                                      }),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: FlatButton(
                                    onPressed: () {
                                      if (selectedCourseID == null ||
                                          selectedCourse == null) {
                                        _scKey.currentState.showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Select the course for Student'
                                                    .tr()),
                                          ),
                                        );
                                      } else {
                                        Course course = Course(
                                          academicYear:
                                              DateTime.now().year.toString() +
                                                  '-' +
                                                  (DateTime.now().year + 1)
                                                      .toString(),
                                          courseID: selectedCourseID,
                                          courseName: selectedCourse.name,
                                          paymentToken:
                                              'Registered By ${FireBaseAuth.instance.user.displayName}',
                                        );
                                        ref
                                            .child(
                                                students.keys.toList()[index] +
                                                    '/status')
                                            .set('Registered');
                                        ref
                                            .child(
                                                students.keys.toList()[index] +
                                                    '/course')
                                            .child(selectedCourseID)
                                            .set(course.toJson());
                                        selectedCourse = null;
                                        selectedCourseID = null;
                                      }
                                    },
                                    child: Text('Accept'.tr()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            title: PlaceholderLines(
                              count: 1,
                              animate: true,
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
