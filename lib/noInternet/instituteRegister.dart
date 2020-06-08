import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Authentication/welcome_page.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/SucessDialog.dart';
import 'package:coach_app/Dialogs/infoDialog.dart';
import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/GlobalFunction/VyCode.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';

class InstituteRegister extends StatefulWidget {
  @override
  _InstituteRegisterState createState() => _InstituteRegisterState();
}

class _InstituteRegisterState extends State<InstituteRegister> {
  TextEditingController nameTextEditingController,
      phoneNoTextEditingController,
      branch1NameTextEditingController,
      branch1UpiIdTextEditiingController,
      branch1addressTextEditingController,
      branch1CodeTextEditingController,
      branch1AdminTextEditingController;
  GlobalKey<ScaffoldState> _scKey;

  File _image;

  Future getImage() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile?.path);
    });
  }

  @override
  void initState() {
    _scKey = GlobalKey<ScaffoldState>();
    phoneNoTextEditingController = TextEditingController();
    nameTextEditingController = TextEditingController();
    branch1UpiIdTextEditiingController = TextEditingController();
    branch1AdminTextEditingController = TextEditingController();
    branch1CodeTextEditingController = TextEditingController();
    branch1NameTextEditingController = TextEditingController();
    branch1addressTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scKey,
      body: Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Institute Registration'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                controller: nameTextEditingController,
                onChanged: (value) {
                  setState(() {
                    branch1NameTextEditingController.text = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Color(0xfff3f3f4),
                    ),
                  ),
                  contentPadding: EdgeInsets.only(left: 10),
                  hintStyle: TextStyle(fontSize: 15),
                  hintText: 'Institute Name'.tr(),
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                controller: phoneNoTextEditingController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Color(0xfff3f3f4),
                    ),
                  ),
                  contentPadding: EdgeInsets.only(left: 10),
                  hintStyle: TextStyle(fontSize: 15),
                  hintText: 'Phone No'.tr(),
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                controller: branch1NameTextEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Color(0xfff3f3f4),
                    ),
                  ),
                  contentPadding: EdgeInsets.only(left: 10),
                  hintStyle: TextStyle(fontSize: 15),
                  hintText: 'Main Branch Name'.tr(),
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                controller: branch1addressTextEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Color(0xfff3f3f4),
                    ),
                  ),
                  contentPadding: EdgeInsets.only(left: 10),
                  hintStyle: TextStyle(fontSize: 15),
                  hintText: 'Main Branch Address'.tr(),
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: branch1UpiIdTextEditiingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Color(0xfff3f3f4),
                          ),
                        ),
                        contentPadding: EdgeInsets.only(left: 10),
                        hintStyle: TextStyle(fontSize: 15),
                        hintText: 'Main Branch'.tr() + 'UPI ID'.tr(),
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                      ),
                    ),
                  ),
                  Expanded(
                      child: InkWell(
                        child: CircleAvatar(
                          radius: 15,
                          child: Text('?'),
                        ),
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => InfoDialog(
                            infoString:
                                'You will  be able to collect fee from students of respective branches on bank account registered with this UPI ID'.tr(),
                          ),
                        ),
                      ),
                      flex: 1),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                controller: branch1AdminTextEditingController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Color(0xfff3f3f4),
                    ),
                  ),
                  contentPadding: EdgeInsets.only(left: 10),
                  hintStyle: TextStyle(fontSize: 15),
                  hintText: 'Main Branch Admin Email'.tr(),
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                controller: branch1CodeTextEditingController,
                maxLength: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Color(0xfff3f3f4),
                    ),
                  ),
                  contentPadding: EdgeInsets.only(left: 10),
                  hintStyle: TextStyle(fontSize: 15),
                  hintText: 'Main Branch Code'.tr(),
                  helperText:
                      "Make your own branch code for easy references. eg : 1101".tr(),
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.orange,
                      onPressed: () async {
                        try {
                          await getImage();
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text('Institute Logo'.tr()),
                    ),
                  ),
                ),
                Expanded(child: Container(), flex: 1),
                Expanded(
                  flex: 2,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.orange,
                    onPressed: () {
                      if (nameTextEditingController.text != '' &&
                          phoneNoTextEditingController.text != '' &&
                          branch1UpiIdTextEditiingController.text != '' &&
                          branch1AdminTextEditingController.text != '' &&
                          branch1CodeTextEditingController.text != '' &&
                          branch1NameTextEditingController.text != '' &&
                          branch1addressTextEditingController.text != '') {
                        if (!branch1AdminTextEditingController.text
                            .endsWith('@gmail.com')) {
                          Alert.instance.alert(
                              context, 'Only Gmail account allowed'.tr());
                          return;
                        }
                        if (!branch1UpiIdTextEditiingController.text
                            .contains('@')) {
                          Alert.instance.alert(context, 'Wrong UPI ID'.tr());
                          return;
                        }
                        if (_image == null) {
                          Alert.instance.alert(
                              context, 'Please select Institute Logo'.tr());
                          return;
                        }
                        FireBaseAuth.instance
                            .signInWithGoogle(context)
                            .then((value) async {
                          if (value != null) {
                            showDialog(
                                context: context,
                                builder: (context) => UploadDialog(
                                      warning: 'Uploading Logo'.tr(),
                                    ));
                            StorageTaskSnapshot storageTaskSnapshot =
                                await FirebaseStorage.instance
                                    .ref()
                                    .child(
                                        '/instituteLogo/${nameTextEditingController.text}')
                                    .putFile(_image)
                                    .onComplete;
                            showDialog(
                                context: context,
                                builder: (context) => UploadDialog(
                                      warning: 'Registering Institute'.tr(),
                                    ));
                            DatabaseReference reference = FirebaseDatabase
                                .instance
                                .reference()
                                .child('/institute')
                                .push();
                            reference.set({
                              "name": nameTextEditingController.text,
                              "Phone No": phoneNoTextEditingController.text,
                              "mainBranchCode":
                                  branch1CodeTextEditingController.text,
                              "admin": {
                                value.uid: Admin(
                                        email: value.email,
                                        name: value.displayName)
                                    .toJson()
                              },
                              "paid": 'Trial',
                              "logo": storageTaskSnapshot.storageMetadata.path,
                              "branches": {
                                branch1CodeTextEditingController.text: Branch(
                                  name: branch1NameTextEditingController.text,
                                  address:
                                      branch1addressTextEditingController.text,
                                  admin: {
                                    "${branch1AdminTextEditingController.text.hashCode}":
                                        Admin(
                                      email: branch1AdminTextEditingController
                                          .text,
                                    )
                                  },
                                  upiId:
                                      branch1UpiIdTextEditiingController.text,
                                ).toJson()
                              }
                            });
                            showDialog(
                              context: context,
                              builder: (context) => UploadDialog(
                                warning: 'Granting access'.tr(),
                              ),
                            );
                            if (value.email !=
                                branch1AdminTextEditingController.text) {
                              Firestore.instance
                                  .collection('institute')
                                  .document('users')
                                  .updateData({
                                branch1AdminTextEditingController.text
                                        .split('@')[0]:
                                    "subAdmin_${reference.key}_${branch1CodeTextEditingController.text}"
                              });
                            }
                            DataSnapshot snap = await FirebaseDatabase.instance
                                .reference()
                                .child('/instituteList')
                                .orderByKey()
                                .limitToLast(1)
                                .once();

                            await FirebaseDatabase.instance
                                .reference()
                                .child('/instituteList')
                                .child(VyCode.instance
                                    .getNextVyCode(snap.value.keys.toList()[0]))
                                .set(reference.key);
                            showDialog(
                                context: context,
                                builder: (context) => SuccessDialog(
                                    success:
                                        'Your Institute has been successfully Registered'.tr()));
                            await Future.delayed(Duration(seconds: 2));
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => WelcomePage()),
                                (route) => false);
                          } else {
                            _scKey.currentState.showSnackBar(
                                SnackBar(content: Text('Login Failed'.tr())));
                          }
                        });
                      } else {
                        _scKey.currentState.showSnackBar(
                            SnackBar(content: Text('Something is wrong'.tr())));
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Register'.tr()),
                        Icon(Icons.keyboard_arrow_right)
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
