import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Drawer/CountDot.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/courses/subject_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoursePage extends StatefulWidget {
  final Teacher teacher;
  CoursePage({@required this.teacher});
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  SharedPreferences _pref;
  List _list;
  _sharedprefinit() async {
    _pref = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    _sharedprefinit();
    super.initState();
  }

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
              child: Center(
                child: Text(
                  'Courses'.tr(),
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
                        'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses')
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Courses> courses = List<Courses>();
                    widget.teacher?.courses?.forEach((course) {
                      if (snapshot.data.snapshot.value != null) {
                        print(snapshot.data.snapshot.value);
                        if (snapshot.data.snapshot.value[course.id] != null) {
                          courses.add(Courses.fromJson(
                              snapshot.data.snapshot.value[course.id]));
                        }
                      }
                    });
                    List<bool> _showCountDot = List(courses?.length ?? 0);
                    for (int i = 0; i < _showCountDot.length; i++) {
                      _showCountDot[i] = false;
                    }
                    return ListView.builder(
                      itemCount: courses?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                       _list = _pref
                            .getKeys()
                            .where((element) =>
                                element.startsWith('${courses[index].name}'))
                            .toList();
                        int prevtotallength = _list.length;
              
                        Map<String, int> _correspondingsubject = Map();
                        int _totallength = 0, _contentlength , count=0;
                        if (courses[index].subjects != null) {
                          courses[index].subjects?.forEach((key1, value) {
                            _contentlength = 0;
                            String subjectname = value.name.toString();

                          
                            if (value.chapters!= null) {
                              value.chapters.forEach((key2, value2) {
                                String chaptername = value2.name.toString();

                              

                                if (value2.content != null) {
                                  _contentlength =
                                      _contentlength + value2.content.length;
                                  _correspondingsubject[subjectname] =_contentlength;    
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
                                      _pref.setInt(key, 1);
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
                              _pref.remove(element);
                            });
                          }
                         
                        

                        if(prevtotallength!=0){
                                    courses[index].subjects?.forEach((key, value) { 
                                      _totallength = _correspondingsubject[value.name.toString()];

                                      int _totalContent = _totallength ?? 0;
                                      String searchKey = courses[index].name+"__"+ value.name.toString();
                                       _list = _pref.getKeys().where((element) => element.startsWith(searchKey)).toList();

                                      int _prevtotalContent =  _list.length;
                                      
                                      if (_prevtotalContent < _totalContent) {
                                      count++;
                                      }
                                    });
                                  
                                  } 
                        }
                        TCourses tcourse = widget.teacher?.courses?.firstWhere(
                            (element) => element.id == courses[index].id);
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
                                trailing: Container(
                                  height: 40,
                                  width: 80,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (_showCountDot[index])
                                        CountDot(
                                            count: count),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: Color(0xffF36C24),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  return Navigator.of(context)
                                      .push(
                                    CupertinoPageRoute(
                                      builder: (context) => SubjectPage(
                                          tCourse: tcourse,
                                          course: courses[index],
                                          pref: _pref,
                                          passKey: '${courses[index].name}'),
                                    ),
                                  )
                                      .then((value) {
                                    setState(() {});
                                  });
                                }),
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
