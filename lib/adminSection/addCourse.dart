import 'dart:async';

import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Plugins/flutter_switch.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:coach_app/courses/subject_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCourse extends StatefulWidget {
  final bool isEdit;
  final Courses course;
  AddCourse({this.isEdit, this.course});
  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  TextEditingController nameTextEditingController,
      descriptionTextEditingController,
      mediumTextEditingController,
      _admissionText,
      _labText,
      _extraText,
      _tutionText,
      _libraryText,
      _totalText,
      _setFineText,
      _fineDurationText;
  var _currentFineDurationSelected;

  final TextEditingController _ddText = TextEditingController();
  final TextEditingController _yyText = TextEditingController();
  SharedPreferences _pref;
  var _mmperiod = [
    "MM",
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12"
  ];
  final dbRef = FirebaseDatabase.instance;
  var durationperiod = ["Day(s)", "Month(s)", "Year(s)"];
  var _mmSelected = "MM";
  bool toggleValue1 = false;
  bool toggleValue2 = false;
  bool toggleValue3 = false;
  String _prevTotalText = "";
  _changeTotalFees(value) {
    setState(() {
      _totalText.text = (double.parse(
                  _admissionText.text != '' ? _admissionText.text : "0") +
              double.parse(_labText.text != '' ? _labText.text : "0") +
              double.parse(_extraText.text != '' ? _extraText.text : "0") +
              double.parse(_tutionText.text != '' ? _tutionText.text : "0") +
              double.parse(_libraryText.text != '' ? _libraryText.text : "0"))
          .toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Course'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
        ),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: nameTextEditingController,
                    decoration: InputDecoration(
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      hintText: 'Course Name'.tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      fillColor: Color(0xfff3f3f4),
                      filled: true,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: descriptionTextEditingController,
                    decoration: InputDecoration(
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      hintText: 'Course Description'.tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      fillColor: Color(0xfff3f3f4),
                      filled: true,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: mediumTextEditingController,
                    decoration: InputDecoration(
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      hintText: 'Medium'.tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      fillColor: Color(0xfff3f3f4),
                      filled: true,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 48.0,
              thickness: 2.0,
            ),
            _feeSection(),
            _totalfees(),
            Divider(
              height: 48.0,
              thickness: 2.0,
            ),
            _attachMaxNoofInstallment(),
            if (toggleValue1)
              ListView(
                shrinkWrap: true,
                controller: ScrollController(),
                padding: EdgeInsets.all(12.0),
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Text(
                            'Total Installments',
                            style: TextStyle(
                                fontSize: 17.0, fontWeight: FontWeight.w400),
                          )),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              noOfTextFields =
                                  int.parse(value != "" ? value : "0");
                            });
                          },
                          controller: _maxInstallText,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffF36C24),
                            enabled: (!widget.isEdit) || (noOfTextFields == 0),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: "Enter No. of Installments",
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  _createTextFields(noOfTextFields)
                ],
              ),
            Divider(
              height: 48.0,
              thickness: 2.0,
            ),
            _attachOneTimePay(),
            if (toggleValue3)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  color: Color(0xffF36C24),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Last Submission Date',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, bottom: 16.0, right: 2.0, left: 2.0),
                        child: TextField(
                          onChanged: (value) {},
                          controller: _ddText,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "DD"),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, bottom: 16.0, right: 2.0, left: 2.0),
                        child: DropdownButton<String>(
                          dropdownColor: Color(0xffF36C24),
                          iconEnabledColor: Colors.white,
                          items: _mmperiod.map((String dropDownStringitem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringitem,
                              child: Text(
                                dropDownStringitem,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (String newValueSelected) {
                            setState(() {
                              _mmSelected = newValueSelected;
                            });
                          },
                          isExpanded: true,
                          hint: Text(
                            'MM',
                            style: TextStyle(color: Colors.white),
                          ),
                          value: _mmSelected,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, bottom: 16.0, right: 2.0, left: 2.0),
                        child: TextField(
                          onChanged: (value) {},
                          controller: _yyText,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              hintText: "YYYY"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4.0,
                    )
                  ],
                ),
              ),
            Divider(
              height: 48.0,
              thickness: 2.0,
            ),
            _setFine(),
            if (toggleValue2)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  color: Color(0xffF36C24),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Fine Amount',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _setFineText,
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: Color(0xffF36C24)),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Enter value",
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                            ),
                            child: Text(
                              '₹',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 16,
                            child: Text(
                              'Enter Duration',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _fineDurationText,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  color: Color(
                                    0xffF36C24,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Enter value",
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: DropdownButton<String>(
                              dropdownColor: Color(0xffF36C24),
                              iconEnabledColor: Colors.white,
                              items: durationperiod
                                  .map((String dropDownStringitem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringitem,
                                  child: Text(
                                    dropDownStringitem,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String newValueSelected) {
                                setState(() {
                                  this._currentFineDurationSelected =
                                      newValueSelected;
                                });
                              },
                              isExpanded: true,
                              hint: Text('Select Period'),
                              value: _currentFineDurationSelected,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            Divider(
              height: 48.0,
              thickness: 2.0,
            ),
            _saveButton(),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  (widget.course.id == null)
                      ? Container()
                      : FlatButton(
                          onPressed: () async {
                            String res = await showDialog(
                                context: context,
                                builder: (context) => AreYouSure());
                            if (res != 'Yes') {
                              return;
                            }
                            FirebaseDatabase.instance
                                .reference()
                                .child(
                                    'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.course.id}')
                                .remove();
                            FirebaseDatabase.instance
                                .reference()
                                .child(
                                    'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/coursesList/${widget.course.id}')
                                .remove();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Remove'.tr(),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future showErrorDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text("Update Attached Installment"),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop("Yes");
                  },
                  elevation: 5.0,
                  child: Text("Yes"),
                ),
              ]);
        });
  }

  _saveintodatabase() {
    if (_prevTotalText != '') {
      if (toggleValue1 && _totalText.text != _prevTotalText) {
        showErrorDialog(context);
        return;
      }
    }
    if (nameTextEditingController.text == '') {
      Alert.instance
          .alert(context, 'Please Enter the course '.tr(args: ['Name'.tr()]));
      return;
    }
    if (descriptionTextEditingController.text == '') {
      Alert.instance.alert(
          context, 'Please Enter the course '.tr(args: ['Description'.tr()]));
      return;
    }
    if (mediumTextEditingController.text == '') {
      Alert.instance
          .alert(context, 'Please Enter the course '.tr(args: ['Medium'.tr()]));
      return;
    }
    Map<String, Installment> installments = Map<String, Installment>();
    for (int i = 0; i < noOfTextFields; i++) {
      installments[((i + 1)).toString() + "Installment"] = Installment(
          amount: _listEditingControllerMoney[i].text,
          duration: _listEditingControllerDD[i].text +
              " " +
              _listEditingControllerMM[i].text +
              " " +
              _listEditingControllerYYYY[i].text);
    }

    if (toggleValue1) {
      double amount = 0.0;
      installments.forEach((key, value) {
        amount += double.parse(value.amount);
      });
      if (amount != double.parse(_totalText.text)) {
        Alert.instance.alert(context, 'Please adjust installment price');
        return;
      }
    }

    Courses course = Courses(
      name: nameTextEditingController.text.capitalize().trim(),
      description: descriptionTextEditingController.text.capitalize().trim(),
      date: DateTime.now().toIso8601String(),
      medium: mediumTextEditingController.text.capitalize().trim(),
      subjects: widget.course.subjects,
      id: (widget.course.id == null)
          ? nameTextEditingController.text.hashCode.toString()
          : widget.course.id,
      price: double.parse(_totalText.text).toInt(),
      fees: Fees(
        feeSection: FeeSection(
          admissionFees: _admissionText.text,
          extraFees: _extraText.text,
          labFees: _labText.text,
          libraryFees: _libraryText.text,
          tutionFees: _tutionText.text,
          totalFees: _totalText.text,
        ),
        fine: Fine(
          duration: _fineDurationText.text + " " + _currentFineDurationSelected,
          fineAmount: _setFineText.text,
          isFineAllowed: toggleValue2,
        ),
        oneTime: OneTime(
          duration: _ddText.text + " " + _mmSelected + " " + _yyText.text,
          isOneTimeAllowed: toggleValue3,
        ),
        maxInstallment: MaxInstallment(
          installment: installments,
          isMaxAllowed: toggleValue1,
          maxAllowedInstallment: _maxInstallText.text,
        ),
      ),
    );
    widget.course.id = course.id;
    FirebaseDatabase.instance
        .reference()
        .child(
            'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${course.id}')
        .update(course.toJson());

    FirebaseDatabase.instance
        .reference()
        .child(
            'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/coursesList/')
        .update({course.id: course.name});

    _pref.setString("${widget.course.id}", _totalText.text);
    Navigator.of(context).pop();
  }

  Widget _feeSection() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Admission Fees',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  onTap: () {
                    if (_admissionText.text == "0") _admissionText.text = '';
                  },
                  onChanged: (value) {
                    _changeTotalFees(value);
                  },
                  controller: _admissionText,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    filled: true,
                    fillColor: Color(0xffF36C24),
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: "Enter value",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  '₹',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    'Tution Fees',
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),
                  )),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  onTap: () {
                    if (_tutionText.text == "0") _tutionText.text = '';
                  },
                  onChanged: (value) {
                    _changeTotalFees(value);
                  },
                  controller: _tutionText,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    filled: true,
                    fillColor: Color(0xffF36C24),
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: "Enter value",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  '₹',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    'Library Fees',
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),
                  )),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  onTap: () {
                    if (_libraryText.text == "0") _libraryText.text = '';
                  },
                  onChanged: (value) {
                    _changeTotalFees(value);
                  },
                  controller: _libraryText,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    filled: true,
                    fillColor: Color(0xffF36C24),
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: "Enter value",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  '₹',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    'Lab Fees',
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),
                  )),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  onTap: () {
                    if (_labText.text == "0") _labText.text = '';
                  },
                  onChanged: (value) {
                    _changeTotalFees(value);
                  },
                  controller: _labText,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    filled: true,
                    fillColor: Color(0xffF36C24),
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: "Enter value",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  '₹',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    'Extra Curricular Fees',
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),
                  )),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  onTap: () {
                    if (_extraText.text == "0") _extraText.text = '';
                  },
                  onChanged: (value) {
                    _changeTotalFees(value);
                  },
                  controller: _extraText,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF36C24),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: "Enter value",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  '₹',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _totalfees() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              flex: 2,
              child: Text(
                'Total Fees',
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),
              )),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            flex: 1,
            child: TextField(
              readOnly: true,
              controller: _totalText,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                filled: true,
                enabled: true,
                fillColor: Color(0xffF36C24),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              '₹',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _attachMaxNoofInstallment() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              flex: 2,
              child: Text(
                'Attach Maximum Installment',
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),
              )),
          SizedBox(
            width: 40.0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: FlutterSwitch(
                value: toggleValue1,
                activeColor: Color(0xffF36C24),
                onToggle: (val) {
                  if (_totalText.text != "0") {
                    setState(() {
                      toggleValue1 = !toggleValue1;
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _attachOneTimePay() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              flex: 2,
              child: Text(
                'Pay One Time',
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),
              )),
          SizedBox(
            width: 40.0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: FlutterSwitch(
                value: toggleValue3,
                activeColor: Color(0xffF36C24),
                onToggle: (val) {
                  setState(() {
                    toggleValue3 = !toggleValue3;
                  });
                  if (!toggleValue3) {
                    _ddText.text = "";
                    _yyText.text = "";
                    _mmSelected = "MM";
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _setFine() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              flex: 2,
              child: Text(
                'Set Fine',
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),
              )),
          SizedBox(
            width: 40.0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: FlutterSwitch(
                value: toggleValue2,
                activeColor: Color(0xffF36C24),
                onToggle: (val) {
                  if (_totalText.text != "0") {
                    setState(() {
                      toggleValue2 = !toggleValue2;
                    });
                    if (!toggleValue2) {
                      _fineDurationText.text = "0";
                      _setFineText.text = "0";
                      _currentFineDurationSelected = "Day(s)";
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _saveButton() {
    return GestureDetector(
      onTap: () {
        _saveintodatabase();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Color(0xffF36C24)),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        child: Text(
          "Save",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  _loadFromDatabase() {
    toggleValue1 = widget.course.fees.maxInstallment.isMaxAllowed;
    toggleValue2 = widget.course.fees.fine.isFineAllowed;
    toggleValue3 = widget.course.fees.oneTime.isOneTimeAllowed;

    List<String> durationOneTime =
        widget.course.fees?.oneTime?.duration?.split(" ");

    if (durationOneTime.length > 2) {
      _ddText.text = durationOneTime[0];
      _mmSelected = durationOneTime[1];
      _yyText.text = durationOneTime[2];
    }

    noOfTextFields = int.parse(
        widget.course.fees.maxInstallment.maxAllowedInstallment == ''
            ? "0"
            : widget.course.fees.maxInstallment.maxAllowedInstallment);
    _maxInstallText.text = noOfTextFields.toString();
    _listEditingControllerDD = new List<TextEditingController>(noOfTextFields);
    _listEditingControllerYYYY =
        new List<TextEditingController>(noOfTextFields);
    _listEditingControllerMM = List<TextEditingController>(noOfTextFields);
    _listEditingControllerMoney =
        new List<TextEditingController>(noOfTextFields);
    for (int i = 0; i < noOfTextFields; i++) {
      _listEditingControllerMoney[i] = TextEditingController(
          text: !toggleValue1
              ? (double.parse((double.parse(_totalText.text) / noOfTextFields)
                      .toStringAsFixed(2))
                  .toString())
              : "");
      _listEditingControllerMM[i] = TextEditingController();
      _listEditingControllerDD[i] = TextEditingController();
      _listEditingControllerYYYY[i] = TextEditingController();
    }
  }

  String checkinstallment;

  //From Installment Page
  int noOfTextFields = 0;
  List<TextEditingController> _listEditingControllerMM;
  List<TextEditingController> _listEditingControllerDD;
  List<TextEditingController> _listEditingControllerYYYY;
  List<TextEditingController> _listEditingControllerMoney;
  Map map;
  bool editValue = false;
  final TextEditingController _maxInstallText = TextEditingController();

  Widget _createTextFields(int value) {
    if (value != 0) {
      if (toggleValue1) {
        if (_listEditingControllerMM == null) {
          _listEditingControllerMM =
              List<TextEditingController>(noOfTextFields);
          _listEditingControllerMoney =
              List<TextEditingController>(noOfTextFields);
          _listEditingControllerYYYY =
              List<TextEditingController>(noOfTextFields);
          _listEditingControllerDD =
              List<TextEditingController>(noOfTextFields);
        }
        for (int i = 0; i < noOfTextFields; i++) {
          String pass = (i + 1).toString() + "Installment";
          if (editValue) {
            if (widget.course.fees?.maxInstallment?.installment != null) {
              _listEditingControllerMoney[i] = TextEditingController()
                ..text = widget.course.fees?.maxInstallment?.installment[pass]
                        ?.amount ??
                    double.parse(
                        (double.parse(_totalText.text) / noOfTextFields)
                            .toStringAsFixed(
                              2,
                            )
                            .toString());

              List<String> duration = widget
                  .course.fees?.maxInstallment?.installment[pass]?.duration
                  ?.split(" ");
              if (duration.length > 2) {
                _listEditingControllerDD[i] = TextEditingController()
                  ..text = duration[0];
                _listEditingControllerMM[i] = TextEditingController()
                  ..text = duration[1];
                _listEditingControllerYYYY[i] = TextEditingController()
                  ..text = duration[2];
              }
            }
          } else {
            if (_listEditingControllerMoney[i] == null) {
              _listEditingControllerMoney[i] = TextEditingController()
                ..text = (double.parse(
                        (double.parse(_totalText.text) / noOfTextFields)
                            .toStringAsFixed(2))
                    .toString());
            }
            if (_listEditingControllerMM[i] == null) {
              _listEditingControllerMM[i] = TextEditingController();
            }
            if (_listEditingControllerDD[i] == null) {
              _listEditingControllerDD[i] = TextEditingController();
            }
            if (_listEditingControllerYYYY[i] == null) {
              _listEditingControllerYYYY[i] = TextEditingController();
            }
          }
        }
        editValue = false;
      }

      return Form(
        child: ListView.builder(
            shrinkWrap: true,
            controller: ScrollController(),
            itemCount: value,
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: () async {
                  String res = await showDialog(
                      context: context, builder: (context) => AreYouSure());
                  if (res != 'Yes') {
                    return;
                  }
                  setState(() {
                    dbRef
                        .reference()
                        .child(
                            "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.course.id}/fees")
                        .child(
                            "MaxInstallment/Installments/${(index + 1).toString() + "Installment"}")
                        .remove();
                    noOfTextFields -= 1;
                  });
                },
                child: Card(
                    child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    color: Color(0xffF36C24),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${index + 1} Installment',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                        height: 2,
                        thickness: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Amount',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  onChanged: (value) {},
                                  controller:
                                      _listEditingControllerMoney[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Color(0xffF36C24)),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    contentPadding: EdgeInsets.only(top: 0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "Enter value",
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                '₹',
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Last Submission Date',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                onChanged: (value) {},
                                controller: _listEditingControllerDD[index],
                                style: TextStyle(color: Color(0xffF36C24)),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    contentPadding: EdgeInsets.only(top: 0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintStyle:
                                        TextStyle(color: Color(0xffF36C24)),
                                    hintText: "DD"),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                controller: _listEditingControllerMM[index],
                                style: TextStyle(color: Color(0xffF36C24)),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    contentPadding: EdgeInsets.only(top: 0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintStyle:
                                        TextStyle(color: Color(0xffF36C24)),
                                    hintText: "MM"),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                onChanged: (value) {},
                                controller: _listEditingControllerYYYY[index],
                                style: TextStyle(color: Color(0xffF36C24)),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  contentPadding: EdgeInsets.only(top: 0),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintStyle:
                                      TextStyle(color: Color(0xffF36C24)),
                                  hintText: "YYYY",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4.0,
                          )
                        ],
                      ),
                    ],
                  ),
                )),
              );
            }),
      );
    } else
      return SizedBox(
        height: 4.0,
      );
  }

  @override
  void initState() {
    nameTextEditingController = TextEditingController()
      ..text = widget.course.name;
    descriptionTextEditingController = TextEditingController()
      ..text = widget.course.description;
    mediumTextEditingController = TextEditingController()
      ..text = widget.course.medium;
    _admissionText = TextEditingController()
      ..text = widget.course.fees?.feeSection?.admissionFees ?? "0";
    _tutionText = TextEditingController()
      ..text = widget.course.fees?.feeSection?.tutionFees ?? "0";
    _libraryText = TextEditingController()
      ..text = widget.course.fees?.feeSection?.libraryFees ?? "0";
    _labText = TextEditingController()
      ..text = widget.course.fees?.feeSection?.labFees ?? "0";
    _extraText = TextEditingController()
      ..text = widget.course.fees?.feeSection?.extraFees ?? "0";
    _totalText = TextEditingController()
      ..text = widget.course.fees?.feeSection?.totalFees ?? "0";
    if (widget.isEdit) {
      List<String> fineDuration =
          widget.course.fees?.fine?.duration?.split(" ");
      _fineDurationText = TextEditingController()
        ..text = (fineDuration.length > 1) ? fineDuration[0] : "0";
      _currentFineDurationSelected =
          (fineDuration.length > 1) ? fineDuration[1] : "Day(s)";
      _setFineText = TextEditingController()
        ..text = widget.course.fees?.fine?.fineAmount ?? "0";
    } else {
      _fineDurationText = TextEditingController()..text = "0";
      _currentFineDurationSelected = "Day(s)";
      _setFineText = TextEditingController()..text = "0";
    }

    Timer(Duration(seconds: 0), () async {
      _pref = await SharedPreferences.getInstance();
    });
    editValue = widget.isEdit;
    if (widget.isEdit) _loadFromDatabase();
    if (widget.isEdit)
      checkinstallment =
          widget.course.fees.maxInstallment.maxAllowedInstallment;

    super.initState();
  }
}
