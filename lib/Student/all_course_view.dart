import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Student/course_registration_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:google_fonts/google_fonts.dart';

class AllCoursePage extends StatefulWidget {
  @override
  _AllCoursePageState createState() => _AllCoursePageState();
}

class _AllCoursePageState extends State<AllCoursePage> {
  List<String> courses = [
    '1st',
    '2nd',
    '3rd',
    '4th',
    '5th',
    '6th',
    '7th',
    '8th',
    '9th',
    '10th',
    '11th PCM',
    '11th PCB',
    '12th PCM',
    '12th PCB'
  ];
  List<int> prices = [
    1000,
    2000,
    3000,
    4000,
    5000,
    6000,
    7000,
    8000,
    9000,
    10000,
    11000,
    11000,
    12000,
    12000
  ];
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
                  spreadRadius: 2,
                )
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
                      text: 'All Courses',
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
                      .child('institute')
                      .child("0/branch/0")
                      .onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Institute institute =
                          Institute.fromJson(snapshot.data.snapshot.value);
                      return ListView.builder(
                        itemCount: institute.courses.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                '${institute.courses[index].name}',
                                style: TextStyle(color: Colors.blue),
                              ),
                              subtitle: Text(
                                'Price: ${institute.courses[index].price}',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              trailing: Icon(
                                Icons.chevron_right,
                                color: Colors.blue,
                              ),
                              onTap: () => Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => CourseRegistrationPage(
                                    course: institute.courses[index],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return ListView.builder(
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              title: PlaceholderLines(
                                count: 1,
                                animate: true,
                              ),
                              subtitle: PlaceholderLines(
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
