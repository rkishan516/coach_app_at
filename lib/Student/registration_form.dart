import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/selectInstitute.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Student/WaitScreen.dart';
import 'package:coach_app/Student/all_course_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameTextEditingController,
      addressTextEditingController,
      phoneTextEditingController,
      instituteCodeTextEditingController;
  String status = 'New Student';
  DateTime dob;
  GlobalKey<ScaffoldState> _scKey;

  @override
  void initState() {
    _scKey = GlobalKey<ScaffoldState>();
    nameTextEditingController = TextEditingController();
    addressTextEditingController = TextEditingController();
    phoneTextEditingController = TextEditingController();
    instituteCodeTextEditingController = TextEditingController();
    dob = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scKey,
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Name'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: nameTextEditingController,
                  decoration: InputDecoration(
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
                Text(
                  'Address'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: addressTextEditingController,
                  decoration: InputDecoration(
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
                Text(
                  'Institute Code'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: instituteCodeTextEditingController,
                  decoration: InputDecoration(
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
                Text(
                  'Phone No'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: phoneTextEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
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
                Text(
                  'Date of Birth'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                CalendarDatePicker(
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1970),
                  lastDate: DateTime.now(),
                  onDateChanged: (v) {
                    dob = v;
                  },
                  initialCalendarMode: DatePickerMode.year,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Status'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton(
                    items: ['Existing Student', 'New Student']
                        .map(
                          (e) => DropdownMenuItem(
                            child: Text(e.tr()),
                            value: e,
                          ),
                        )
                        .toList(),
                    value: status,
                    onChanged: (value) {
                      setState(() {
                        status = value;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          RaisedButton(
            color: Colors.orange,
            onPressed: () async {
              if (nameTextEditingController.text != '' &&
                  addressTextEditingController.text != '' &&
                  phoneTextEditingController.text != '' &&
                  instituteCodeTextEditingController.text != '') {
                Student student = Student(
                    name: nameTextEditingController.text,
                    address: addressTextEditingController.text,
                    phoneNo: phoneTextEditingController.text,
                    photoURL: FireBaseAuth.instance.user.photoUrl,
                    email: FireBaseAuth.instance.user.email,
                    status: status);
                var branchCode =
                    instituteCodeTextEditingController.text.substring(4);
                DataSnapshot dataSnapshot = await FirebaseDatabase.instance
                    .reference()
                    .child(
                        '/instituteList/${instituteCodeTextEditingController.text.substring(0, 4)}')
                    .once();
                DatabaseReference reference = FirebaseDatabase.instance
                    .reference()
                    .child(
                        "institute/${dataSnapshot.value}/branches/$branchCode/");
                if (status == 'Existing Student') {
                  String course = await showDialog(
                    context: context,
                    builder: (context) => SelectInstituteCourse(
                      databaseReference: reference,
                    ),
                    barrierDismissible: false,
                  );
                  if (course != null && course != '') {
                    student.classs = course;
                    reference
                        .child('students/${FireBaseAuth.instance.user.uid}')
                        .set(student.toJson());
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return WaitScreen();
                    }));
                  }
                } else {
                  reference
                      .child('students/${FireBaseAuth.instance.user.uid}')
                      .set(student.toJson());
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    return AllCoursePage(
                      ref: reference,
                    );
                  }), (route) => false);
                }
              } else {
                _scKey.currentState.showSnackBar(
                    SnackBar(content: Text('Something remains Unfilled')));
              }
            },
            child: Text('Register'.tr()),
          )
        ],
      ),
    );
  }
}
