import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
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
                        return Card(
                          child: StudentRequestListTile(
                            keyS: students.keys.toList()[index],
                            student: students[students.keys.toList()[index]],
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

class StudentRequestListTile extends StatefulWidget {
  String keyS;
  Student student;
  StudentRequestListTile({this.keyS, this.student});
  @override
  _StudentRequestListTileState createState() => _StudentRequestListTileState();
}

class _StudentRequestListTileState extends State<StudentRequestListTile> {
  DatabaseReference ref = FirebaseDatabase.instance.reference().child(
      'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students');
  String selectedCourseID;
  Courses selectedCourse;
  @override
  void initState() {
    selectedCourseID = widget.student.classs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Name'.tr() +
            ' : \t\t\t' +
            '${widget.student.name}\n' +
            'Email'.tr() +
            ' : \t' +
            '${widget.student.email}\n' +
            'Address'.tr() +
            ' : \t\t\t' +
            '${widget.student.address}',
        style: TextStyle(color: Color(0xffF36C24)),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.student.photoURL),
      ),
      dense: true,
      isThreeLine: true,
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Color(0xffF36C24),
        ),
        onPressed: () {
          ref.child(widget.keyS + '/status').set('Rejected');
        },
      ),
      subtitle: Row(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: StreamBuilder<Event>(
                stream: ref.parent().child('/courses').onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, Courses> courses = Map<String, Courses>();
                    snapshot.data.snapshot.value.forEach((k, v) {
                      courses[k] = (Courses.fromJson(v));
                      if (k.toString() == widget.student.classs) {
                        selectedCourse = Courses.fromJson(v);
                      }
                    });
                    return DropdownButton<String>(
                        value: selectedCourseID,
                        hint: Text('Select Course'.tr()),
                        items: courses
                            .map(
                              (k, e) => MapEntry(
                                k,
                                DropdownMenuItem(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    child: Text(
                                      e.name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  value: e.id,
                                ),
                              ),
                            )
                            .values
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCourseID = value;
                            selectedCourse = courses[value];
                            print(selectedCourseID);
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
                if (selectedCourseID == null || selectedCourse == null) {
                  Alert.instance
                      .alert(context, 'Select the course for Student'.tr());
                } else {
                  Course course = Course(
                    academicYear: DateTime.now().year.toString() +
                        '-' +
                        (DateTime.now().year + 1).toString(),
                    courseID: selectedCourseID,
                    courseName: selectedCourse.name,
                    paymentToken:
                        'Registered By ${FireBaseAuth.instance.user.displayName}',
                  );
                  ref.child(widget.keyS + '/status').set('Registered');
                  ref
                      .child(widget.keyS + '/course')
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
    );
  }
}
