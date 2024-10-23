import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/GlobalFunction/SlideButton.dart';
import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Profile/TeacherProfile.dart';
import 'package:coach_app/adminSection/teacherRegister.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TeachersList extends StatefulWidget {
  final String? courseId;
  final String? subjectId;
  TeachersList({
    this.courseId,
    this.subjectId,
  });
  @override
  _TeachersListState createState() => _TeachersListState();
}

class _TeachersListState extends State<TeachersList> {
  TextEditingController searchTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: (widget.courseId != null) ? null : getDrawer(context),
      appBar: (widget.courseId != null) ? null : getAppBar(context),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchTextEditingController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Color(0xfff3f3f4),
                    ),
                  ),
                  contentPadding: EdgeInsets.only(left: 10),
                  hintStyle: TextStyle(fontSize: 15),
                  hintText: 'Search by teacher name'.tr(),
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                ),
              ),
            ),
            Expanded(
              flex: 12,
              child: StreamBuilder<DatabaseEvent>(
                stream: FirebaseDatabase.instance
                    .ref()
                    .child(
                        'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/teachers')
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, Teacher> teachers = Map<String, Teacher>();
                    (snapshot.data!.snapshot.value as Map?)
                        ?.forEach((k, teacher) {
                      if (widget.courseId == null || widget.subjectId == null) {
                        if (searchTextEditingController.text == '') {
                          teachers[k] = Teacher.fromJson(teacher);
                        } else {
                          Teacher sTeacher = Teacher.fromJson(teacher);
                          if (sTeacher.name.toLowerCase().contains(
                              searchTextEditingController.text.toLowerCase())) {
                            teachers[k] = sTeacher;
                          }
                        }
                      } else {
                        if (searchTextEditingController.text == '') {
                          Teacher teach = Teacher.fromJson(teacher);
                          TCourses? tCourses = teach.courses?.firstWhere(
                              (element) => element.id == widget.courseId);
                          if (tCourses != null) {
                            if (tCourses.subjects!.contains(widget.subjectId)) {
                              teachers[k] = teach;
                            }
                          }
                        } else {
                          Teacher sTeacher = Teacher.fromJson(teacher);
                          if (sTeacher.name.toLowerCase().contains(
                                  searchTextEditingController.text
                                      .toLowerCase()) &&
                              (sTeacher.courses
                                      ?.firstWhere((element) =>
                                          element.id == widget.courseId)
                                      .subjects
                                      ?.firstWhere((element) =>
                                          element == widget.subjectId) !=
                                  null)) {
                            teachers[k] = sTeacher;
                          }
                        }
                      }
                    });
                    return Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(searchTextEditingController.text == ''
                                ? 'Total Teachers : ${teachers.length}'
                                : 'Found Teachers : ${teachers.length}'),
                          ),
                        ),
                        Expanded(
                          flex: 12,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount: teachers.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                    title: Text(
                                      '${teachers[teachers.keys.toList()[index]]?.name}',
                                      style:
                                          TextStyle(color: Color(0xffF36C24)),
                                    ),
                                    subtitle: Text(
                                      '${teachers[teachers.keys.toList()[index]]?.email}',
                                      style:
                                          TextStyle(color: Color(0xffF36C24)),
                                    ),
                                    trailing: Icon(
                                      Icons.chevron_right,
                                      color: Color(0xffF36C24),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TeacherProfilePage(
                                            reference: FirebaseDatabase.instance
                                                .ref()
                                                .child(
                                                    'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/teachers/${teachers.keys.toList()[index]}'),
                                          ),
                                        ),
                                      );
                                    },
                                    onLongPress: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => TeacherRegister(
                                                isEdit: true,
                                                keyT: teachers.keys
                                                    .toList()[index],
                                                teacher: teachers[teachers.keys
                                                    .toList()[index]]!,
                                              ));
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SlideButton(
        text: 'Add Teacher'.tr(),
        onTap: () => showDialog(
          context: context,
          builder: (context) => TeacherRegister(
            courseId: widget.courseId!,
            subjectId: widget.subjectId!,
          ),
        ),
        width: 150,
        height: 50,
      ),
    );
  }
}
