import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Authentication/welcome_page.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/selectInstitute.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Student/WaitScreen.dart';
import 'package:coach_app/Student/all_course_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  SharedPreferences preferences;
  GlobalKey<ScaffoldState> _scKey;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      preferences = value;
    });
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.deepOrange,
            ),
            onPressed: () {
              FireBaseAuth.instance.signoutWithGoogle();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => WelcomePage()),
                  (route) => false);
            }),
        title: Text(
          'Registration Form'.tr(),
          style: GoogleFonts.portLligatSans(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.deepOrange,
          ),
        ),
      ),
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
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.deepOrange])),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      controller: nameTextEditingController,
                      decoration: InputDecoration(
                        hintText: 'Name'.tr(),
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
                      controller: addressTextEditingController,
                      decoration: InputDecoration(
                        hintText: 'Address'.tr(),
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
                      controller: instituteCodeTextEditingController,
                      decoration: InputDecoration(
                        hintText: 'Institute Code'.tr(),
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Phone No'.tr(),
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
                    Text(
                      'Date of Birth'.tr(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: CalendarDatePicker(
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1970),
                        lastDate: DateTime.now(),
                        onDateChanged: (v) {
                          dob = v;
                        },
                        initialCalendarMode: DatePickerMode.year,
                      ),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
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
                      ),
                    )
                  ],
                ),
              ),
              RaisedButton(
                color: Colors.white,
                elevation: 0.0,
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
                    if (dataSnapshot.value == null) {
                      Alert.instance
                          .alert(context, 'Wrong Institute Code'.tr());
                      return;
                    }
                    DataSnapshot dataSnapshot1 = await FirebaseDatabase.instance.reference()
                        .child(
                            '/institute/${dataSnapshot.value}/branches/$branchCode/name')
                        .once();
                    if (dataSnapshot1.value == null) {
                      Alert.instance
                          .alert(context, 'Wrong Institute Code'.tr());
                      return;
                    }
                    preferences.setString('insCode', dataSnapshot.value);
                    preferences.setString('branchCode', branchCode);
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
                            .update(student.toJson());
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                          builder: (context) {
                            return WaitScreen();
                          },
                        ), (route) => false);
                      }
                    } else {
                      reference
                          .child('students/${FireBaseAuth.instance.user.uid}')
                          .update(student.toJson());
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) {
                        return AllCoursePage(
                          ref: reference,
                        );
                      }), (route) => false);
                    }
                  } else {
                    _scKey.currentState.showSnackBar(SnackBar(
                        content: Text('Something remains unfilled'.tr())));
                  }
                },
                child: Text('Register'.tr()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
