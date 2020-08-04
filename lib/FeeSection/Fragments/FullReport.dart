import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'StudentModel.dart';

class FullReport extends StatefulWidget {
  final StudentModel studentModel;
  FullReport(this.studentModel);
  @override
  _FullReportState createState() => _FullReportState(studentModel);
}

class _FullReportState extends State<FullReport> {
  StudentModel _studentModel;
  String amountPaidstr = "0.0";
  _FullReportState(this._studentModel);
  final dbref = FirebaseDatabase.instance;
  String _totalFees = "";
  String text = "";
  String _paidInstallment = "0.0 + 0.0";
  _loadFromDatabase() async {
    if (_studentModel.lastpaidInstallment == "OneTime") {
      DataSnapshot snapshot = await dbref
          .reference()
          .child(
              "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/${_studentModel.uid}/course/${_studentModel.courseID}/fees/Installments/OneTime")
          .once();
      Map map = snapshot.value;
      text = map["PaidInstallment"] + " + " + map["PaidFine"];
    }
    setState(() {
      _totalFees = _studentModel.totalFees;
      if (_studentModel.lastpaidInstallment == "OneTime") {
        double totalfees = double.parse(_totalFees);
        double discount = double.parse(
            _studentModel.discount != null ? _studentModel.discount : "0.0");
        double fine = double.parse(_studentModel.listInstallment[0].fine != ""
            ? _studentModel.listInstallment[0].fine
            : "0.0");
        amountPaidstr = _studentModel.discount != null
            ? (totalfees * (1 - ((discount) / 100)) + fine).toString()
            : (fine + totalfees).toString();
        _paidInstallment = text;
      } else {
        _studentModel.listInstallment.forEach((element) {
          if (element.status == "Paid") {
            amountPaidstr = (double.parse(amountPaidstr) +
                    double.parse(element.amount) +
                    double.parse(element.fine != "" ? element.fine : "0.0"))
                .toString();
          }
        });
      }
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
        title: Text("Full Report"),
        backgroundColor: Color(0xffF36C24),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ListView(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Image.network(_studentModel.photoURL),
              ),
              title: Text(
                _studentModel.name,
                style: TextStyle(
                  color: Color(
                    0xffF36C24,
                  ),
                ),
              ),
              subtitle: Text(_studentModel.email),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Contact No : ",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    _studentModel.phoneNo,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(
                        0xffF36C24,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Address : ",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    _studentModel.address,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(
                        0xffF36C24,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Course : ",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                    flex: 2,
                    child: Text(
                      _studentModel.courseName,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(
                          0xffF36C24,
                        ),
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Acaedmic Session : ",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                    flex: 2,
                    child: Text(
                      _studentModel.acaedmicYear,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(
                          0xffF36C24,
                        ),
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Payment Type : ",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    _studentModel.allowedthrough,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(
                        0xffF36C24,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Total Fees : ",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    _studentModel.totalFees,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(
                        0xffF36C24,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      "Last Paid : ",
                      style: TextStyle(fontSize: 18.0),
                    )),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    _studentModel.lastpaidInstallment,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(
                        0xffF36C24,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            _studentModel.discount != null
                ? Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            "Discount",
                            style: TextStyle(fontSize: 18.0),
                          )),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          _studentModel.discount + "%",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(
                              0xffF36C24,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : SizedBox(
                    width: 10.0,
                  ),
            if (_studentModel.lastpaidInstallment == "OneTime" &&
                _paidInstallment != "0.0 + 0.0")
              SizedBox(
                height: 15.0,
              ),
            if (_studentModel.lastpaidInstallment == "OneTime" &&
                _paidInstallment != "0.0 + 0.0")
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Text(
                        "Paid Installment",
                        style: TextStyle(fontSize: 18.0),
                      )),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      _paidInstallment,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(
                          0xffF36C24,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      "Amount paid : ",
                      style: TextStyle(fontSize: 18.0),
                    )),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    amountPaidstr,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(
                        0xffF36C24,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            ListView.builder(
              controller: ScrollController(),
              shrinkWrap: true,
              itemCount: _studentModel.listInstallment.length,
              itemBuilder: (context, index) {
                String paidtime =
                    _studentModel.listInstallment[index].paidTime != ""
                        ? "Payment Date: " +
                            _studentModel.listInstallment[index].paidTime
                                .replaceAll(" ", "/")
                        : "";
                String fineamount =
                    _studentModel.listInstallment[index].fine != ""
                        ? " + " + _studentModel.listInstallment[index].fine
                        : "";

                return Card(
                  color: Color(0xffF36C24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    title: Text(_studentModel.listInstallment[index].sequence),
                    subtitle: Text(
                      "Status: " +
                          _studentModel.listInstallment[index].status +
                          "\n" +
                          paidtime,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    trailing: Text(
                      _studentModel.listInstallment[index].amount + fineamount,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 42, right: 42),
              child: RaisedButton(
                color: Color(0xffF36C24),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Text(
                  "E Receipt",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
