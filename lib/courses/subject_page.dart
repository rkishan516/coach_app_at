import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/InstituteAdmin/studentList.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/TimeTableSection/TimeTablePage.dart';
import 'package:coach_app/courses/chapter_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class SubjectPage extends StatefulWidget {
  final TCourses tCourse;
  final Courses course;
  SubjectPage({@required this.tCourse, @required this.course});
  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getDrawer(context),
      appBar: getAppBar(context),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                child: Text(
                  'Subjects',
                  style: TextStyle(color: Color(0xffF36C24)),
                ),
              ),
              Tab(
                child: Text('Students',
                    style: TextStyle(color: Color(0xffF36C24))),
              ),
              Tab(
                child: Text('Time Table',
                    style: TextStyle(color: Color(0xffF36C24))),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 20),
            height: MediaQuery.of(context).size.height - 128,
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
            child: TabBarView(
              controller: _tabController,
              children: [
                Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          'Subjects'.tr(),
                          style: TextStyle(color: Color(0xffF36C24)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 12,
                      child: ListView.builder(
                        itemCount: widget.tCourse.subjects?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          if (widget.course.subjects == null) {
                            return Container();
                          }
                          if (widget.course
                                  ?.subjects[widget.tCourse.subjects[index]] ==
                              null) {
                            return Container();
                          }
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  title: Text(
                                    '${widget.course.subjects[widget.tCourse.subjects[index]]?.name}',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  trailing: Icon(
                                    Icons.chevron_right,
                                    color: Colors.blue,
                                  ),
                                  onTap: () {
                                    return Navigator.of(context).push(
                                      CupertinoPageRoute(
                                        builder: (context) => ChapterPage(
                                          courseId: widget.course.id,
                                          title: widget
                                              .course
                                              .subjects[widget
                                                  .tCourse.subjects[index]]
                                              .name,
                                          reference: FirebaseDatabase.instance
                                              .reference()
                                              .child(
                                                  'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.tCourse.id}/subjects/${widget.tCourse.subjects[index]}'),
                                        ),
                                      ),
                                    );
                                  },
                                )),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                StudentList(
                  courseId: widget.course.id,
                ),
                TimeTablePage(
                  courseId: widget.course.id,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
