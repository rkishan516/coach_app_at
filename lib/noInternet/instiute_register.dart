import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/SucessDialog.dart';
import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/GlobalFunction/VyCode.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/NavigationOnOpen/WelComeNaviagtion.dart';
import 'package:coach_app/Utils/Colors.dart';
import 'package:coach_app/Utils/SizeConfig.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class InstituteRegister extends StatelessWidget {
  final TextEditingController nameTextEditingController =
          TextEditingController(),
      phoneNoTextEditingController = TextEditingController(),
      branch1NameTextEditingController = TextEditingController(),
      branch1UpiIdTextEditiingController = TextEditingController(),
      branch1addressTextEditingController = TextEditingController(),
      branch1CityTextEditingController = TextEditingController(),
      branch1PinCodeTextEditingController = TextEditingController(),
      branch1CodeTextEditingController = TextEditingController(),
      branch1AdminTextEditingController = TextEditingController(),
      accoundHolderNameTextEditingController = TextEditingController(),
      accountNoTextEditingController = TextEditingController(),
      accountIFSCTextEditingController = TextEditingController();
  File _image;

  Future getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    _image = File(pickedFile?.path);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig(context);
    return Scaffold(
      backgroundColor: GuruCoolLightColor.backgroundShade,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: sizeConfig.screenHeight * 0.0203,
              vertical: sizeConfig.screenWidth * 0.077,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Institute Registration',
                  style: TextStyle(
                    color: GuruCoolLightColor.primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: sizeConfig.screenWidth * 0.0389,
                  ),
                ),
                SizedBox(
                  height: sizeConfig.screenHeight * 0.008,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        try {
                          getImage();
                        } catch (e) {}
                      },
                      child: Container(
                        height: sizeConfig.screenHeight * 0.078,
                        width: sizeConfig.screenWidth * 0.138,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            color: GuruCoolLightColor.primaryColor,
                            width: sizeConfig.screenWidth * 1 / 360,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.account_balance,
                          size: sizeConfig.screenWidth * 0.06,
                          color: GuruCoolLightColor.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: sizeConfig.screenWidth * 0.0389,
                    ),
                    Text(
                      'Institute Logo (Tap to Upload)',
                      style: TextStyle(
                        color: Color(0xff848484),
                        fontSize: sizeConfig.screenWidth * 0.033,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: sizeConfig.screenHeight * 0.029,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(sizeConfig.screenWidth * 0.01389),
                      topRight:
                          Radius.circular(sizeConfig.screenWidth * 0.01389),
                    ),
                  ),
                  child: TextField(
                    controller: nameTextEditingController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: GuruCoolLightColor.primaryColor,
                          width: sizeConfig.screenWidth * 1 / 360,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: GuruCoolLightColor.primaryColor,
                          width: sizeConfig.screenWidth * 1 / 360,
                        ),
                      ),
                      hintText: 'Institute Name',
                      hintStyle: TextStyle(
                        color: Color(0xff848484),
                        fontSize: sizeConfig.screenWidth * 0.033,
                        fontWeight: FontWeight.w300,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: sizeConfig.screenHeight * 0.018,
                        vertical: sizeConfig.screenWidth * 0.036,
                      ),
                    ),
                    maxLines: 2,
                    minLines: 1,
                  ),
                ),
                SizedBox(
                  height: sizeConfig.screenHeight * 0.021,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(sizeConfig.screenWidth * 0.01389),
                      topRight:
                          Radius.circular(sizeConfig.screenWidth * 0.01389),
                    ),
                  ),
                  child: TextField(
                    controller: phoneNoTextEditingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Phone',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: GuruCoolLightColor.primaryColor,
                          width: sizeConfig.screenWidth * 1 / 360,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: GuruCoolLightColor.primaryColor,
                          width: sizeConfig.screenWidth * 1 / 360,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xff848484),
                        fontSize: sizeConfig.screenWidth * 0.033,
                        fontWeight: FontWeight.w300,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: sizeConfig.screenHeight * 0.018,
                        vertical: sizeConfig.screenWidth * 0.036,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeConfig.screenHeight * 0.0375,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.account_balance,
                      size: sizeConfig.screenWidth * 0.033,
                      color: Color(0xffA4A4A4),
                    ),
                    SizedBox(
                      width: sizeConfig.screenWidth * 0.019,
                    ),
                    Text(
                      'Main Branch Details',
                      style: TextStyle(
                        color: Color(0xffA4A4A4),
                        fontWeight: FontWeight.w400,
                        fontSize: sizeConfig.screenWidth * 0.0333,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: sizeConfig.screenHeight * 0.021,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(sizeConfig.screenWidth * 0.01389),
                      topRight:
                          Radius.circular(sizeConfig.screenWidth * 0.01389),
                    ),
                  ),
                  child: TextField(
                    maxLines: 2,
                    minLines: 1,
                    controller: branch1NameTextEditingController,
                    decoration: InputDecoration(
                      hintText: 'Main Branch Name',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: GuruCoolLightColor.primaryColor,
                          width: sizeConfig.screenWidth * 1 / 360,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: GuruCoolLightColor.primaryColor,
                          width: sizeConfig.screenWidth * 1 / 360,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xff848484),
                        fontSize: sizeConfig.screenWidth * 0.033,
                        fontWeight: FontWeight.w300,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: sizeConfig.screenHeight * 0.018,
                        vertical: sizeConfig.screenWidth * 0.036,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeConfig.screenHeight * 0.021,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(sizeConfig.screenWidth * 0.01389),
                      topRight:
                          Radius.circular(sizeConfig.screenWidth * 0.01389),
                    ),
                  ),
                  child: TextField(
                    maxLines: 2,
                    minLines: 1,
                    controller: branch1addressTextEditingController,
                    decoration: InputDecoration(
                      hintText: 'Main Branch Address',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: GuruCoolLightColor.primaryColor,
                          width: sizeConfig.screenWidth * 1 / 360,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: GuruCoolLightColor.primaryColor,
                          width: sizeConfig.screenWidth * 1 / 360,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xff848484),
                        fontSize: sizeConfig.screenWidth * 0.033,
                        fontWeight: FontWeight.w300,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: sizeConfig.screenHeight * 0.018,
                        vertical: sizeConfig.screenWidth * 0.036,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeConfig.screenHeight * 0.021,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                sizeConfig.screenWidth * 0.01389),
                            topRight: Radius.circular(
                                sizeConfig.screenWidth * 0.01389),
                          ),
                        ),
                        child: TextField(
                          controller: branch1CityTextEditingController,
                          decoration: InputDecoration(
                            hintText: 'City / State',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: GuruCoolLightColor.primaryColor,
                                width: sizeConfig.screenWidth * 1 / 360,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: GuruCoolLightColor.primaryColor,
                                width: sizeConfig.screenWidth * 1 / 360,
                              ),
                            ),
                            hintStyle: TextStyle(
                              color: Color(0xff848484),
                              fontSize: sizeConfig.screenWidth * 0.033,
                              fontWeight: FontWeight.w300,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: sizeConfig.screenHeight * 0.018,
                              vertical: sizeConfig.screenWidth * 0.036,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: sizeConfig.screenWidth * 0.036,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                sizeConfig.screenWidth * 0.01389),
                            topRight: Radius.circular(
                                sizeConfig.screenWidth * 0.01389),
                          ),
                        ),
                        child: TextField(
                          controller: branch1PinCodeTextEditingController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Pin Code',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: GuruCoolLightColor.primaryColor,
                                width: sizeConfig.screenWidth * 1 / 360,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: GuruCoolLightColor.primaryColor,
                                width: sizeConfig.screenWidth * 1 / 360,
                              ),
                            ),
                            hintStyle: TextStyle(
                              color: Color(0xff848484),
                              fontSize: sizeConfig.screenWidth * 0.033,
                              fontWeight: FontWeight.w300,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: sizeConfig.screenHeight * 0.018,
                              vertical: sizeConfig.screenWidth * 0.036,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: sizeConfig.screenHeight * 0.0375,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.account_balance,
                      size: sizeConfig.screenWidth * 0.033,
                      color: Color(0xffA4A4A4),
                    ),
                    SizedBox(
                      width: sizeConfig.screenWidth * 0.019,
                    ),
                    Text(
                      'Bank Account Details',
                      style: TextStyle(
                        color: Color(0xffA4A4A4),
                        fontWeight: FontWeight.w400,
                        fontSize: sizeConfig.screenWidth * 0.0333,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: sizeConfig.screenHeight * 0.021,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(sizeConfig.screenWidth * 0.01389),
                      topRight:
                          Radius.circular(sizeConfig.screenWidth * 0.01389),
                    ),
                  ),
                  child: TextField(
                    controller: accoundHolderNameTextEditingController,
                    decoration: InputDecoration(
                      hintText: 'Account Holder Name (Optional)',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: GuruCoolLightColor.primaryColor,
                          width: sizeConfig.screenWidth * 1 / 360,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: GuruCoolLightColor.primaryColor,
                          width: sizeConfig.screenWidth * 1 / 360,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xff848484),
                        fontSize: sizeConfig.screenWidth * 0.033,
                        fontWeight: FontWeight.w300,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: sizeConfig.screenHeight * 0.018,
                        vertical: sizeConfig.screenWidth * 0.036,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeConfig.screenHeight * 0.021,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(sizeConfig.screenWidth * 0.01389),
                      topRight:
                          Radius.circular(sizeConfig.screenWidth * 0.01389),
                    ),
                  ),
                  child: TextField(
                    controller: accountNoTextEditingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Account Number (Optional)',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: GuruCoolLightColor.primaryColor,
                          width: sizeConfig.screenWidth * 1 / 360,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: GuruCoolLightColor.primaryColor,
                          width: sizeConfig.screenWidth * 1 / 360,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xff848484),
                        fontSize: sizeConfig.screenWidth * 0.033,
                        fontWeight: FontWeight.w300,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: sizeConfig.screenHeight * 0.018,
                        vertical: sizeConfig.screenWidth * 0.036,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeConfig.screenHeight * 0.021,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(sizeConfig.screenWidth * 0.01389),
                      topRight:
                          Radius.circular(sizeConfig.screenWidth * 0.01389),
                    ),
                  ),
                  child: TextField(
                    controller: accountIFSCTextEditingController,
                    decoration: InputDecoration(
                      hintText: 'IFSC Code (Optional)',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: GuruCoolLightColor.primaryColor,
                          width: sizeConfig.screenWidth * 1 / 360,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: GuruCoolLightColor.primaryColor,
                          width: sizeConfig.screenWidth * 1 / 360,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xff848484),
                        fontSize: sizeConfig.screenWidth * 0.033,
                        fontWeight: FontWeight.w300,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: sizeConfig.screenHeight * 0.018,
                        vertical: sizeConfig.screenWidth * 0.036,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeConfig.screenHeight * 0.0375,
                ),
                Row(
                  children: [
                    Image.asset('images/upi.png'),
                    SizedBox(
                      width: sizeConfig.screenWidth * 0.019,
                    ),
                    Text(
                      'Upi Details',
                      style: TextStyle(
                        color: Color(0xffA4A4A4),
                        fontWeight: FontWeight.w400,
                        fontSize: sizeConfig.screenWidth * 0.0333,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: sizeConfig.screenHeight * 0.021,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(sizeConfig.screenWidth * 0.01389),
                      topRight:
                          Radius.circular(sizeConfig.screenWidth * 0.01389),
                    ),
                  ),
                  child: TextField(
                    controller: branch1UpiIdTextEditiingController,
                    decoration: InputDecoration(
                      hintText: 'Main Branch UPI id',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: GuruCoolLightColor.primaryColor,
                          width: sizeConfig.screenWidth * 1 / 360,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: GuruCoolLightColor.primaryColor,
                          width: sizeConfig.screenWidth * 1 / 360,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xff848484),
                        fontSize: sizeConfig.screenWidth * 0.033,
                        fontWeight: FontWeight.w300,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: sizeConfig.screenHeight * 0.018,
                        vertical: sizeConfig.screenWidth * 0.036,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeConfig.screenHeight * 0.021,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(sizeConfig.screenWidth * 0.01389),
                      topRight:
                          Radius.circular(sizeConfig.screenWidth * 0.01389),
                    ),
                  ),
                  child: TextField(
                    controller: branch1AdminTextEditingController,
                    decoration: InputDecoration(
                      hintText: 'Main Branch Admin email',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: GuruCoolLightColor.primaryColor,
                          width: sizeConfig.screenWidth * 1 / 360,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: GuruCoolLightColor.primaryColor,
                          width: sizeConfig.screenWidth * 1 / 360,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xff848484),
                        fontSize: sizeConfig.screenWidth * 0.033,
                        fontWeight: FontWeight.w300,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: sizeConfig.screenHeight * 0.018,
                        vertical: sizeConfig.screenWidth * 0.036,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeConfig.screenHeight * 0.021,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(sizeConfig.screenWidth * 0.01389),
                      topRight:
                          Radius.circular(sizeConfig.screenWidth * 0.01389),
                    ),
                  ),
                  child: TextField(
                    controller: branch1CodeTextEditingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Main Branch Code',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: GuruCoolLightColor.primaryColor,
                          width: sizeConfig.screenWidth * 1 / 360,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: GuruCoolLightColor.primaryColor,
                          width: sizeConfig.screenWidth * 1 / 360,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: Color(0xff848484),
                        fontSize: sizeConfig.screenWidth * 0.033,
                        fontWeight: FontWeight.w300,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: sizeConfig.screenHeight * 0.018,
                        vertical: sizeConfig.screenWidth * 0.036,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeConfig.screenHeight * 0.021,
                ),
                Text(
                  'Make your Own branch code for easy references. for eg: 1101',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Color(0xff000000),
                    fontSize: sizeConfig.screenWidth * 0.0277,
                  ),
                ),
                SizedBox(
                  height: sizeConfig.screenHeight * 0.0375,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        if (nameTextEditingController.text != '' &&
                            phoneNoTextEditingController.text != '' &&
                            branch1UpiIdTextEditiingController.text != '' &&
                            branch1AdminTextEditingController.text != '' &&
                            branch1CityTextEditingController.text != '' &&
                            branch1PinCodeTextEditingController.text != '' &&
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
                              if (FireBaseAuth.instance.instituteid != null) {
                                WelcomeNavigation.signInWithGoogleAndGetPage(
                                    context);
                                return;
                              }
                              showDialog(
                                  context: context,
                                  builder: (context) => UploadDialog(
                                        warning: 'Registering Institute'.tr(),
                                      ));
                              DatabaseReference reference = FirebaseDatabase
                                  .instance
                                  .reference()
                                  .child('/tempInstitute')
                                  .push();
                              reference.update({
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
                                "creationDate": DateTime.now().toString(),
                                "paid": 'Trial',
                                "logo": "/instituteLogo/${reference.key}",
                                "branches": {
                                  branch1CodeTextEditingController.text: Branch(
                                      name:
                                          branch1NameTextEditingController.text,
                                      address:
                                          branch1addressTextEditingController
                                              .text,
                                      admin: {
                                        "${branch1AdminTextEditingController.text.hashCode}":
                                            Admin(
                                          email:
                                              branch1AdminTextEditingController
                                                  .text,
                                        )
                                      },
                                      upiId: branch1UpiIdTextEditiingController
                                          .text,
                                      accountDetails: AccountDetails(
                                        accountHolderName:
                                            accoundHolderNameTextEditingController
                                                        .text ==
                                                    ''
                                                ? null
                                                : accoundHolderNameTextEditingController
                                                    .text,
                                        accountNo:
                                            accountNoTextEditingController
                                                        .text ==
                                                    ''
                                                ? null
                                                : accountNoTextEditingController
                                                    .text,
                                        accountIFSC:
                                            accountIFSCTextEditingController
                                                        .text ==
                                                    ''
                                                ? null
                                                : accountIFSCTextEditingController
                                                    .text,
                                      )).toJson()
                                }
                              });
                              showDialog(
                                  context: context,
                                  builder: (context) => UploadDialog(
                                        warning: 'Uploading Logo'.tr(),
                                      ));
                              await FirebaseStorage.instance
                                  .ref()
                                  .child('/instituteLogo/${reference.key}')
                                  .putFile(_image)
                                  .onComplete;
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
                                    .document(branch1AdminTextEditingController
                                        .text
                                        .split('@')[0])
                                    .setData({
                                  "value":
                                      "subAdmin_${reference.key}_${branch1CodeTextEditingController.text}"
                                });
                              }
                              DataSnapshot snap = await FirebaseDatabase
                                  .instance
                                  .reference()
                                  .child('/instituteList')
                                  .orderByKey()
                                  .limitToLast(1)
                                  .once();

                              await FirebaseDatabase.instance
                                  .reference()
                                  .child('/instituteList')
                                  .update({
                                VyCode.instance.getNextVyCode(
                                    snap.value.keys.toList()[0]): reference.key
                              });
                              showDialog(
                                  context: context,
                                  builder: (context) => SuccessDialog(
                                      success:
                                          'Your Institute has been successfully Registered'
                                              .tr()));
                              await Future.delayed(Duration(seconds: 2));
                              WelcomeNavigation.getPage(context, value.uid);
                            } else {
                              // _scKey.currentState.showSnackBar(
                              //     SnackBar(content: Text('Login Failed'.tr())));
                            }
                          });
                        } else {
                          // _scKey.currentState.showSnackBar(SnackBar(
                          //     content: Text('Something is wrong'.tr())));
                        }
                      },
                      color: GuruCoolLightColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          sizeConfig.screenWidth * 0.01389,
                        ),
                      ),
                      elevation: 5,
                      height: sizeConfig.screenHeight * 30 / 640,
                      minWidth: sizeConfig.screenWidth * 0.45,
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          letterSpacing: sizeConfig.b * 0.0364,
                          fontSize: sizeConfig.screenWidth * 0.0389,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
