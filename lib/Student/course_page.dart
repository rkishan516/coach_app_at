import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/Drawer/CountDot.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/FeeSection/StudentReport/PaymentType.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Student/subject_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoursePage extends StatefulWidget {
  final bool isFromDrawer;
  CoursePage({this.isFromDrawer = false});
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  SharedPreferences _pref;
  int _subjectlength =0;
  List _list;
  _sharedprefinit() async {
    _pref = await SharedPreferences.getInstance();
    _list = _pref
        .getKeys()
        .where((element) => element.startsWith("StudentCourse"))
        .toList();
  }

  _searchForKey(String keyname, bool _isLast) {
    _list?.remove(keyname);
    if (_isLast) {
      _list?.forEach((element) {
        _pref.remove(element);
      });
    }
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
                      List<bool> _showCountDot = List(student.course.length);
                      for (int i = 0; i < _showCountDot.length; i++) {
                        _showCountDot[i] = false;
                      }

                      return ListView.builder(
                        itemCount: student.course.length,
                        itemBuilder: (BuildContext context, int index) {
                       
                          return StreamBuilder(
                              stream: FirebaseDatabase.instance
                                  .reference()
                                  .child(
                                      'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${student.course[index].courseID}/subjects/')
                                  .onValue,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  
                                  Map map= snapshot.data.snapshot.value;
                                  _subjectlength = map?.length??0;
                                  
                                  int _totallength= 0, _chapterlength=0,  _contentlength= 0;
                                  if(map!=null){
                                  map?.forEach((key1, value) { 
                                   
                                  
                                   Map _chaptermap= value["chapters"];
                                   if(_chaptermap!=null){
                                     _chapterlength =_chapterlength + _chaptermap.length;
                                     _chaptermap.forEach((key2, value2) {
                                      
                                       Map _contentmap = value2["content"];
                                       if(_contentmap!=null){
                                         _contentlength =_contentlength + _contentmap.length;
                                       }
                                       
                                      });
                                   }
                              
                                  });
                                  }
                                  _totallength = _subjectlength+ _contentlength + _chapterlength;
                                  
                                  String _key = "StudentCourse" +
                                      student.course[index].courseName;
                                  bool _islast = false;
                                  if (index == student.course.length - 1)
                                    _islast = true;
                                  _searchForKey(_key, _islast);
                                  int _totalContent = _totallength ?? 0;
                                  int _prevtotalContent =
                                      _pref?.getInt(_key) ?? _totalContent;
                                  if (_prevtotalContent < _totalContent) {
                                    _showCountDot[index] = true;
                                  } else {
                                    _pref?.setInt(_key, _totalContent);
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ListTile(
                                        title: Text(
                                          '${student.course[index].courseName}',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        trailing: Container(
                                          height: 40,
                                          width: 80,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              if (FireBaseAuth.instance
                                                          .previlagelevel !=
                                                      4 &&
                                                  _showCountDot[index])
                                                CountDot(
                                                    count: _totalContent - _prevtotalContent <= 0? 0:_totalContent - _prevtotalContent ),
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
                                          _pref?.setInt(_key, _totalContent);
                                          if (widget.isFromDrawer) {
                                            
                                            return Navigator.of(context)
                                                .push(
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    PaymentType(
                                                  courseId: student
                                                      .course[index].courseID
                                                      .toString(),
                                                  courseName: student
                                                      .course[index].courseName,
                                                  isFromDrawer: true,
                                                ),
                                              ),
                                            )
                                                .then((value) {
                                              setState(() {
                                                _showCountDot[index] = false;
                                              });
                                            });
                                          }
                                          return Navigator.of(context).push(
                                            CupertinoPageRoute(
                                              builder: (context) => SubjectPage(
                                                courseID: student
                                                    .course[index].courseID
                                                    .toString(),
                                                pref: _pref,    
                                              ),
                                            ),
                                          ) .then((value) {
                                              setState(() {
                                                _showCountDot[index] = false;
                                              });
                                            });
                                        },
                                      ),
                                    ),
                                  );
                                }
                                return Container(width: 0.0, height: 0.0);
                              });
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
