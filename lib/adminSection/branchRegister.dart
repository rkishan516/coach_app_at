import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Models/model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class BranchRegister extends StatefulWidget {
  final Branch? institute;
  final String? branchCode;
  BranchRegister({this.institute, this.branchCode});
  @override
  _BranchRegisterState createState() => _BranchRegisterState();
}

class _BranchRegisterState extends State<BranchRegister> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController nameTextEditingController,
      branchCodeTextEditingController,
      adminEmailTextEditingController,
      addressTextEditingController,
      upiTextEditingController,
      accoundHolderNameTextEditingController,
      accountNoTextEditingController,
      accountIFSCTextEditingController;
  late Widget errorBox;
  late bool isEnable;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    errorBox = Container();
    nameTextEditingController = TextEditingController()
      ..text = widget.institute?.name ?? '';
    branchCodeTextEditingController = TextEditingController()
      ..text = widget.branchCode ?? '';
    addressTextEditingController = TextEditingController()
      ..text = widget.institute?.address ?? '';
    adminEmailTextEditingController = TextEditingController();
    upiTextEditingController = TextEditingController()
      ..text = widget.institute?.upiId ?? '';
    accoundHolderNameTextEditingController = TextEditingController()
      ..text = widget.institute?.accountDetails.accountHolderName ?? '';
    accountNoTextEditingController = TextEditingController()
      ..text = widget.institute?.accountDetails.accountNo ?? '';
    accountIFSCTextEditingController = TextEditingController()
      ..text = widget.institute?.accountDetails.accountIFSC ?? '';
    if (widget.institute?.name == null &&
        widget.institute?.address == null &&
        widget.institute?.admin == null &&
        widget.branchCode == null) {
      adminEmailTextEditingController.text = '';
      isEnable = true;
    } else {
      adminEmailTextEditingController.text =
          widget.institute?.admin.values.toList()[0].email ?? '';
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
                        TextFormField(
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
                        TextFormField(
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
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: accoundHolderNameTextEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Color(0xfff3f3f4),
                          ),
                        ),
                        contentPadding: EdgeInsets.only(left: 10),
                        hintStyle: TextStyle(fontSize: 15),
                        hintText: 'Bank Account Holder Name (Optional)',
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: accountNoTextEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Color(0xfff3f3f4),
                          ),
                        ),
                        contentPadding: EdgeInsets.only(left: 10),
                        hintStyle: TextStyle(fontSize: 15),
                        hintText: 'Bank Account No. (Optional)',
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: accountIFSCTextEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Color(0xfff3f3f4),
                          ),
                        ),
                        contentPadding: EdgeInsets.only(left: 10),
                        hintStyle: TextStyle(fontSize: 15),
                        hintText: 'Bank Account IFSC Code (Optional)',
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
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
                        TextFormField(
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
                    child: MaterialButton(
                      onPressed: () {
                        if (adminEmailTextEditingController.text == '' ||
                            upiTextEditingController.text == '' ||
                            nameTextEditingController.text == '' ||
                            addressTextEditingController.text == '' ||
                            branchCodeTextEditingController.text == '') {
                          Alert.instance.alert(
                              context, 'Something remains unfilled'.tr());
                          return;
                        }
                        if (!adminEmailTextEditingController.text
                            .endsWith('@gmail.com')) {
                          Alert.instance.alert(
                              context, 'Only Gmail account allowed'.tr());
                          return;
                        }
                        if (!upiTextEditingController.text.contains('@')) {
                          Alert.instance.alert(context, 'Wrong UPI ID'.tr());
                          return;
                        }
                        if (accountNoTextEditingController.text != '' ||
                            accountIFSCTextEditingController.text != '' ||
                            accoundHolderNameTextEditingController.text != '') {
                          if ([
                            accountNoTextEditingController.text,
                            accountIFSCTextEditingController.text,
                            accoundHolderNameTextEditingController.text
                          ].contains('')) {
                            Alert.instance.alert(
                                context, 'Please fill all account details');
                            return;
                            //TODO: Change bank id
                          } else if (!RegExp(r'^[0-9]{14}$')
                              .hasMatch(accountNoTextEditingController.text)) {
                            Alert.instance.alert(
                                context, 'Please fill correct account number');
                            return;
                          } else if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$')
                              .hasMatch(accountIFSCTextEditingController.text
                                  .toUpperCase())) {
                            Alert.instance.alert(
                                context, 'Please fill correct IFSC Code');
                            return;
                          }
                        }
                        DatabaseReference ref = FirebaseDatabase.instance
                            .ref()
                            .child(
                                'institute/${AppwriteAuth.instance.instituteid}/branches/${branchCodeTextEditingController.text}');
                        if (widget.branchCode != null) {
                          Branch branch = Branch(
                            admin: {},
                            courses: null,
                            accountId: '',
                            name: nameTextEditingController.text,
                            address: addressTextEditingController.text,
                            upiId: upiTextEditingController.text,
                            accountDetails: AccountDetails(
                              accountHolderName:
                                  accoundHolderNameTextEditingController.text,
                              accountNo: accountNoTextEditingController.text,
                              accountIFSC:
                                  accountIFSCTextEditingController.text,
                            ),
                          );
                          ref.update(branch.toJson());
                          Navigator.of(context).pop();
                          return;
                        }

                        ref.child('name').once().then((value) {
                          if (value.snapshot.value != null) {
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
                                    name: '',
                                  ),
                                },
                                accountId: '',
                                courses: null,
                                upiId: upiTextEditingController.text,
                                accountDetails: AccountDetails(
                                  accountHolderName:
                                      accoundHolderNameTextEditingController
                                          .text,
                                  accountNo:
                                      accountNoTextEditingController.text,
                                  accountIFSC:
                                      accountIFSCTextEditingController.text,
                                )).toJson());
                            if (AppwriteAuth.instance.previlagelevel == 34) {
                              AppwriteAuth.instance.branchList.add(int.parse(
                                  branchCodeTextEditingController.text));
                              ref.parent!.parent!
                                  .child(
                                      'midAdmin/${AppwriteAuth.instance.user!.$id}/branches')
                                  .set(AppwriteAuth.instance.branchList
                                      .toString());
                            }
                            if (AppwriteAuth.instance.user!.email !=
                                adminEmailTextEditingController.text) {
                              FirebaseFirestore.instance
                                  .collection('institute')
                                  .doc(adminEmailTextEditingController.text
                                      .split('@')[0])
                                  .set({
                                "value":
                                    "subAdmin_${AppwriteAuth.instance.instituteid}_${branchCodeTextEditingController.text}"
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
          ),
        ],
      ),
    );
  }
}
