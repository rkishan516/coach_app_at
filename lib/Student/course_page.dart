import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/FeeSection/StudentReport/PaymentType.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Student/subject_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CoursePage extends StatefulWidget {
  final bool isFromDrawer;
  CoursePage({this.isFromDrawer = false});
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getDrawer(context),
      appBar: getAppBar(context),
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
          ),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    widget.isFromDrawer ? 'Fees' : 'Courses'.tr(),
                    style: TextStyle(color: Color(0xffF36C24)),
                  ),
                ),
              ),
              Expanded(
                flex: 12,
                child: StreamBuilder<Event>(
                  stream: FirebaseDatabase.instance
                      .reference()
                      .child(
                          'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/${FireBaseAuth.instance.user.uid}')
                      .onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Student student =
                          Student.fromJson(snapshot.data.snapshot.value);
                      student.course
                          .sort((a, b) => a.courseName.compareTo(b.courseName));
                      return ListView.builder(
                        itemCount: student.course.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                title: Text(
                                  '${student.course[index].courseName}',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: Colors.blue,
                                ),
                                onTap: () {
                                  if (widget.isFromDrawer) {
                                    return Navigator.of(context).push(
                                      CupertinoPageRoute(
                                        builder: (context) => PaymentType(
                                          courseId: student
                                              .course[index].courseID
                                              .toString(),
                                          courseName:
                                              student.course[index].courseName,
                                        ),
                                      ),
                                    );
                                  }
                                  return Navigator.of(context).push(
                                    CupertinoPageRoute(
                                      builder: (context) => SubjectPage(
                                        courseID: student.course[index].courseID
                                            .toString(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return UploadDialog(warning: 'Fetching'.tr());
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
