import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Authentication/welcome_page.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class InstituteRegister extends StatefulWidget {
  @override
  _InstituteRegisterState createState() => _InstituteRegisterState();
}

class _InstituteRegisterState extends State<InstituteRegister> {
  TextEditingController nameTextEditingController,
      addressTextEditingController,
      branch1NameTextEditingController,
      branch1addressTextEditingController,
      branch1CodeTextEditingController,
      branch1AdminTextEditingController;
  GlobalKey<ScaffoldState> _scKey;

  @override
  void initState() {
    _scKey = GlobalKey<ScaffoldState>();
    nameTextEditingController = TextEditingController();
    addressTextEditingController = TextEditingController();
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
                  addressTextEditingController.text != '' &&
                  branch1AdminTextEditingController.text != '' &&
                  branch1CodeTextEditingController.text != '' &&
                  branch1NameTextEditingController.text != '' &&
                  branch1addressTextEditingController.text != '') {
                FireBaseAuth.instance.signInWithGoogle().then((value) {
                  if (value != null) {
                    FirebaseDatabase.instance
                        .reference()
                        .child('/institute')
                        .push()
                        .set({
                      "name": nameTextEditingController.text,
                      "address": addressTextEditingController.text,
                      "admin": [value.email],
                      "branches": {
                        branch1CodeTextEditingController.text: Institute(
                            name: branch1NameTextEditingController.text,
                            address: branch1addressTextEditingController.text,
                            admin: [
                              branch1AdminTextEditingController.text
                            ]).toJson()
                      }
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
                    SnackBar(content: Text('Something remains Unfilled'.tr())));
              }
            },
            child: Text('Register'.tr()),
          )
        ],
      ),
    );
  }
}
