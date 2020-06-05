import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Authentication/welcome_page.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/SucessDialog.dart';
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
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Institute Name'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: nameTextEditingController,
                  onChanged: (value) {
                    setState(() {
                      branch1NameTextEditingController.text = value;
                    });
                  },
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
                  controller: phoneNoTextEditingController,
                  keyboardType: TextInputType.phone,
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
            child: FlatButton(
              color: Colors.orange[100],
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
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Main Branch Name'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: branch1NameTextEditingController,
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
                  'Main Branch Address'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: branch1addressTextEditingController,
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
                Row(
                  children: <Widget>[
                    Text(
                      'Main Branch'.tr() + 'UPI ID'.tr(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      child: CircleAvatar(
                        radius: 10,
                        child: Text('?'),
                      ),
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'This UPI ID is used for payment from student',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: branch1UpiIdTextEditiingController,
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
                  'Main Branch Admin Email'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: branch1AdminTextEditingController,
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
                  'Main Branch Code'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: branch1CodeTextEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'e.g. 1101',
                    fillColor: Color(0xfff3f3f4),
                    filled: true,
                  ),
                )
              ],
            ),
          ),
          RaisedButton(
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
                  Alert.instance
                      .alert(context, 'Only Gmail account allowed'.tr());
                  return;
                }
                if (!branch1UpiIdTextEditiingController.text.contains('@')) {
                  Alert.instance.alert(context, 'Wrong UPI ID');
                  return;
                }
                if (_image == null) {
                  Alert.instance
                      .alert(context, 'Please select Institute Logo'.tr());
                  return;
                }
                FireBaseAuth.instance.signInWithGoogle().then((value) async {
                  if (value != null) {
                    showDialog(
                        context: context,
                        builder: (context) => UploadDialog(
                              warning: 'Uploading Logo',
                            ));
                    StorageTaskSnapshot storageTaskSnapshot = await FirebaseStorage
                        .instance
                        .ref()
                        .child(
                            '/instituteLogo/${nameTextEditingController.text}')
                        .putFile(_image)
                        .onComplete;
                    showDialog(
                        context: context,
                        builder: (context) => UploadDialog(
                              warning: 'Registering Institute',
                            ));
                    DatabaseReference reference = FirebaseDatabase.instance
                        .reference()
                        .child('/institute')
                        .push();
                    reference.set({
                      "name": nameTextEditingController.text,
                      "Phone No": phoneNoTextEditingController.text,
                      "mainBranchCode": branch1CodeTextEditingController.text,
                      "admin": {
                        value.uid:
                            Admin(email: value.email, name: value.displayName)
                                .toJson()
                      },
                      "paid": 'Trial',
                      "logo": storageTaskSnapshot.storageMetadata.path,
                      "branches": {
                        branch1CodeTextEditingController.text: Branch(
                          name: branch1NameTextEditingController.text,
                          address: branch1addressTextEditingController.text,
                          admin: {
                            "${branch1AdminTextEditingController.text.hashCode}":
                                Admin(
                              email: branch1AdminTextEditingController.text,
                            )
                          },
                          upiId: branch1UpiIdTextEditiingController.text,
                        ).toJson()
                      }
                    });
                    showDialog(
                      context: context,
                      builder: (context) => UploadDialog(
                        warning: 'Granting access',
                      ),
                    );
                    if (value.email != branch1AdminTextEditingController.text) {
                      Firestore.instance
                          .collection('institute')
                          .document('users')
                          .updateData({
                        branch1AdminTextEditingController.text.split('@')[0]:
                            "subAdmin_${FireBaseAuth.instance.instituteid}_${branch1CodeTextEditingController.text}"
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
                                'Your Institute has been successfully Registered'));
                    await Future.delayed(Duration(seconds: 2));
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => WelcomePage()),
                        (route) => false);
                  } else {
                    _scKey.currentState
                        .showSnackBar(SnackBar(content: Text('Login Failed')));
                  }
                });
              } else {
                _scKey.currentState.showSnackBar(
                    SnackBar(content: Text('Something is wrong'.tr())));
              }
            },
            child: Text('Register'.tr()),
          )
        ],
      ),
    );
  }
}
