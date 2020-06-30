import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class BranchRegister extends StatefulWidget {
  final Branch institute;
  final String branchCode;
  BranchRegister({this.institute, this.branchCode});
  @override
  _BranchRegisterState createState() => _BranchRegisterState();
}

class _BranchRegisterState extends State<BranchRegister> {
  TextEditingController nameTextEditingController,
      branchCodeTextEditingController,
      adminEmailTextEditingController,
      addressTextEditingController,
      upiTextEditingController;
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
    upiTextEditingController = TextEditingController()
      ..text = widget.institute?.upiId ?? '';
    if (widget.institute?.name == null &&
        widget.institute?.address == null &&
        widget.institute?.admin == null &&
        widget.branchCode == null) {
      adminEmailTextEditingController.text = '';
      isEnable = true;
    } else {
      adminEmailTextEditingController.text =
          widget.institute.admin.values.toList()[0].email;
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
                      TextField(
                        controller: nameTextEditingController,
                        decoration: InputDecoration(
                          hintText: 'Name of branch'.tr(),
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
                        enabled: isEnable,
                        controller: adminEmailTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email of sub-admin'.tr(),
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
                          hintText: 'Address of branch'.tr(),
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
                        controller: upiTextEditingController,
                        decoration: InputDecoration(
                          hintText: 'Branch UPI ID'.tr(),
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
                        enabled: isEnable,
                        controller: branchCodeTextEditingController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Code of branch'.tr(),
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
                errorBox,
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    onPressed: () {
                      if (adminEmailTextEditingController.text == '' ||
                          upiTextEditingController.text == '' ||
                          nameTextEditingController.text == '' ||
                          addressTextEditingController.text == '' ||
                          branchCodeTextEditingController.text == '') {
                        Alert.instance
                            .alert(context, 'Something remains unfilled'.tr());
                        return;
                      }
                      if (!adminEmailTextEditingController.text
                          .endsWith('@gmail.com')) {
                        Alert.instance
                            .alert(context, 'Only Gmail account allowed'.tr());
                        return;
                      }
                      if (!upiTextEditingController.text.contains('@')) {
                        Alert.instance.alert(context, 'Wrong UPI ID'.tr());
                      }
                      DatabaseReference ref = FirebaseDatabase.instance
                          .reference()
                          .child(
                              'institute/${FireBaseAuth.instance.instituteid}/branches/${branchCodeTextEditingController.text}');
                      if (widget.branchCode != null) {
                        Branch branch = Branch(
                            name: nameTextEditingController.text,
                            address: addressTextEditingController.text,
                            upiId: upiTextEditingController.text);
                        ref.update(branch.toJson());
                        Navigator.of(context).pop();
                        return;
                      }

                      ref.child('name').once().then((value) {
                        if (value.value != null) {
                          setState(() {
                            errorBox = Container(
                              height: 40,
                              color: Color(0xffF36C24),
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
                          ref.update(Branch(
                            name: nameTextEditingController.text,
                            address: addressTextEditingController.text,
                            admin: {
                              "${adminEmailTextEditingController.text.hashCode}":
                                  Admin(
                                email: adminEmailTextEditingController.text,
                              )
                            },
                            upiId: upiTextEditingController.text,
                          ).toJson());
                          if (FireBaseAuth.instance.previlagelevel == 34) {
                            List<int> branchesKey;
                            var k = JsonCodec()
                                .decode(FireBaseAuth.instance.branchList);
                            branchesKey = JsonCodec().decode(k).cast<int>();
                            print(branchesKey.toString());
                            branchesKey.add(int.parse(
                                branchCodeTextEditingController.text));
                            print(branchesKey.toString());
                            ref.parent().parent().child(
                                'midAdmin/${FireBaseAuth.instance.user.uid}/branches').set(branchesKey.toString());
                          }
                          if (FireBaseAuth.instance.user.email !=
                              adminEmailTextEditingController.text) {
                            Firestore.instance
                                .collection('institute')
                                .document(adminEmailTextEditingController.text
                                    .split('@')[0])
                                .setData({
                              "value":
                                  "subAdmin_${FireBaseAuth.instance.instituteid}_${branchCodeTextEditingController.text}"
                            });
                          }
                          Navigator.of(context).pop();
                        }
                      });
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
