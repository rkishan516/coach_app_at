import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'OneTimePay.dart';
import 'StuInstallment.dart';

class PaymentType extends StatefulWidget {
  final bool isFromDrawer;
  final String courseId;
  final String courseName;
  PaymentType({this.courseId, this.courseName, this.isFromDrawer = false});
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
    //Checking IsMaxAllowed
    DataSnapshot _installmentsnapshot = await dbref
        .reference()
        .child(
            "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseId}/fees/MaxInstallment/IsMaxAllowed")
        .once();
    //Checking IsOneTimeAllowed
    DataSnapshot _onetimesnapshot = await dbref
        .reference()
        .child(
            "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseId}/fees/OneTime/IsOneTimeAllowed")
        .once();

    //If Installments are off
    if (_installmentsnapshot.value != null) {
      if (!_installmentsnapshot.value) {
        _allowonetime = true;

        //Previous payment collection
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
              sum +=
                  value["Amount"] != "" ? double.parse(value["Amount"]) : 0.0;
              fine += value["Fine"] != "" ? double.parse(value["Fine"]) : 0.0;
            }
          });
          if (fine != 0.0) {
            _displaySum =
                sum.toStringAsFixed(2) + " + " + fine.toStringAsFixed(2);
          } else {
            _displaySum = sum.toStringAsFixed(2);
          }
        }
      }
    }

    //Navigate through last payment method
    DataSnapshot dataSnapshot = await dbref
        .reference()
        .child(
            "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/${FireBaseAuth.instance.user.uid}/course/${widget.courseId}/fees/Installments/AllowedThrough")
        .once();
    if (dataSnapshot.value == "Installments") {
      setState(() {
        toggleValue1 = true;
        toggleValue2 = false;
      });
      if (_installmentsnapshot.value != null) {
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
          return;
        }
      }
    } else if (dataSnapshot.value == "OneTime") {
      setState(() {
        toggleValue2 = true;
        toggleValue1 = false;
      });
      if (_onetimesnapshot.value != null) {
        if (toggleValue2 && _onetimesnapshot.value)
          Navigator.of(context).pushReplacement(
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
        return;
      }
    } else {
      setState(() {
        toggleValue1 = false;
        toggleValue2 = false;
      });
    }

    _showInstallmenttype = _installmentsnapshot.value ?? false;
    _showOneTimetype = _onetimesnapshot.value ?? false;

    setState(() {
      toggleValue1 = !_showInstallmenttype;
      toggleValue2 = !_showOneTimetype;
      if (!_showInstallmenttype && _showOneTimetype && sum == 0.0)
        toggleButton2(widget.isFromDrawer);
      else if (_showInstallmenttype && !_showOneTimetype)
        toggleButton1(widget.isFromDrawer);

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
                SwitchListTile.adaptive(
                  activeColor: Color(0xffF36C24),
                  title: Text(
                    'Pay in Installments',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                  ),
                  value: toggleValue1,
                  onChanged: (val) {
                    if (!toggleValue1 && !toggleValue2) toggleButton1(false);
                  },
                )
              else
                _displaySum != "" && !toggleValue2
                    ? Container(
                        padding: EdgeInsets.all(10.0),
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Color(0xffF36C24),
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
                SwitchListTile.adaptive(
                  activeColor: Color(0xffF36C24),
                  value: toggleValue2,
                  onChanged: (val) {
                    if (!toggleValue1 && !toggleValue2 || _allowonetime)
                      toggleButton2(false);
                  },
                  title: Text(
                    'Pay One Time',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  toggleButton1(bool fromLFD) {
    setState(() {
      toggleValue1 = !toggleValue1;
      if (toggleValue1) {
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => StuInstallment(
              !fromLFD ? !toggleValue1 : toggleValue1,
              courseId: widget.courseId,
              courseName: widget.courseName,
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

  toggleButton2(bool fromLFD) {
    setState(() {
      toggleValue2 = !toggleValue2;
      if (toggleValue2) {
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => OneTimeInstallment(
              courseName: widget.courseName,
              courseId: widget.courseId,
              toggleValue: fromLFD ? toggleValue2 : !toggleValue2,
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

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double b;
  static double v;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    b = screenWidth / 100;
    v = screenHeight / 100;
  }
}
