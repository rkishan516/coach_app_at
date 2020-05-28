import 'package:coach_app/Models/model.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CourseRegistrationPage extends StatefulWidget {
  final Courses course;
  CourseRegistrationPage({@required this.course});
  @override
  _CourseRegistrationPageState createState() => _CourseRegistrationPageState();
}

class _CourseRegistrationPageState extends State<CourseRegistrationPage> {
  @override
  Widget build(BuildContext context) {
    List<String> teachers = List<String>();
    widget.course.subjects.forEach((subject) {
      subject.mentor.forEach((mentor) {
        teachers.add(mentor);
      });
    });
    Size size = MediaQuery.of(context).size;
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
              colors: [
                Color(0xff519ddb),
                Color(0xff54d179),
              ],
            ),
          ),
          child: ListView(
            children: <Widget>[
              Center(
                child: Text(
                  widget.course.name,
                  style: TextStyle(color: Colors.white, fontSize: 32.0),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                child: Container(
                  margin: EdgeInsets.all(20.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Center(
                          child: Text(
                        'Course Description'.tr(),
                        style: TextStyle(fontSize: 22.0),
                      )),
                      SizedBox(height: 20.0),
                      Text(
                        widget.course.description,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 20.0),
                      Center(
                        child: Text(
                          'Mentors'.tr(),
                          style: TextStyle(fontSize: 22.0),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: teachers.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(
                              '${index + 1}. ${teachers[index]}',
                              style: TextStyle(fontSize: 16.0),
                            );
                          }),
                    ],
                  ),
                  width: size.width,
                  height: 400,
                  color: Colors.white,
                ),
              ),
              Card(
                child: FlatButton(
                  child: Text('Buy Course @ Rs.'.tr() + ' ${widget.course.price}'),
                  onPressed: () {
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Registration Successful'.tr(),style: TextStyle(color: Colors.blue),)));
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
