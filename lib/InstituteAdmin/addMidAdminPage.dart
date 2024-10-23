import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:coach_app/Dialogs/multiselectDialogs.dart';
import 'package:coach_app/Models/model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MidAdminRegister extends StatefulWidget {
  final List<Map<String, String>>? branches;
  final String? keyM;
  final MidAdmin? midAdmin;
  MidAdminRegister({
    required this.branches,
    this.keyM,
    this.midAdmin,
  });
  @override
  _MidAdminRegisterState createState() => _MidAdminRegisterState();
}

class _MidAdminRegisterState extends State<MidAdminRegister> {
  late TextEditingController emailTextEditingController,
      districtTextEditingController,
      nameTextEditingController;
  late List<dynamic> selectedBranch;
  late GlobalKey<FormState> _formKey;
  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    selectedBranch = <String>[];
    if (widget.midAdmin != null) {
      selectedBranch = JsonCodec()
          .decode(widget.midAdmin!.branches)
          .map((e) => e.toString())
          .toList();
    }
    emailTextEditingController = TextEditingController()
      ..text = widget.midAdmin?.email ?? '';
    districtTextEditingController = TextEditingController()
      ..text = widget.midAdmin?.district ?? '';
    nameTextEditingController = TextEditingController()
      ..text = widget.midAdmin?.name ?? '';
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
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the name';
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
                        if (value == null || value.isEmpty) {
                          return 'Please enter the email';
                        }
                        if (!value.endsWith('@gmail.com')) {
                          return 'Only Gmail account allowed'.tr();
                        }
                        return null;
                      },
                      controller: emailTextEditingController,
                      enabled: widget.keyM == null,
                      decoration: InputDecoration(
                        hintText: 'Email'.tr(),
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
                        if (value == null || value.isEmpty) {
                          return 'Please enter the district';
                        }
                        return null;
                      },
                      controller: districtTextEditingController,
                      decoration: InputDecoration(
                        hintText: 'District'.tr(),
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
                    Text(
                      'Branches'.tr(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    (widget.branches != null)
                        ? MultiSelectFormField(
                            dataSource: widget.branches ?? [],
                            valueField: 'branchKey',
                            textField: 'branchName',
                            titleText: 'Branches'.tr(),
                            okButtonLabel: 'Accept'.tr(),
                            cancelButtonLabel: 'Reject'.tr(),
                            hintText: 'Please select atleast one branch'.tr(),
                            initialValue: selectedBranch,
                            onSaved: (value) {
                              selectedBranch = value;
                            },
                          )
                        : Center(
                            child: MaterialButton(
                                onPressed: () {},
                                child: Text('Add Branch'.tr())))
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    (widget.keyM == null)
                        ? Container()
                        : MaterialButton(
                            onPressed: () async {
                              String res = await showDialog(
                                  context: context,
                                  builder: (context) => AreYouSure());
                              if (res != 'Yes') {
                                return;
                              }
                              FirebaseDatabase.instance
                                  .ref()
                                  .child(
                                      'institute/${AppwriteAuth.instance.instituteid}/midAdmin/${widget.keyM}')
                                  .remove();

                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Remove'.tr(),
                            ),
                          ),
                    MaterialButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        if (!emailTextEditingController.text
                            .endsWith('@gmail.com')) {
                          Alert.instance.alert(
                              context, 'Only Gmail account allowed'.tr());
                          return;
                        }
                        if (selectedBranch.length == 0) {
                          Alert.instance.alert(
                              context, 'Please select atleast one branch'.tr());
                          return;
                        }
                        DatabaseReference refe;
                        if (widget.keyM == null) {
                          FirebaseFirestore.instance
                              .collection('institute')
                              .doc(
                                  emailTextEditingController.text.split('@')[0])
                              .set({
                            "value":
                                'midAdmin_${AppwriteAuth.instance.instituteid}_$selectedBranch'
                          });
                          refe = FirebaseDatabase.instance
                              .ref()
                              .child(
                                  'institute/${AppwriteAuth.instance.instituteid}/midAdmin/')
                              .push();
                          refe.update(MidAdmin(
                                  name: nameTextEditingController.text,
                                  district: districtTextEditingController.text,
                                  email: emailTextEditingController.text,
                                  branches: selectedBranch.toString())
                              .toJson());
                        } else {
                          refe = FirebaseDatabase.instance.ref().child(
                              'institute/${AppwriteAuth.instance.instituteid}/midAdmin/${widget.keyM}');
                          refe.update(MidAdmin(
                            name: nameTextEditingController.text,
                            district: districtTextEditingController.text,
                            email: emailTextEditingController.text,
                            branches: selectedBranch.toString(),
                          ).toJson());
                        }
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Add Mid Admin'.tr(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
