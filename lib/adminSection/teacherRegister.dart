import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TeacherRegister extends StatefulWidget {
  final bool isEdit;
  final String keyT;
  final Teacher teacher;
  TeacherRegister({this.isEdit = false, this.teacher, this.keyT});
  @override
  _TeacherRegisterState createState() => _TeacherRegisterState();
}

class _TeacherRegisterState extends State<TeacherRegister> {
  TextEditingController emailTextEditingController,
      nameTextEditingController,
      experienceTextEditingController,
      qualificationTextEditingController;

  @override
  void initState() {
    emailTextEditingController = TextEditingController()
      ..text = widget.teacher?.email ?? '';
    nameTextEditingController = TextEditingController()
      ..text = widget.teacher?.name ?? '';
    experienceTextEditingController = TextEditingController()
      ..text = widget.teacher?.experience?.toString() ?? '';
    qualificationTextEditingController = TextEditingController()
      ..text = widget.teacher?.qualification ?? '';
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
                      Text(
                        'Name'.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: nameTextEditingController,
                        keyboardType: TextInputType.emailAddress,
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
                        'Email'.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        enabled: !widget.isEdit,
                        controller: emailTextEditingController,
                        keyboardType: TextInputType.emailAddress,
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
                        'Experience'.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: experienceTextEditingController,
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
                        'Qualification'.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: qualificationTextEditingController,
                        decoration: InputDecoration(
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
                      (widget.isEdit == true)
                          ? FlatButton(
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
                                        'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/teachers')
                                    .child('${widget.keyT}')
                                    .remove();
                                Navigator.of(context).pop();
                              },
                              child: Text('Remove'.tr()))
                          : Container(),
                      FlatButton(
                        onPressed: () {
                          if (emailTextEditingController.text == '' ||
                              nameTextEditingController.text == '' ||
                              qualificationTextEditingController.text == '' ||
                              experienceTextEditingController.text == '') {
                            Alert.instance
                                .alert(context, 'Something is wrong'.tr());
                            return;
                          }
                          if (int.parse(experienceTextEditingController.text
                                      .replaceAll(',', '')
                                      .replaceAll('.', '')
                                      .replaceAll(' ', '')
                                      .replaceAll('-', '')) <
                                  0 &&
                              int.parse(experienceTextEditingController.text
                                      .replaceAll(',', '')
                                      .replaceAll('.', '')
                                      .replaceAll(' ', '')
                                      .replaceAll('-', '')) >
                                  80) {
                            Alert.instance.alert(
                                context, 'Please Provide Correct Experience');
                          }
                          if (!emailTextEditingController.text
                              .endsWith('@gmail.com')) {
                            Alert.instance.alert(
                                context, 'Only Gmail account allowed'.tr());
                            return;
                          }
                          if (widget.isEdit == true) {
                            FirebaseDatabase.instance
                                .reference()
                                .child(
                                    'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/teachers')
                                .child('${widget.keyT}')
                                .update(Teacher(
                                  name: nameTextEditingController.text,
                                  email: emailTextEditingController.text,
                                  qualification:
                                      qualificationTextEditingController.text,
                                  experience: int.parse(
                                    experienceTextEditingController.text
                                        .replaceAll(',', '')
                                        .replaceAll('.', '')
                                        .replaceAll(' ', '')
                                        .replaceAll('-', ''),
                                  ),
                                ).toJson());
                          } else {
                            Firestore.instance
                                .collection('institute')
                                .document('users')
                                .updateData({
                              emailTextEditingController.text.split('@')[0]:
                                  "teacher_${FireBaseAuth.instance.instituteid}_${FireBaseAuth.instance.branchid}"
                            });
                            FirebaseDatabase.instance
                                .reference()
                                .child(
                                    'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/teachers')
                                .push()
                                .set(Teacher(
                                  name: nameTextEditingController.text,
                                  email: emailTextEditingController.text,
                                  qualification:
                                      qualificationTextEditingController.text,
                                  experience: int.parse(
                                    experienceTextEditingController.text
                                        .replaceAll(',', '')
                                        .replaceAll('.', '')
                                        .replaceAll(' ', '')
                                        .replaceAll('-', ''),
                                  ),
                                ).toJson());
                          }
                          Navigator.of(context).pop();
                        },
                        color: Colors.white,
                        child: Text(
                          'Add Teacher'.tr(),
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
