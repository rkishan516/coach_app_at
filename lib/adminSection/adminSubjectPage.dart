import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:coach_app/Dialogs/multiselectDialogs.dart';
import 'package:coach_app/Drawer/CountDot.dart';
import 'package:coach_app/Drawer/NewBannerShow.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/GlobalFunction/SlideButton.dart';
import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/InstituteAdmin/studentList.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/TimeTableSection/TimeTablePage.dart';
import 'package:coach_app/adminSection/teacherRegister.dart';
import 'package:coach_app/courses/chapter_page.dart';
import 'package:coach_app/courses/subject_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminSubjectPage extends StatefulWidget {
  final String courseId;
  final SharedPreferences pref;
  final passKey;
  AdminSubjectPage({@required this.courseId, @required this.pref, @required this.passKey});
  @override
  _AdminSubjectPageState createState() => _AdminSubjectPageState();
}

class _AdminSubjectPageState extends State<AdminSubjectPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List _list;
  bool showFAB= true;


  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int length = 0;
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
                            var keys;
                            if (courses.subjects != null) {
                              keys = courses.subjects.keys.toList()
                                ..sort((a, b) => courses.subjects[a].name
                                    .compareTo(courses.subjects[b].name));
                            }

                            length = courses.subjects?.length ?? 0;
                            List<bool> _showCountDot = List(length);
                            for(int i=0;i<_showCountDot.length;i++)
                            {
                              _showCountDot[i] = false;
                            }
                            
                            return ListView.builder(
                              itemCount: length,
                              itemBuilder: (BuildContext context, int index) {
                                int _contentlength =0;
                        int _totalContent = 0;
                        
                          if(courses.subjects[keys.toList()[index]].chapters!=null){
                          courses.subjects[keys.toList()[index]].chapters.forEach((key, value) {
                                   
                                  int _indvContent = value?.content?.length??0;
                                  _contentlength += _indvContent;
                          });
                          _totalContent =  _contentlength;
                        
                          } String searchkey= widget.passKey +"__"+ '${courses.subjects[keys.toList()[index]].name}';
                            _list = widget.pref.getKeys().where((element) => element.startsWith(searchkey)).toList();
                            int _prevtotalContent = _list.length??_totalContent;
                            if(_prevtotalContent<=_totalContent){
                             
                              _showCountDot[index] = true;
                            }
                            
                            else{
                              
                            }
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ListTile(
                                        title: Text(
                                          '${courses.subjects[keys.toList()[index]].name}',
                                          style: TextStyle(
                                              color: Color(0xffF36C24)),
                                        ),
                                        trailing:Container(
                                    height: 40,
                                    width: 80,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        if(_showCountDot[index])
                                        CountDot(count:_totalContent - _prevtotalContent <= 0? 0: 1 ),
                                        SizedBox(width: 10.0,),
                                        Icon(
                                          Icons.chevron_right,
                                          color: Color(0xffF36C24),
                                        ),
                                      ],
                                    ),
                                  ),
                                        onTap: () {
                                          
                                          return Navigator.of(context).push(
                                            CupertinoPageRoute(
                                              builder: (context) => ChapterPage(
                                                courseId: widget.courseId,
                                                title: courses
                                                    .subjects[
                                                        keys.toList()[index]]
                                                    .name,
                                                reference: FirebaseDatabase
                                                    .instance
                                                    .reference()
                                                    .child(
                                                        'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${courses.id}/subjects/${keys.toList()[index]}'),
                                                pref: widget.pref,
                                                passKey : searchkey
                                        
                                              ),
                                            ),
                                          ).then((value) {
                                                  setState(() {
                                              
                                                  });
                                          });
                                        },
                                        onLongPress: () => addSubject(
                                          context,
                                          widget.courseId,
                                          key: keys.toList()[index],
                                          name: courses
                                              .subjects[keys.toList()[index]]
                                              .name,
                                          mentors: courses
                                              .subjects[keys.toList()[index]]
                                              .mentor
                                              .values
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
                StudentList(
                  courseId: widget.courseId,
                ),
                TimeTablePage(
                  courseId: widget.courseId,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: (!showFAB)
          ? null
          : SlideButtonR(
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
  List<Map<String, dynamic>> teachers, initialTeachers;
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
                                      'Your Institute does not have any Teacher'
                                          .tr(),
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
                              initialTeachers = List<Map<String, dynamic>>();
                              snapshot.data.snapshot.value.forEach(
                                (k, v) {
                                  Teacher teacher = Teacher.fromJson(v);
                                  if (mentors.contains(teacher.email)) {
                                    selectedTeacher.add(teacher);
                                    initialTeachers.add({
                                      "key": k,
                                      "display": teacher?.email,
                                      "value": teacher
                                    });
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
                          mentor: {
                            for (var v in selectedTeacher)
                              v.email.split('@')[0].replaceAll('.', ','):
                                  v.email
                          },
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
                                initialTeachers?.removeWhere((element) =>
                                    element["key"] == teachers[i]['key']);
                              }
                            }
                          },
                        );

                        initialTeachers.forEach((element) {
                          if (key != null) {
                            Teacher teacher = element['value'];
                            for (int i = 0;
                                i < teacher?.courses?.length ?? 0;
                                i++) {
                              if (teacher.courses[i].id == courseId) {
                                for (int j = 0;
                                    j < teacher.courses[i]?.subjects?.length ??
                                        0;
                                    j++) {
                                  if (teacher.courses[i]?.subjects[j] == key) {
                                    teacher.courses[i]?.subjects?.removeAt(j);
                                    break;
                                  }
                                }
                                if ((teacher.courses[i]?.subjects?.length ??
                                        0) ==
                                    0) {
                                  teacher.courses?.removeAt(i);
                                }
                                break;
                              }
                            }
                            DatabaseReference ref = FirebaseDatabase.instance
                                .reference()
                                .child(
                                    "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/teachers/${element['key']}/");
                            ref.update(teacher.toJson());
                          }
                        });

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
