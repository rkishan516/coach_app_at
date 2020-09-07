import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Drawer/CountDot.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/Events/StudentEvent.dart';
import 'package:coach_app/GlobalFunction/SlideButton.dart';
import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Student/chapter_page.dart';
import 'package:coach_app/TimeTableSection/TimeTablePage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SubjectPage extends StatefulWidget {
  final String courseID;
  final String passKey;
  SubjectPage({@required this.courseID, @required this.passKey});
  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List _list;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
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

                            return ListView.builder(
                              itemCount: length,
                              itemBuilder: (BuildContext context, int index) {
                                int _contentlength = 0;
                                int _totalContent = 0;
                                int count = 0;
                                if (courses.subjects[keys.toList()[index]]
                                        .chapters !=
                                    null) {
                                  courses
                                      .subjects[keys.toList()[index]].chapters
                                      .forEach((key, value) {
                                    int _indvContent =
                                        value?.content?.length ?? 0;
                                    _contentlength = _indvContent;

                                    String searchkey = widget.passKey +
                                        "__" +
                                        '${courses.subjects[keys.toList()[index]].name}' +
                                        "__" +
                                        value.name.toString();
                                    _list = FireBaseAuth.instance.prefs
                                        .getKeys()
                                        .where((element) =>
                                            element.startsWith(searchkey))
                                        .toList();
                                    _totalContent = _contentlength;
                                    int _prevtotalContent =
                                        _list.length ?? _totalContent;
                                    if (_prevtotalContent < _totalContent) {
                                      count++;
                                    }
                                  });
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
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      trailing: Container(
                                        height: 40,
                                        width: 80,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CountDot(count: count),
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
                                            builder: (context) => ChapterPage(
                                                title: courses
                                                    .subjects[
                                                        keys.toList()[index]]
                                                    .name,
                                                reference: FirebaseDatabase
                                                    .instance
                                                    .reference()
                                                    .child(
                                                        'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${courses.id}/subjects/${keys.toList()[index]}'),
                                                passKey: widget.passKey +
                                                    "__" +
                                                    '${courses.subjects[keys.toList()[index]].name}'),
                                          ),
                                        )
                                            .then((value) {
                                          setState(() {});
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
                TimeTablePage(
                  courseId: widget.courseID,
                ),
              ],
            ),
          ),
        ],
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
