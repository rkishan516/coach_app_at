import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ReplaceSubAdmin extends StatefulWidget {
  @override
  _ReplaceSubAdminState createState() => _ReplaceSubAdminState();
}

class _ReplaceSubAdminState extends State<ReplaceSubAdmin> {
  TextEditingController emailTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
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
                    controller: emailTextEditingController,
                    decoration: InputDecoration(
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      hintText: 'Email'.tr(),
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
              child: FlatButton(
                onPressed: () async {
                  if (emailTextEditingController.text == '' &&
                      !emailTextEditingController.text.endsWith('@gmail.com')) {
                    Alert.instance
                        .alert(context, 'Only Gmail account allowed'.tr());
                    return;
                  }

                  String res = await showDialog(
                      context: context, builder: (context) => AreYouSure());
                  if (res != 'Yes') {
                    return;
                  }
                  FirebaseDatabase.instance
                      .reference()
                      .child(
                          'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/')
                      .update({
                    "admin": {
                      emailTextEditingController.text.hashCode.toString(): {
                        "email": emailTextEditingController.text
                      }
                    },
                  });
                  if (emailTextEditingController.text !=
                      FireBaseAuth.instance.user.email) {
                    Firestore.instance
                        .collection('institute')
                        .document(emailTextEditingController.text.split('@')[0])
                        .setData({
                      "value":
                          "subAdmin_${FireBaseAuth.instance.instituteid}_${FireBaseAuth.instance.branchid}"
                    });
                  }

                  Navigator.of(context).pop();
                },
                child: Text('Replace Sub Admin'.tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
