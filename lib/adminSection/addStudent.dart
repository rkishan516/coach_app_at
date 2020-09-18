import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddStudent extends StatefulWidget {
  final String courseId;
  AddStudent({this.courseId});
  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  TextEditingController emailTextEditingController,
      nameTextEditingController,
      addressTextEditingController,
      phoneTextEditingController;
  String courseName;

  @override
  void initState() {
    emailTextEditingController = TextEditingController();
    nameTextEditingController = TextEditingController();
    addressTextEditingController = TextEditingController();
    phoneTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(
              16.0,
            ),
            margin: EdgeInsets.only(top: 66.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
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
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                          hintText: 'Name',
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
                        controller: emailTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
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
                        controller: phoneTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                          hintText: 'Phone No',
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
                        controller: addressTextEditingController,
                        decoration: InputDecoration(
                          hintText: 'Address',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                          border: InputBorder.none,
                          fillColor: Color(0xfff3f3f4),
                          filled: true,
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          if (emailTextEditingController.text == '' ||
                              nameTextEditingController.text == '' ||
                              addressTextEditingController.text == '' ||
                              phoneTextEditingController.text == '') {
                            Alert.instance.alert(context, 'Something is wrong');
                            return;
                          }
                          if (widget.courseId != null) {
                            DataSnapshot snapShot = await FirebaseDatabase
                                .instance
                                .reference()
                                .child(
                                    'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseId}/name')
                                .once();
                            courseName = snapShot.value;
                          }
                          if (!emailTextEditingController.text
                              .endsWith('@gmail.com')) {
                            Alert.instance
                                .alert(context, 'Only Gmail account allowed');
                            return;
                          }

                          if (emailTextEditingController.text !=
                              FireBaseAuth.instance.user.email) {
                            Firestore.instance
                                .collection('institute')
                                .document(emailTextEditingController.text
                                    .split('@')[0])
                                .setData({
                              "value":
                                  "student_${FireBaseAuth.instance.instituteid}_${FireBaseAuth.instance.branchid}"
                            });
                          }
                          FirebaseDatabase.instance
                              .reference()
                              .child(
                                  'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/student')
                              .push()
                              .update(Student(
                                      name: nameTextEditingController.text,
                                      email: emailTextEditingController.text,
                                      phoneNo: phoneTextEditingController.text,
                                      address:
                                          addressTextEditingController.text,
                                      course: [
                                        Course(
                                            academicYear:
                                                DateTime.now().year.toString() +
                                                    " - " +
                                                    (DateTime.now().year + 1)
                                                        .toString(),
                                            courseID: widget.courseId,
                                            courseName: courseName,
                                            paymentToken:
                                                "Registered By ${FireBaseAuth.instance.user.displayName}"),
                                      ],
                                      status: 'Registered')
                                  .toJson());
                          Navigator.of(context).pop();
                        },
                        color: Colors.white,
                        child: Text(
                          'Add Student',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
