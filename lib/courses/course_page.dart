import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/courses/subject_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';

class CoursePage extends StatefulWidget {
  final Teacher teacher;
  CoursePage({@required this.teacher});
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                stream: FirebaseDatabase.instance
                    .reference()
                    .child(
                        'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses')
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Courses> courses = List<Courses>();
                    widget.teacher?.courses?.forEach((course) {
                      if (snapshot.data.snapshot.value != null) {
                        if (snapshot.data.snapshot.value[course.id] != null) {
                          courses.add(Courses.fromJson(
                              snapshot.data.snapshot.value[course.id]));
                        }
                      }
                    });
                    return ListView.builder(
                      itemCount: courses?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        TCourses tcourse = widget.teacher?.courses?.firstWhere((element) => element.id == courses[index].id);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              title: Text(
                                '${courses[index].name}',
                                style: TextStyle(color: Colors.blue),
                              ),
                              trailing: Icon(
                                Icons.chevron_right,
                                color: Colors.blue,
                              ),
                              onTap: () => Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => SubjectPage(
                                    tCourse: tcourse,
                                    course: courses[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: widget.teacher?.courses?.length,
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
