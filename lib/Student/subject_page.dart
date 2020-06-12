import 'package:coach_app/Authentication/FirebaseAuth.dart';
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

class SubjectPage extends StatefulWidget {
  final String courseID;
  SubjectPage({@required this.courseID});
  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
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
            ],),
        child: Column(
          children: <Widget>[
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
                    length = courses.subjects?.length ?? 0;
                    return ListView.builder(
                      itemCount: length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              title: Text(
                                '${courses.subjects[courses.subjects.keys.toList()[index]].name}',
                                style: TextStyle(color: Colors.blue),
                              ),
                              trailing: Icon(
                                Icons.chevron_right,
                                color: Colors.blue,
                              ),
                              onTap: () {
                                return Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => ChapterPage(
                                      title: courses.subjects[courses.subjects.keys.toList()[index]].name,
                                      reference: FirebaseDatabase.instance
                                          .reference()
                                          .child(
                                              'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${courses.id}/subjects/${courses.subjects.keys.toList()[index]}'),
                                    ),
                                  ),
                                );
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
