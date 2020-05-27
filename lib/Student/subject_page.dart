import 'package:coach_app/Models/model.dart';
import 'package:coach_app/courses/chapter_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectPage extends StatefulWidget {
  final String courseID;
  SubjectPage({@required this.courseID});
  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff519ddb), Color(0xff54d179)])),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Subjects',
                      style: GoogleFonts.portLligatSans(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 12,
                child: StreamBuilder<Event>(
                  stream: FirebaseDatabase.instance
                      .reference()
                      .child("institute")
                      .child("0")
                      .child("courses")
                      .child(widget.courseID.toString())
                      .child('subjects')
                      .onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Subjects> subjects = List<Subjects>();
                      snapshot.data.snapshot.value.forEach((subject) {
                        subjects.add(Subjects.fromJson(subject));
                      });
                      return ListView.builder(
                        itemCount: subjects.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              child: ListTile(
                            title: Text(
                              '${subjects[index].name}',
                              style: TextStyle(color: Colors.blue),
                            ),
                            trailing: Icon(
                              Icons.chevron_right,
                              color: Colors.blue,
                            ),
                            onTap: () => Navigator.of(context).push(
                                CupertinoPageRoute(
                                    builder: (context) => ChapterPage())),
                          ));
                        },
                      );
                    } else {
                      return ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
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
      ),
    );
  }
}
