import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class BranchRegister extends StatefulWidget {
  final Institute institute;
  final String branchCode;
  BranchRegister({this.institute, this.branchCode});
  @override
  _BranchRegisterState createState() => _BranchRegisterState();
}

class _BranchRegisterState extends State<BranchRegister> {
  TextEditingController nameTextEditingController,
      branchCodeTextEditingController,
      adminEmailTextEditingController,
      addressTextEditingController;
  Widget errorBox;
  bool isEnable;

  @override
  void initState() {
    errorBox = Container();
    nameTextEditingController = TextEditingController()
      ..text = widget.institute?.name ?? '';
    branchCodeTextEditingController = TextEditingController()
      ..text = widget?.branchCode ?? '';
    addressTextEditingController = TextEditingController()
      ..text = widget.institute?.address ?? '';
    adminEmailTextEditingController = TextEditingController();
    if (widget.institute?.name == null &&
        widget.institute?.address == null &&
        widget.institute?.admin == null &&
        widget.branchCode == null) {
      adminEmailTextEditingController.text = '';
      isEnable = true;
    } else {
      adminEmailTextEditingController.text = widget.institute.admin[0];
      isEnable = false;
    }
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
                        'Name of branch'.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
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
                        'Email of sub-admin'.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        enabled: isEnable,
                        controller: adminEmailTextEditingController,
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
                        'Address of branch'.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
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
                        'Code of branch'.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        enabled: isEnable,
                        controller: branchCodeTextEditingController,
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
                errorBox,
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    onPressed: () {
                      if (adminEmailTextEditingController.text != '' &&
                          adminEmailTextEditingController.text
                              .endsWith('@gmail.com') &&
                          nameTextEditingController.text != '' &&
                          addressTextEditingController.text != '' &&
                          branchCodeTextEditingController.text != '') {
                        DatabaseReference ref = FirebaseDatabase.instance
                            .reference()
                            .child(
                                'institute/${FireBaseAuth.instance.instituteid}/branches/${branchCodeTextEditingController.text}');
                        if (widget.branchCode != null) {
                          widget.institute.name =
                              nameTextEditingController.text;
                          widget.institute.address =
                              addressTextEditingController.text;
                          ref.set(widget.institute.toJson());
                          Navigator.of(context).pop();
                          return;
                        }

                        ref.child('name').once().then((value) {
                          if (value.value != null) {
                            setState(() {
                              errorBox = Container(
                                height: 40,
                                color: Colors.orange,
                                child: Center(
                                  child: Text(
                                    'Branch Already Exist'.tr(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            });

                            Timer(Duration(seconds: 2), () {
                              setState(() {
                                errorBox = Container();
                                branchCodeTextEditingController.text = '';
                              });
                            });
                          } else {
                            ref.set(Institute(
                                name: nameTextEditingController.text,
                                address: addressTextEditingController.text,
                                admin: [
                                  adminEmailTextEditingController.text
                                ]).toJson());
                            Firestore.instance
                                .collection('institute')
                                .document('users')
                                .
                                updateData({
                              adminEmailTextEditingController.text.split('@')[0]:
                                  "subAdmin_${FireBaseAuth.instance.instituteid}_${branchCodeTextEditingController.text}"
                            });
                            Navigator.of(context).pop();
                          }
                        });
                      }
                    },
                    color: Colors.white,
                    child: Text(
                      'Add Branch'.tr(),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
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
