import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/NewAuthentication/Frontened/NewWelcomePage.dart';
import 'package:coach_app/Student/course_registration_page.dart';
import 'package:coach_app/Utils/Colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class AllCoursePage extends StatefulWidget {
  final DatabaseReference ref;
  AllCoursePage({@required this.ref});
  @override
  _AllCoursePageState createState() => _AllCoursePageState();
}

class _AllCoursePageState extends State<AllCoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'All Courses'.tr(),
            style: GoogleFonts.portLligatSans(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: GuruCoolLightColor.whiteColor,
            ),
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                FireBaseAuth.instance.signoutWithGoogle();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => NewWelcomePage()),
                    (route) => false);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
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
                spreadRadius: 2,
              )
            ],
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 12,
                child: StreamBuilder<Event>(
                  stream: widget.ref.child('/coursesList').onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Map<String, String> courses = Map<String, String>();
                      snapshot.data.snapshot.value?.forEach((k, v) {
                        courses[k] = v;
                      });
                      return ListView.builder(
                        itemCount: courses.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: GuruCoolLightColor.primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                title: Text(
                                  '${courses[courses.keys.toList()[index]]}',
                                  style: TextStyle(
                                      color: GuruCoolLightColor.whiteColor),
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: GuruCoolLightColor.whiteColor,
                                ),
                                onTap: () => Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        CourseRegistrationPage(
                                      courseID: courses.keys.toList()[index],
                                      name:
                                          courses[courses.keys.toList()[index]],
                                      ref: widget.ref.child(
                                          'courses/${courses.keys.toList()[index]}'),
                                    ),
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
