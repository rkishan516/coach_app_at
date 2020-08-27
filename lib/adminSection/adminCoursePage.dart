import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Drawer/CountDot.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/GlobalFunction/SlideButton.dart';
import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/adminSection/addCourse.dart';
import 'package:coach_app/adminSection/adminSubjectPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminCoursePage extends StatefulWidget {
  @override
  _AdminCoursePageState createState() => _AdminCoursePageState();
}

class _AdminCoursePageState extends State<AdminCoursePage> {
  SharedPreferences _pref;
  List _list;

  _sharedprefinit() async {
    _pref = await SharedPreferences.getInstance();
    _list = _pref
        .getKeys()
        .where((element) => element.startsWith("AdminCourse"))
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
                    snapshot.data.snapshot.value?.values?.forEach((course) {
                      courses.add(Courses.fromJson(course));
                    });
                    courses.sort((a, b) => a.date.compareTo(b.date));

                    List<bool> _showCountDot = List(courses?.length);
                        for(int i=0;i<_showCountDot.length;i++)
                        {
                          _showCountDot[i] = false;
                        }
                    return ListView.builder(
                      itemCount: courses?.length,
                      itemBuilder: (BuildContext context, int index) {
                            String _key = "AdminCourse" +
                                      courses[index].name;
                            bool _islast = false;
                            if (index == courses?.length - 1)
                               _islast = true;
                            _searchForKey(_key, _islast);
                                  
                            int _totalContent = courses[index].subjects?.length??0;
                            int _prevtotalContent = _pref?.getInt(_key)??_totalContent;
                            if(_prevtotalContent<_totalContent){
                              _showCountDot[index] = true;
                            }
                            else{
                               _pref?.setInt(_key, _totalContent);
                            }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              title: Text(
                                '${courses[index].name}',
                                style: TextStyle(color: Color(0xffF36C24)),
                              ),
                              trailing: Container(
                                    height: 40,
                                    width: 80,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        if(FireBaseAuth.instance.previlagelevel!=4  && _showCountDot[index])
                                        CountDot(count: _totalContent -_prevtotalContent ),
                                        SizedBox(width: 10.0,),
                                        Icon(
                                          Icons.chevron_right,
                                          color: Color(0xffF36C24),
                                        ),
                                      ],
                                    ),
                                  ),
                              onTap: () {
                                _pref?.setInt(_key, _totalContent);

                               return  Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => AdminSubjectPage(
                                      courseId: courses[index].id),
                                ),
                              ).then((value) {
                                      setState(() {
                                        _showCountDot[index] = false;
                                      });
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
