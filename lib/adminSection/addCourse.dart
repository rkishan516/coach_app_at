import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:coach_app/courses/subject_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AddCourse extends StatefulWidget {
  final String name;
  final String description;
  final String medium;
  final String price;
  final String id;
  final Map<String, Subjects> subjects;
  AddCourse(
      {this.name = '',
      this.description = '',
      this.medium = '',
      this.price = '',
      this.id = '',
      this.subjects});
  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  TextEditingController nameTextEditingController;
  TextEditingController descriptionTextEditingController;
  TextEditingController mediumTextEditingController;
  TextEditingController priceTextEditingController;

  @override
  void initState() {
    nameTextEditingController = TextEditingController()..text = widget.name;
    descriptionTextEditingController = TextEditingController()
      ..text = widget.description;
    mediumTextEditingController = TextEditingController()..text = widget.medium;
    priceTextEditingController = TextEditingController()..text = widget.price;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: nameTextEditingController,
                    decoration: InputDecoration(
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      hintText: 'Course Name'.tr(),
                      border: InputBorder.none,
                      fillColor: Color(0xfff3f3f4),
                      filled: true,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: descriptionTextEditingController,
                    decoration: InputDecoration(
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      hintText: 'Course Description'.tr(),
                      border: InputBorder.none,
                      fillColor: Color(0xfff3f3f4),
                      filled: true,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: mediumTextEditingController,
                    decoration: InputDecoration(
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      hintText: 'Medium'.tr(),
                      border: InputBorder.none,
                      fillColor: Color(0xfff3f3f4),
                      filled: true,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 9,
                        child: TextField(
                          controller: priceTextEditingController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            hintText: 'Fee'.tr(),
                            border: InputBorder.none,
                            fillColor: Color(0xfff3f3f4),
                            filled: true,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '₹',
                          style: TextStyle(fontSize: 25),
                        ),
                      )),
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  (widget.id == '')
                      ? Container()
                      : FlatButton(
                          onPressed: () async {
                            String res = await showDialog(
                                context: context,
                                builder: (context) => AreYouSure());
                            if (res != 'Yes') {
                              return;
                            }
                            FirebaseDatabase.instance
                                .reference()
                                .child(
                                    'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.id}')
                                .remove();
                            FirebaseDatabase.instance
                                .reference()
                                .child(
                                    'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/coursesList/${widget.id}')
                                .remove();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Remove'.tr(),
                          ),
                        ),
                  FlatButton(
                    onPressed: () {
                      if (nameTextEditingController.text == '') {
                        Alert.instance.alert(context,
                            'Please Enter the course '.tr(args: ['Name'.tr()]));
                        return;
                      }
                      if (descriptionTextEditingController.text == '') {
                        Alert.instance.alert(
                            context,
                            'Please Enter the course '
                                .tr(args: ['Description'.tr()]));
                        return;
                      }
                      if (mediumTextEditingController.text == '') {
                        Alert.instance.alert(
                            context,
                            'Please Enter the course '
                                .tr(args: ['Medium'.tr()]));
                        return;
                      }
                      if (priceTextEditingController.text == '') {
                        Alert.instance.alert(context,
                            'Please Enter the course '.tr(args: ['Fee'.tr()]));
                        return;
                      }
                      Courses course = Courses(
                        name:
                            nameTextEditingController.text.capitalize().trim(),
                        description: descriptionTextEditingController.text
                            .capitalize()
                            .trim(),
                        date: DateTime.now().toIso8601String(),
                        medium: mediumTextEditingController.text
                            .capitalize()
                            .trim(),
                        price: int.parse(priceTextEditingController.text),
                        subjects: widget.subjects,
                        id: (widget.id == '')
                            ? nameTextEditingController.text.hashCode.toString()
                            : widget.id,
                      );
                      FirebaseDatabase.instance
                          .reference()
                          .child(
                              'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${course.id}')
                          .update(course.toJson());
                      FirebaseDatabase.instance
                          .reference()
                          .child(
                              'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/coursesList/')
                          .update({course.id: course.name});

                      Navigator.of(context).pop();
                    },
                    child: Text('Add Course'.tr()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
