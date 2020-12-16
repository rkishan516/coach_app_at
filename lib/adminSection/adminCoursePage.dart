import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Drawer/CountDot.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/GlobalFunction/SlideButton.dart';
import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Utils/Colors.dart';
import 'package:coach_app/adminSection/addCourse.dart';
import 'package:coach_app/adminSection/adminSubjectPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AdminCoursePage extends StatefulWidget {
  @override
  _AdminCoursePageState createState() => _AdminCoursePageState();
}

class _AdminCoursePageState extends State<AdminCoursePage> {
  List _list;

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
                color: GuruCoolLightColor.backgroundShade,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  'Courses'.tr(),
                  style: TextStyle(color: GuruCoolLightColor.primaryColor),
                ),
              ),
            ),
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
                    snapshot.data.snapshot.value?.values?.forEach((course) {
                      courses.add(Courses.fromJson(course));
                    });
                    courses.sort((a, b) => a.date.compareTo(b.date));

                    return ListView.builder(
                      itemCount: courses?.length,
                      itemBuilder: (BuildContext context, int index) {
                        _list = FireBaseAuth.instance.prefs
                            .getKeys()
                            .where((element) =>
                                element.startsWith('${courses[index].name}'))
                            .toList();
                        int prevtotallength = _list.length;

                        Map<String, int> _correspondingsubject = Map();
                        int _totallength = 0, _contentlength, count = 0;
                        if (courses[index].subjects != null) {
                          courses[index].subjects?.forEach((key1, value) {
                            _contentlength = 0;
                            String subjectname = value.name.toString();

                            if (value.chapters != null) {
                              value.chapters.forEach((key2, value2) {
                                String chaptername = value2.name.toString();

                                if (value2.content != null) {
                                  _contentlength =
                                      _contentlength + value2.content.length;
                                  _correspondingsubject[subjectname] =
                                      _contentlength;
                                  value2.content.forEach((key3, value3) {
                                    String contentname =
                                        value3.title.toString();
                                    String key = courses[index].name +
                                        "__" +
                                        subjectname +
                                        "__" +
                                        chaptername +
                                        "__" +
                                        contentname;

                                    if (prevtotallength == 0) {
                                      FireBaseAuth.instance.prefs
                                          .setInt(key, 1);
                                    } else {
                                      _list.remove(key);
                                    }
                                  });
                                }
                              });
                            }
                          });

                          if (_list.length != 0) {
                            _list?.forEach((element) {
                              FireBaseAuth.instance.prefs.remove(element);
                            });
                          }

                          if (prevtotallength != 0) {
                            courses[index].subjects?.forEach((key, value) {
                              _totallength =
                                  _correspondingsubject[value.name.toString()];

                              int _totalContent = _totallength ?? 0;
                              String searchKey = courses[index].name +
                                  "__" +
                                  value.name.toString();
                              _list = FireBaseAuth.instance.prefs
                                  .getKeys()
                                  .where((element) =>
                                      element.startsWith(searchKey))
                                  .toList();

                              int _prevtotalContent = _list.length;
                              if (_prevtotalContent < _totalContent) {
                                count++;
                              }
                            });
                          }
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              title: Text(
                                '${courses[index].name}',
                                style: TextStyle(
                                    color: GuruCoolLightColor.primaryColor),
                              ),
                              trailing: Container(
                                height: 40,
                                width: 80,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CountDot(count: count),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      color: GuruCoolLightColor.primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                return Navigator.of(context)
                                    .push(
                                  CupertinoPageRoute(
                                    builder: (context) => AdminSubjectPage(
                                      courseId: courses[index].id,
                                      passKey: '${courses[index].name}',
                                    ),
                                  ),
                                )
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                              onLongPress: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AddCourse(
                                      isEdit: true, course: courses[index]),
                                ),
                              ),
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
      floatingActionButton: SlideButtonR(
        height: 50,
        width: 150,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddCourse(
              isEdit: false,
              course: Courses(),
            ),
          ),
        ),
        text: 'Create Course'.tr(),
      ),
    );
  }
}
