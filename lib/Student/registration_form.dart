import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Student/all_course_view.dart';
import 'package:coach_app/Utils/Colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';

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
  GlobalKey<FormState> _formKey;
  GlobalKey<ScaffoldState> _scKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _scKey = GlobalKey<ScaffoldState>();
    nameTextEditingController = TextEditingController();
    addressTextEditingController = TextEditingController();
    phoneTextEditingController = TextEditingController();
    instituteCodeTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scKey,
      appBar: AppBar(
        backgroundColor: GuruCoolLightColor.whiteColor,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: GuruCoolLightColor.primaryColor,
            ),
            onPressed: () {
              FireBaseAuth.instance.signoutWithGoogle();
              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(builder: (context) => NewWelcomePage()),
              //     (route) => false);
            }),
        title: Text(
          'Registration Form'.tr(),
          style: GoogleFonts.portLligatSans(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: GuruCoolLightColor.primaryColor,
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
                  color: GuruCoolLightColor.backgroundShade,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  GuruCoolLightColor.whiteColor,
                  GuruCoolLightColor.primaryColor
                ])),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
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
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your institute code';
                          }
                          return null;
                        },
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
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (value.length < 10) {
                            return 'Please enter correct phone number';
                          }
                          return null;
                        },
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
                RaisedButton(
                  color: GuruCoolLightColor.whiteColor,
                  elevation: 0.0,
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    if (nameTextEditingController.text != '' &&
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
                      DataSnapshot dataSnapshot = await FirebaseDatabase
                          .instance
                          .reference()
                          .child(
                              '/instituteList/${instituteCodeTextEditingController.text.substring(0, 4)}')
                          .once();
                      if (dataSnapshot.value == null) {
                        Alert.instance
                            .alert(context, 'Wrong Institute Code'.tr());
                        return;
                      }
                      DataSnapshot dataSnapshot1 = await FirebaseDatabase
                          .instance
                          .reference()
                          .child(
                              '/institute/${dataSnapshot.value}/branches/$branchCode/name')
                          .once();
                      if (dataSnapshot1.value == null) {
                        Alert.instance
                            .alert(context, 'Wrong Institute Code'.tr());
                        return;
                      }
                      FireBaseAuth.instance.prefs
                          .setString('insCode', dataSnapshot.value);
                      FireBaseAuth.instance.prefs
                          .setString('branchCode', branchCode);
                      DatabaseReference reference = FirebaseDatabase.instance
                          .reference()
                          .child(
                              "institute/${dataSnapshot.value}/branches/$branchCode/");

                      reference
                          .child('students/${FireBaseAuth.instance.user.uid}')
                          .update(student.toJson());
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) {
                        return AllCoursePage(
                          ref: reference,
                        );
                      }), (route) => false);
                    } else {
                      // _scKey.currentState.showSnackBar(
                      //   SnackBar(
                      //     content: Text(
                      //       'Something remains unfilled'.tr(),
                      //     ),
                      //   ),
                      // );
                    }
                  },
                  child: Text('Register'.tr()),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
