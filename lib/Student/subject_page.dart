import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Events/StudentEvent.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/courses/chapter_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:google_fonts/google_fonts.dart';
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
      appBar: AppBar(
        title: Text(
          'Subjects'.tr(),
          style: GoogleFonts.portLligatSans(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_alert),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentEvent(
                    courseId: widget.courseID,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
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
                        return Card(
                          child: ListTile(
                            title: Text(
                              '${courses.subjects[index].name}',
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
                                    title: courses.subjects[index].name,
                                    reference: FirebaseDatabase.instance
                                        .reference()
                                        .child(
                                            'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${courses.id}/subjects/$index'),
                                  ),
                                ),
                              );
                            },
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
    );
  }
}
