import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/multiselectDialogs.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/courses/chapter_page.dart';
import 'package:coach_app/courses/subject_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:google_fonts/google_fonts.dart';
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
      appBar: AppBar(
        title: Text(
          'Subjects'.tr(),
          style: GoogleFonts.portLligatSans(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData.fallback().copyWith(color: Colors.white),
      ),
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
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.orange, Colors.deepOrange])),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 12,
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
                        return Card(
                            child: ListTile(
                          title: Text(
                            '${courses.subjects[index].name}',
                            style: TextStyle(color: Colors.orange),
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: Colors.orange,
                          ),
                          onTap: () {
                            return Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => ChapterPage(
                                  title: courses.subjects[index].name,
                                  reference: FirebaseDatabase.instance
                                      .reference()
                                      .child(
                                          'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${courses.id}/subjects/$index'),
                                ),
                              ),
                            );
                          },
                          onLongPress: () => addSubject(
                            context,
                            widget.courseId,
                            index,
                            name: courses.subjects[index].name,
                            mentors: courses.subjects[index].mentor.join(','),
                          ),
                        ));
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.orange, Colors.deepOrange])),
            child: Icon(
              Icons.add,
              color: Colors.white,
            )),
        onPressed: () => addSubject(context, widget.courseId, length),
      ),
    );
  }
}

addSubject(BuildContext context, String courseId, int length,
    {String name = '', String mentors = ''}) {
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
                    Text(
                      'Subject Name'.tr(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: nameTextEditingController,
                      decoration: InputDecoration(
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
                              return Container(
                                child: Text(
                                  'Your Institute does not have any Teacher',
                                ),
                              );
                            } else {
                              teachers = List<Map<String, dynamic>>();
                              snapshot.data.snapshot.value.forEach(
                                (k, v) {
                                  Teacher teacher = Teacher.fromJson(v);
                                  if(mentors.contains(teacher.email)){
                                    selectedTeacher.add(teacher);
                                  }
                                  teachers.add({
                                    "display": teacher.email,
                                    "value": teacher
                                  });
                                },
                              );
                              return MultiSelectFormField(
                                dataSource: teachers,
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
                            // TODO Warning for gmail
                            // TODO Warning EveryWhere
                            // TODO EVEnt Section Add
                            // TODO Quiz Editing
                            // TODO Question delete and edit
                            // TODO PDF Loading
                            // TODO institute Logo on Registration
                            // TODO My Institute Button
                            // TODO Credential Save
                            // TODO Login Button automatic
                            // TODO subadmin access
                            // TODO branch List and Details
                          } else {
                            return Container();
                          }
                        }),
                    // TextField(
                    //   controller: mentorTextEditingController,
                    //   decoration: InputDecoration(
                    //     border: InputBorder.none,
                    //     hintText: 'Seprated With comma'.tr(),
                    //     fillColor: Color(0xfff3f3f4),
                    //     filled: true,
                    //   ),
                    // )
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
                            onPressed: () {
                              FirebaseDatabase.instance
                                  .reference()
                                  .child(
                                      'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/$courseId/subjects/$length')
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
                              context, 'Please Enter the Name of Course');
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
                          mentor: selectedTeacher.map<String>((e) {
                            return e.email;
                          }).toList(),
                        );
                        FirebaseDatabase.instance
                            .reference()
                            .child(
                                'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/$courseId/subjects/$length')
                            .set(subject.toJson());

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
