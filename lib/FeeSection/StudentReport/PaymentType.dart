import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'OneTimePay.dart';
import 'StuInstallment.dart';

class PaymentType extends StatefulWidget {
  final String courseId;
  final String courseName;
  PaymentType({this.courseId, this.courseName});
  @override
  _PaymentTypeState createState() => _PaymentTypeState();
}

class _PaymentTypeState extends State<PaymentType> {
  bool toggleValue1 = false;
  bool toggleValue2 = false;
  bool _showInstallmenttype = false;
  bool _showOneTimetype = false;
  String _titleString = "";
  double sum = 0.0;
  double fine = 0.0;
  String _displaySum = "";
  bool _allowonetime = false;
  final dbref = FirebaseDatabase.instance;
  _loadFromDatabase() async {
    DataSnapshot _installmentsnapshot = await dbref
        .reference()
        .child(
            "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseId}/fees/MaxInstallment/IsMaxAllowed")
        .once();
    DataSnapshot _onetimesnapshot = await dbref
        .reference()
        .child(
            "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseId}/fees/OneTime/IsOneTimeAllowed")
        .once();
    if (!_installmentsnapshot.value && _installmentsnapshot.value != null) {
      print(">>>>>>>>");
      _allowonetime = true;
      DataSnapshot _onetimesnapshot = await dbref
          .reference()
          .child(
              "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/${FireBaseAuth.instance.user.uid}/course/${widget.courseId}/fees/Installments")
          .once();
      if (_onetimesnapshot.value != null) {
        Map map = _onetimesnapshot.value;
        sum = 0.0;
        fine = 0.0;

        map.forEach((key, value) {
          if (key != "AllowedThrough" &&
              key != "LastPaidInstallment" &&
              key != "OneTime" &&
              value["Status"] == "Paid") {
            sum += value["Amount"] != "" ? double.parse(value["Amount"]) : 0.0;
            fine += value["Fine"] != "" ? double.parse(value["Fine"]) : 0.0;
          }
        });
        if (fine != 0.0) {
          _displaySum =
              sum.toStringAsFixed(2) + " + " + fine.toStringAsFixed(2);
          print(">>>>>>>>>>>");
          print(_displaySum);
        } else {
          _displaySum = sum.toStringAsFixed(2);
          print(">>>>>>>>>>>");
          print(_displaySum);
        }

        //  setState(() {
        //     _noticetext= "Amount paid through installments is $_displaySum , Pay rest amount in OneTime as Pay through installments is disabled by the administration";
        //   });

      }
    }

    dbref
        .reference()
        .child(
            "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/${FireBaseAuth.instance.user.uid}/course/${widget.courseId}/fees/Installments/AllowedThrough")
        .once()
        .then((snapshot) {
      if (snapshot.value == "Installments") {
        setState(() {
          toggleValue1 = true;
          toggleValue2 = false;
        });
        if (toggleValue1 && _installmentsnapshot.value) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (coontext) => StuInstallment(
                toggleValue1,
                courseId: widget.courseId,
                courseName: widget.courseName,
              ),
            ),
          );
        }
      } else if (snapshot.value == "OneTime") {
        setState(() {
          toggleValue2 = true;
          toggleValue1 = false;
        });
        if (toggleValue2 && _onetimesnapshot.value)
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OneTimeInstallment(
                toggleValue: toggleValue2,
                courseName: widget.courseName,
                courseId: widget.courseId,
                displaysum: _displaySum,
                paidfine: fine,
                paidsum: sum,
              ),
            ),
          );
      } else {
        setState(() {
          toggleValue1 = false;
          toggleValue2 = false;
        });
      }
    });

    _showInstallmenttype = _installmentsnapshot.value ?? false;
    _showOneTimetype = _onetimesnapshot.value ?? false;

    setState(() {
      toggleValue1 = !_showInstallmenttype;
      toggleValue2 = !_showOneTimetype;
      if (!_showInstallmenttype && _showOneTimetype && sum == 0.0)
        toggleButton2();
      else if (_showInstallmenttype && !_showOneTimetype) toggleButton1();

      _titleString = _showOneTimetype || _showInstallmenttype
          ? 'Select Payment Type'
          : "No Type available";
      _displaySum = _displaySum;
    });
  }

  @override
  void initState() {
    super.initState();

    _loadFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Type"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                _titleString,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              if (_showInstallmenttype)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Pay in Installments',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onLongPress: () {
                          if (toggleValue1)
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (coontext) => StuInstallment(
                                  toggleValue1,
                                  courseId: widget.courseId,
                                  courseName: widget.courseName,
                                ),
                              ),
                            );
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
                                    if (!toggleValue1 && !toggleValue2)
                                      toggleButton1();
                                  },
                                  child: AnimatedSwitcher(
                                    duration: Duration(microseconds: 1000),
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
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
                    ),
                  ],
                )
              else
                _displaySum != "" && !toggleValue2
                    ? Container(
                        padding: EdgeInsets.all(10.0),
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.orange,
                        ),
                        child: Text(
                          "Amount paid through installments is $_displaySum , Pay rest amount in OneTime as Pay through installments is disabled by the administration",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      )
                    : SizedBox(
                        height: 10.0,
                      ),
              SizedBox(
                height: 40.0,
              ),
              if (_showOneTimetype)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Pay One Time',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onLongPress: () {
                          if (toggleValue2)
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => OneTimeInstallment(
                                  toggleValue: toggleValue2,
                                  courseName: widget.courseName,
                                  courseId: widget.courseId,
                                  displaysum: _displaySum,
                                  paidfine: fine,
                                  paidsum: sum,
                                ),
                              ),
                            );
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
                                    if (!toggleValue1 && !toggleValue2 ||
                                        _allowonetime) toggleButton2();
                                  },
                                  child: AnimatedSwitcher(
                                    duration: Duration(microseconds: 1000),
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
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
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  toggleButton1() {
    setState(() {
      toggleValue1 = !toggleValue1;
      if (toggleValue1) {
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => StuInstallment(
              !toggleValue1,
              courseId: widget.courseId,
              courseName: widget.courseName,
            ),
          ),
        )
            .then((value) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          return;
        });
      } else {}
    });
  }

  toggleButton2() {
    setState(() {
      toggleValue2 = !toggleValue2;
      if (toggleValue2) {
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => OneTimeInstallment(
              courseName: widget.courseName,
              courseId: widget.courseId,
              toggleValue: !toggleValue2,
              displaysum: _displaySum,
              paidfine: fine,
              paidsum: sum,
            ),
          ),
        )
            .then((value) {
          Navigator.of(context).pop();
          return;
        });
      } else {}
    });
  }
}
