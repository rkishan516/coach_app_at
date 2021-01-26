import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Student/all_course_view.dart';
import 'package:coach_app/Utils/SizeConfig.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/rendering.dart';

class RegistrationPage extends StatelessWidget {
  final TextEditingController instituteCode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig(context);
    return WillPopScope(
      onWillPop: () {
        FireBaseAuth.instance.signoutWithGoogle();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              left: -(sizeConfig.screenWidth * 127 / 360),
              top: -(sizeConfig.screenHeight * 119 / 640),
              child: Container(
                height: sizeConfig.screenWidth * 246 / 360,
                width: sizeConfig.screenWidth * 246 / 360,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffecedee),
                ),
              ),
            ),
            Positioned(
              left: (sizeConfig.screenWidth * 242 / 360),
              top: (sizeConfig.screenHeight * 204 / 640),
              child: Container(
                height: sizeConfig.screenWidth * 246 / 360,
                width: sizeConfig.screenWidth * 246 / 360,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xfffef4ef),
                ),
              ),
            ),
            Positioned(
              left: (sizeConfig.screenWidth * 116 / 360),
              right: (sizeConfig.screenWidth * 116 / 360),
              top: (sizeConfig.screenHeight * 129 / 640),
              child: Container(
                child: Column(
                  children: [
                    Image.asset('assets/images/guruleaf.png'),
                    SizedBox(
                      height: sizeConfig.screenHeight * 20 / 640,
                    ),
                    Container(
                      child: Text(
                        'Welcome to Gurucool!\nEnter your Institute code',
                        style: TextStyle(
                            color: Color(0xfff36c24),
                            fontSize: sizeConfig.screenWidth * 12 / 360),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: (sizeConfig.screenHeight * 42 / 640),
              left: (sizeConfig.screenWidth * 90 / 360),
              right: (sizeConfig.screenWidth * 90 / 360),
              child: GestureDetector(
                onTap: () async {
                  Student student = Student(
                      name: FireBaseAuth.instance.user.displayName,
                      address: '',
                      phoneNo: FireBaseAuth.instance.user.phoneNumber,
                      photoURL: FireBaseAuth.instance.user.photoUrl,
                      email: FireBaseAuth.instance.user.email,
                      status: 'New Student');
                  var branchCode = instituteCode.text.substring(4);
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return UploadDialog(warning: 'Checking Institute Code');
                    },
                  );
                  DataSnapshot dataSnapshot = await FirebaseDatabase.instance
                      .reference()
                      .child(
                          '/instituteList/${instituteCode.text.substring(0, 4)}')
                      .once();
                  if (dataSnapshot.value == null) {
                    Alert.instance.alert(context, 'Wrong Institute Code'.tr());
                    return;
                  }
                  DataSnapshot dataSnapshot1 = await FirebaseDatabase.instance
                      .reference()
                      .child(
                          '/institute/${dataSnapshot.value}/branches/$branchCode/name')
                      .once();
                  if (dataSnapshot1.value == null) {
                    Alert.instance.alert(context, 'Wrong Institute Code'.tr());
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
                },
                child: Container(
                  height: sizeConfig.screenHeight * 30 / 640,
                  width: sizeConfig.screenWidth * 160 / 360,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(sizeConfig.screenWidth * 5 / 360),
                    color: Color(0xfff36c24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: Offset(0.0, 2.0),
                        spreadRadius: sizeConfig.screenWidth * 0.005556 / 2,
                        blurRadius: sizeConfig.screenWidth * 0.005556 / 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                        child: Text(
                      'Proceed',
                      style: TextStyle(
                        fontSize: sizeConfig.screenWidth * 14 / 360,
                        color: Colors.white,
                      ),
                    )),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: (sizeConfig.screenHeight * 247 / 640),
              left: (sizeConfig.screenWidth * 16 / 360),
              right: (sizeConfig.screenWidth * 16 / 360),
              child: GestureDetector(
                onTap: () async {
                  //TODO: animation Section
                },
                child: Container(
                  color: Colors.white,
                  height: sizeConfig.screenHeight * 40 / 640,
                  width: sizeConfig.screenWidth * 306 / 360,
                  child: TextField(
                    controller: instituteCode,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        top: sizeConfig.screenHeight * 8 / 640,
                        left: sizeConfig.screenWidth * 16 / 360,
                      ),
                      hintText: 'Institute Code',
                      hintStyle: TextStyle(
                          color: Color(0xff848484),
                          fontSize: sizeConfig.screenWidth * 12 / 360,
                          fontWeight: FontWeight.w300),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(sizeConfig.screenWidth * 5 / 360),
                        ),
                        borderSide: BorderSide(
                            color: Color(0xffF36C24),
                            width: sizeConfig.screenWidth * 1 / 360),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(sizeConfig.screenWidth * 5 / 360),
                        ),
                        borderSide: BorderSide(
                          color: Color(0xffF36C24),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
