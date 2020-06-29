import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:coach_app/Dialogs/multiselectDialogs.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/GlobalFunction/SlideButton.dart';
import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/adminSection/teacherRegister.dart';
import 'package:coach_app/courses/chapter_page.dart';
import 'package:coach_app/courses/subject_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AdminSubjectPage extends StatefulWidget {
  final String courseId;
  AdminSubjectPage({@required this.courseId});
  @override
  _AdminSubjectPageState createState() => _AdminSubjectPageState();
}

class _AdminSubjectPageState extends State<AdminSubjectPage> {
  @override
  Widget build(BuildContext context) {
    int length = 0;
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
              flex: 1,
                child: Center(
                  child: Text(
                    'Subjects'.tr(),
                    style: TextStyle(color: Color(0xffF36C24)),
                  ),
                ),
              ),
            Expanded(
              flex: 24,
              child: StreamBuilder<Event>(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child(
                        'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseId}')
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Courses courses =
                        Courses.fromJson(snapshot.data.snapshot.value);
                    length = courses.subjects?.length ?? 0;
                    return ListView.builder(
                      itemCount: length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                title: Text(
                                  '${courses.subjects[courses.subjects.keys.toList()[index]].name}',
                                  style: TextStyle(color: Color(0xffF36C24)),
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: Color(0xffF36C24),
                                ),
                                onTap: () {
                                  return Navigator.of(context).push(
                                    CupertinoPageRoute(
                                      builder: (context) => ChapterPage(
                                        courseId: widget.courseId,
                                        title: courses
                                            .subjects[courses.subjects.keys
                                                .toList()[index]]
                                            .name,
                                        reference: FirebaseDatabase.instance
                                            .reference()
                                            .child(
                                                'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${courses.id}/subjects/${courses.subjects.keys.toList()[index]}'),
                                      ),
                                    ),
                                  );
                                },
                                onLongPress: () => addSubject(
                                  context,
                                  widget.courseId,
                                  key: courses.subjects.keys.toList()[index],
                                  name: courses
                                      .subjects[
                                          courses.subjects.keys.toList()[index]]
                                      .name,
                                  mentors: courses
                                      .subjects[
                                          courses.subjects.keys.toList()[index]]
                                      .mentor.values
                                      .join(','),
                                ),
                              )),
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
      floatingActionButton: SlideButtonR(
          text: 'Add Subject'.tr(),
          onTap: () => addSubject(context, widget.courseId),
          width: 150,
          height: 50),
    );
  }
}

addSubject(BuildContext context, String courseId,
    {String key, String name = '', String mentors = ''}) {
  TextEditingController nameTextEditingController = TextEditingController()
    ..text = name;
  List selectedTeacher = List();
  List<Map<String, dynamic>> teachers;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(
            16.0,
          ),
          margin: EdgeInsets.only(top: 66.0),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      controller: nameTextEditingController,
                      decoration: InputDecoration(
                        hintText: 'Subject Name'.tr(),
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Mentors'.tr(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StreamBuilder<Event>(
                        stream: FirebaseDatabase.instance
                            .reference()
                            .child(
                                'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/teachers')
                            .onValue,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print(snapshot.data.snapshot.value);
                            if (snapshot.data.snapshot.value == null) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      'Your Institute does not have any Teacher'.tr(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  FlatButton(
                                      color: Color(0xfff3f3f4),
                                      onPressed: () => showCupertinoDialog(
                                            context: context,
                                            builder: (context) =>
                                                TeacherRegister(),
                                          ),
                                      child: Text('Add Teacher'.tr()))
                                ],
                              );
                            } else {
                              teachers = List<Map<String, dynamic>>();
                              snapshot.data.snapshot.value.forEach(
                                (k, v) {
                                  Teacher teacher = Teacher.fromJson(v);
                                  if (mentors.contains(teacher.email)) {
                                    selectedTeacher.add(teacher);
                                  }
                                  teachers.add({
                                    "key": k,
                                    "display": teacher?.email,
                                    "value": teacher
                                  });
                                },
                              );
                              return MultiSelectFormField(
                                dataSource: teachers ??
                                    [
                                      {'display': '', 'value': ''}
                                    ],
                                valueField: 'value',
                                textField: 'display',
                                titleText: 'Mentors'.tr(),
                                okButtonLabel: 'Accept'.tr(),
                                cancelButtonLabel: 'Reject'.tr(),
                                hintText:
                                    'Please select atleast one teacher'.tr(),
                                initialValue: selectedTeacher,
                                onSaved: (value) {
                                  selectedTeacher = value;
                                },
                              );
                            }
                          } else {
                            return Container();
                          }
                        }),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    (name == '')
                        ? Container()
                        : FlatButton(
                            onPressed: () async {
                              String res = await showDialog(
                                  context: context,
                                  builder: (context) => AreYouSure());
                              if (res != 'Yes') {
                                return;
                              }
                              FirebaseDatabase.instance
                                  .reference()
                                  .child(
                                      'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/$courseId/subjects/$key')
                                  .remove();

                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Remove'.tr(),
                            ),
                          ),
                    FlatButton(
                      onPressed: () {
                        if (nameTextEditingController.text == '') {
                          Alert.instance.alert(
                              context, 'Please Enter the Name of Subject'.tr());
                          return;
                        }
                        if (selectedTeacher.length == 0) {
                          Alert.instance.alert(context,
                              'Please select atleast one teacher'.tr());
                          return;
                        }
                        Subjects subject = Subjects(
                          name: nameTextEditingController.text
                              .capitalize()
                              .trim(),
                          mentor: {for(var v in selectedTeacher) v.email.split('@')[0] : v.email},
                        );
                        var refe;
                        if (key == null) {
                          refe = FirebaseDatabase.instance
                              .reference()
                              .child(
                                  'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/$courseId/subjects/')
                              .push();
                          key = refe.key;
                        } else {
                          refe = FirebaseDatabase.instance.reference().child(
                              'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/$courseId/subjects/$key');
                        }
                        refe.update(subject.toJson());
                        selectedTeacher.forEach(
                          (element) {
                            for (int i = 0; i < teachers.length; i++) {
                              if (teachers[i]['value'] == element) {
                                DatabaseReference ref =
                                    FirebaseDatabase.instance.reference().child(
                                        "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/teachers/${teachers[i]['key']}/courses/");
                                List subjects = [];
                                int lengthC =
                                    teachers[i]['value'].courses?.length ?? 0;
                                for (int j = 0; j < lengthC; j++) {
                                  if (teachers[i]['value'].courses[j].id ==
                                      courseId) {
                                    subjects = teachers[i]['value']
                                        .courses[j]
                                        .subjects;
                                    lengthC = j;
                                    break;
                                  }
                                }
                                List<String> d = [];
                                if (!subjects.contains(key)) {
                                  d = [key];
                                }

                                ref.child(lengthC.toString()).update(
                                    {"id": courseId, "subjects": subjects + d});
                              }
                            }
                          },
                        );

                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Add Subject'.tr(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
