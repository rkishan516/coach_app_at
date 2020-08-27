import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Drawer/CountDot.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/Events/StudentEvent.dart';
import 'package:coach_app/GlobalFunction/SlideButton.dart';
import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Student/chapter_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubjectPage extends StatefulWidget {
  final String courseID;
  SubjectPage({@required this.courseID});
  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  
   SharedPreferences _pref;
   List _list;
  _sharedprefinit() async {
    _pref = await SharedPreferences.getInstance();
    _list = _pref.getKeys().where((element) => element.startsWith("StudentSubject")).toList();

  }
  _searchForKey(String keyname, bool _isLast){

   _list?.remove(keyname);
   if(_isLast){
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
              flex: 12,
              child: StreamBuilder<Event>(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child(
                        'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseID}')
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
                        
                        String _key = "StudentSubject"+courses.subjects[keys.toList()[index]].name;
                        bool _islast = false;
                          if(index==length-1) 
                          _islast= true;
                          _searchForKey(_key, _islast);
                        int _totalContent = courses.subjects[keys.toList()[index]].chapters?.length??0;
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
                                '${courses.subjects[keys.toList()[index]].name}',
                                style: TextStyle(color: Colors.blue),
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

                                return Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => ChapterPage(
                                      title: courses
                                          .subjects[keys
                                              .toList()[index]]
                                          .name,
                                      reference: FirebaseDatabase.instance
                                          .reference()
                                          .child(
                                              'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${courses.id}/subjects/${keys.toList()[index]}'),
                                    ),
                                  ),
                                ).then((value) {
                                      setState(() {
                                        _showCountDot[index] = false;
                                      });
                               });
                              },
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
      floatingActionButton: SlideButton(
        text: 'Live Sessions'.tr(),
        icon: Icon(Icons.add_alert),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentEvent(
              courseId: widget.courseID,
            ),
          ),
        ),
        width: 150,
        height: 50,
      ),
    );
  }
}
