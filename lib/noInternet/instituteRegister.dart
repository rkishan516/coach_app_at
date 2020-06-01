import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Authentication/welcome_page.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/uploadDialog.dart';
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
                if (_image == null) {
                  Alert.instance
                      .alert(context, 'Please select Institute Logo'.tr());
                  return;
                }
                FireBaseAuth.instance.signInWithGoogle().then((value) async {
                  if (value != null) {
                    showDialog(context: context,builder: (context) => UploadDialog());
                    StorageTaskSnapshot storageTaskSnapshot = await FirebaseStorage.instance.ref().child('/instituteLogo/${nameTextEditingController.text}').putFile(_image).onComplete;
                    Navigator.of(context).pop();
                    FirebaseDatabase.instance
                        .reference()
                        .child('/institute')
                        .push()
                        .set({
                      "name": nameTextEditingController.text,
                      "Phone No": phoneNoTextEditingController.text,
                      "admin": [value.email],
                      "paid" : "false",
                      "logo" : storageTaskSnapshot.storageMetadata.path,
                      "branches": {
                        branch1CodeTextEditingController.text: Institute(
                            name: branch1NameTextEditingController.text,
                            address: branch1addressTextEditingController.text,
                            admin: [
                              branch1AdminTextEditingController.text
                            ]).toJson()
                      }
                    });
                    Timer(Duration(seconds: 3), () async {
                      Firestore.instance
                          .collection('institute')
                          .document('users')
                          .setData({
                        branch1AdminTextEditingController.text:
                            "subAdmin_${FireBaseAuth.instance.instituteid}_${branch1CodeTextEditingController.text}"
                      });
                    });
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
