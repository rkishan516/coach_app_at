import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Installments.dart';

class FeeReceipt extends StatefulWidget {
  final bool isEdit;
  final String courseid;
  final Courses course;
  FeeReceipt({this.isEdit, this.courseid,this.course});
  @override
  _FeeReceiptState createState() => _FeeReceiptState();
}

class _FeeReceiptState extends State<FeeReceipt> {
  final TextEditingController _admissionText = TextEditingController(text: "0");
  final TextEditingController _labText = TextEditingController(text: "0");
  final TextEditingController _extraText = TextEditingController(text: "0");
  final TextEditingController _tutionText = TextEditingController(text: "0");
  final TextEditingController _libraryText = TextEditingController(text: "0");
  final TextEditingController _totalText = TextEditingController(text: "0");
  final TextEditingController _setFineText = TextEditingController(text: "0");
  final TextEditingController _fineDurationText =
      TextEditingController(text: "0");
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
  var _currentFineDurationSelected = "Day(s)";
  var _mmSelected = "MM";
  bool toggleValue1 = false;
  bool toggleValue2 = false;
  bool toggleValue3 = false;
  bool isEdit;
  String _prevTotalText = "";
  _changeTotalFees(value) {
    print(value);
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

  _sharedprefinit() async {
    _pref = await SharedPreferences.getInstance();
    _prevTotalText = _pref.getString("${widget.courseid}");
  }

  _saveintodatabase() {
    if (toggleValue1 && _totalText.text != _prevTotalText) {
      showErrorDialog(context);
      return;
    }
    if (widget.isEdit == false) {
      FirebaseDatabase.instance
          .reference()
          .child(
              'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.course.id}')
          .update(widget.course.toJson());
      FirebaseDatabase.instance
          .reference()
          .child(
              'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/coursesList/')
          .update({widget.course.id: widget.course.name});
    }

    dbRef
        .reference()
        .child(
            "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseid}")
        .child("fees")
        .update({
      "FeeSection": {
        "AdmissionFees": _admissionText.text,
        "TutionFees": _tutionText.text,
        "LabFees": _labText.text,
        "LibraryFees": _libraryText.text,
        "ExtraFees": _extraText.text,
        "TotalFees": _totalText.text
      },
      "SetFine": {
        "IsFineAllowed": toggleValue2,
        "FineAmount": _setFineText.text,
        "Duration": _fineDurationText.text + " " + _currentFineDurationSelected
      },
      "OneTime": {
        "IsOneTimeAllowed": toggleValue3,
        "Duration": _ddText.text + " " + _mmSelected + " " + _yyText.text
      }
    });
    if (!toggleValue1) {
      dbRef
          .reference()
          .child(
              "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseid}/fees")
          .child("MaxInstallment")
          .update({"IsMaxAllowed": false});
      dbRef
          .reference()
          .child(
              "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseid}/fees")
          .child("MaxInstallment/Installments")
          .remove();
    }
    _pref.setString("${widget.courseid}", _totalText.text);
    Navigator.of(context).pop();
  }

  Widget _feeSection() {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Color(0xffF36C24), borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    'Admission Fees',
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),
                  )),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  onChanged: (value) {
                    _changeTotalFees(value);
                  },
                  controller: _admissionText,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Enter value"),
                ),
              ),
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
                  onChanged: (value) {
                    _changeTotalFees(value);
                  },
                  controller: _tutionText,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Enter value"),
                ),
              ),
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
                  onChanged: (value) {
                    _changeTotalFees(value);
                  },
                  controller: _libraryText,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Enter value"),
                ),
              ),
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
                  onChanged: (value) {
                    _changeTotalFees(value);
                  },
                  controller: _labText,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Enter value"),
                ),
              ),
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
                  onChanged: (value) {
                    _changeTotalFees(value);
                  },
                  controller: _extraText,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: "Enter Value"),
                ),
              ),
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
              decoration: InputDecoration(
                filled: true,
                enabled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
          ),
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
            width: 10.0,
          ),
          GestureDetector(
            onLongPress: () {
              if (toggleValue1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Installments(_totalText.text,
                            toggleValue1, widget.courseid))).then((value) {
                  if (value == "confirm") _prevTotalText = _totalText.text;
                });
              }
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              height: 40.0,
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: toggleValue1
                    ? Colors.greenAccent[100]
                    : Colors.redAccent[100].withOpacity(0.5),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.easeIn,
                    left: toggleValue1 ? 60.0 : 0.0,
                    right: toggleValue1 ? 0.0 : 60.0,
                    child: InkWell(
                      onTap: () {
                        if (_totalText.text != "0") {
                          isEdit = false;
                          if (!toggleValue1) {
                            //TODO
                          }
                          toogleButton1();
                        }
                      },
                      child: AnimatedSwitcher(
                        duration: Duration(microseconds: 1000),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return RotationTransition(
                            child: child,
                            turns: animation,
                          );
                        },
                        child: toggleValue1
                            ? Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 35.0,
                                key: UniqueKey(),
                              )
                            : Icon(
                                Icons.remove_circle_outline,
                                color: Colors.red,
                                size: 35.0,
                                key: UniqueKey(),
                              ),
                      ),
                    ),
                  )
                ],
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
            width: 10.0,
          ),
          GestureDetector(
            onLongPress: () {
              if (toggleValue3)
                showErrorDialog3(context).then((value) {
                  if (value == "ok") {
                    setState(() {
                      if (_ddText.text == "0" || _yyText.text == "0")
                        toggleValue3 = false;
                    });
                  }
                });
              ;
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              height: 40.0,
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: toggleValue3
                    ? Colors.greenAccent[100]
                    : Colors.redAccent[100].withOpacity(0.5),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.easeIn,
                    left: toggleValue3 ? 60.0 : 0.0,
                    right: toggleValue3 ? 0.0 : 60.0,
                    child: InkWell(
                      onTap: () {
                        if (_totalText.text != "0") {
                          isEdit = false;
                          if (!toggleValue3) {
                            _ddText.text = "";
                            _yyText.text = "";
                            _mmSelected = "MM";
                          }
                          toogleButton3();
                        }
                      },
                      child: AnimatedSwitcher(
                        duration: Duration(microseconds: 1000),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return RotationTransition(
                            child: child,
                            turns: animation,
                          );
                        },
                        child: toggleValue3
                            ? Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 35.0,
                                key: UniqueKey(),
                              )
                            : Icon(
                                Icons.remove_circle_outline,
                                color: Colors.red,
                                size: 35.0,
                                key: UniqueKey(),
                              ),
                      ),
                    ),
                  )
                ],
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
            width: 10.0,
          ),
          GestureDetector(
            onLongPress: () {
              if (toggleValue2)
                showErrorDialog2(context).then((value) {
                  if (value == "ok") {
                    setState(() {
                      if (_fineDurationText.text == "0" ||
                          _setFineText.text == "0") toggleValue2 = false;
                    });
                  }
                });
              ;
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              height: 40.0,
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: toggleValue2
                    ? Colors.greenAccent[100]
                    : Colors.redAccent[100].withOpacity(0.5),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.easeIn,
                    left: toggleValue2 ? 60.0 : 0.0,
                    right: toggleValue2 ? 0.0 : 60.0,
                    child: InkWell(
                      onTap: () {
                        if (_totalText.text != "0") {
                          isEdit = false;
                          if (!toggleValue2) {
                            _fineDurationText.text = "0";
                            _setFineText.text = "0";
                            _currentFineDurationSelected = "Day(s)";
                          }
                          toogleButton2();
                        }
                      },
                      child: AnimatedSwitcher(
                        duration: Duration(microseconds: 1000),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return RotationTransition(
                            child: child,
                            turns: animation,
                          );
                        },
                        child: toggleValue2
                            ? Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 35.0,
                                key: UniqueKey(),
                              )
                            : Icon(
                                Icons.remove_circle_outline,
                                color: Colors.red,
                                size: 35.0,
                                key: UniqueKey(),
                              ),
                      ),
                    ),
                  )
                ],
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
        ),
      ),
    );
  }

  _loadFromDatabase() async {
    dbRef
        .reference()
        .child(
            "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseid}")
        .child("fees")
        .once()
        .then((snapshot) {
      print(snapshot.value);
      Map map = snapshot.value;

      setState(() {
        _admissionText.text = map["FeeSection"]["AdmissionFees"];
        _tutionText.text = map["FeeSection"]["TutionFees"];
        _libraryText.text = map["FeeSection"]["LibraryFees"];
        _labText.text = map["FeeSection"]["LabFees"];
        _extraText.text = map["FeeSection"]["ExtraFees"];
        _totalText.text = map["FeeSection"]["TotalFees"];
        toggleValue1 =
            map["MaxInstallment"]["IsMaxAllowed"] == true ? true : false;
        toggleValue2 = map["SetFine"]["IsFineAllowed"] == true ? true : false;
        toggleValue3 =
            map["OneTime"]["IsOneTimeAllowed"] == true ? true : false;
        _fineDurationText.text =
            map["SetFine"]["Duration"].toString().split(" ")[0];
        _currentFineDurationSelected =
            map["SetFine"]["Duration"].toString().split(" ")[1];
        _setFineText.text = map["SetFine"]["FineAmount"];

        _ddText.text = map["OneTime"]["Duration"].toString().split(" ")[0];
        _yyText.text = map["OneTime"]["Duration"].toString().split(" ")[2];
        _mmSelected = map["OneTime"]["Duration"].toString().split(" ")[1];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.isEdit != null)
      isEdit = true;
    else
      isEdit = false;

    if (isEdit) _loadFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fee Structure'),
        ),
        body: ListView(padding: EdgeInsets.all(20.0), children: [
          _feeSection(),
          _totalfees(),
          Divider(
            height: 48.0,
            thickness: 2.0,
          ),
          _attachMaxNoofInstallment(),
          _attachOneTimePay(),
          _setFine(),
          Divider(
            height: 48.0,
            thickness: 2.0,
          ),
          _saveButton()
        ]));
  }

  toogleButton1() {
    setState(() {
      toggleValue1 = !toggleValue1;
      bool dup = !toggleValue1;
      if (toggleValue1 && !isEdit) {
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (context) =>
                    Installments(_totalText.text, dup, widget.courseid)))
            .then((value) {
          if (value == "confirm") {
            setState(() {
              toggleValue1 = true;
              _prevTotalText = _totalText.text;
              print("iii");
            });
          } else {
            setState(() {
              toggleValue1 = false;
              print("LLLL");
            });
          }
        });
      } else {}
    });
  }

  Future showErrorDialog2(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Set Fine'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _setFineText,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: "Enter value"),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Enter Duration for Fine',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: _fineDurationText,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter value"),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        flex: 2,
                        child: DropdownButton<String>(
                          items:
                              durationperiod.map((String dropDownStringitem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringitem,
                              child: Text(dropDownStringitem),
                            );
                          }).toList(),
                          onChanged: (String newValueSelected) {
                            setState(() {
                              this._currentFineDurationSelected =
                                  newValueSelected;
                            });
                          },
                          isExpanded: false,
                          hint: Text('Select Period'),
                          value: _currentFineDurationSelected,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop("ok");
                },
              ),
              new FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop("cancel");
                },
              )
            ],
          );
        });
  }

  toogleButton2() {
    setState(() {
      toggleValue2 = !toggleValue2;
      if (toggleValue2 && !isEdit) {
        showErrorDialog2(context).then((value) {
          if (value == "ok") {
            setState(() {
              if (_fineDurationText.text == "0" || _setFineText.text == "0")
                toggleValue2 = false;
            });
          } else {
            setState(() {
              toggleValue2 = false;
            });
          }
        });
      } else {
        if (!isEdit) {
          _fineDurationText.text = "0";
          _setFineText.text = "0";
          _currentFineDurationSelected = "Day(s)";
        }
      }
    });
  }

  Future showErrorDialog3(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Set End Time'),
            content: SingleChildScrollView(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextField(
                      onChanged: (value) {
                        //TODO
                      },
                      controller: _ddText,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: "DD"),
                    ),
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButton<String>(
                      items: _mmperiod.map((String dropDownStringitem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringitem,
                          child: Text(dropDownStringitem),
                        );
                      }).toList(),
                      onChanged: (String newValueSelected) {
                        setState(() {
                          _mmSelected = newValueSelected;
                          print(_mmSelected);
                        });
                      },
                      isExpanded: true,
                      hint: Text('MM'),
                      value: _mmSelected,
                    ),
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      onChanged: (value) {
                        //TODO
                      },
                      controller: _yyText,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: "YYYY"),
                    ),
                  ),
                  SizedBox(
                    width: 4.0,
                  )
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop("ok");
                },
              ),
              new FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop("cancel");
                },
              )
            ],
          );
        });
  }

  toogleButton3() {
    setState(() {
      toggleValue3 = !toggleValue3;
      if (toggleValue3 && !isEdit) {
        showErrorDialog3(context).then((value) {
          if (value == "ok") {
            setState(() {
              if (_yyText.text == "" ||
                  _ddText.text == "" ||
                  _mmSelected == "MM") toggleValue3 = false;
            });
          } else {
            setState(() {
              toggleValue3 = false;
            });
          }
        });
      } else {
        if (!isEdit) {
          _yyText.text = "";
          _ddText.text = "";
          _mmSelected = "MM";
        }
      }
    });
  }
}
