
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
  _loadFromDatabase() async {
    setState(() {
      _totalFees = _studentModel.totalFees;
      if (_studentModel.lastpaidInstallment == "OneTime") {
        double totalfees = double.parse(_totalFees);
        double discount = double.parse(
            _studentModel.discount != null ? _studentModel.discount : "0.0");
        double fine = double.parse(_studentModel.listInstallment[0].fine != null
            ? _studentModel.listInstallment[0].fine
            : "0.0");
        amountPaidstr = _studentModel.discount != null
            ? (totalfees * (1 - ((discount) / 100)) + fine).toString()
            : (fine + totalfees).toString();
      }
      else{
      
        _studentModel.listInstallment.forEach((element) { 
          if(element.status=="Paid"){
          amountPaidstr=( double.parse(amountPaidstr)+ double.parse(element.amount)+ double.parse(element.fine!=""?element.fine:"0.0")).toString();      

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
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(12.0),
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.orange),
              child: Column(
                children: [
                  Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Image.network(_studentModel.photoURL),
                      ),
                      title: Text(_studentModel.name),
                      subtitle: Text(
                          _studentModel.address + "\n" + _studentModel.phoneNo),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            "Email",
                            style: TextStyle(fontSize: 18.0),
                          )),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                          flex: 2,
                          child: Text(
                            _studentModel.email,
                            style: TextStyle(fontSize: 16.0),
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
                            "Course",
                            style: TextStyle(fontSize: 18.0),
                          )),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                          flex: 2,
                          child: Text(
                            _studentModel.courseName,
                            style: TextStyle(fontSize: 16.0),
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
                            "Acaedmic Session",
                            style: TextStyle(fontSize: 18.0),
                          )),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                          flex: 2,
                          child: Text(
                            _studentModel.acaedmicYear,
                            style: TextStyle(fontSize: 16.0),
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
                            "Payment Type",
                            style: TextStyle(fontSize: 18.0),
                          )),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                          flex: 2,
                          child: Text(
                            _studentModel.allowedthrough,
                            style: TextStyle(fontSize: 16.0),
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
                            "Total Fees",
                            style: TextStyle(fontSize: 18.0),
                          )),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                          flex: 2,
                          child: Text(
                            _studentModel.totalFees,
                            style: TextStyle(fontSize: 16.0),
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
                            "Last Paid",
                            style: TextStyle(fontSize: 18.0),
                          )),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                          flex: 2,
                          child: Text(
                            _studentModel.lastpaidInstallment,
                            style: TextStyle(fontSize: 16.0),
                          ))
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
                                  style: TextStyle(fontSize: 16.0),
                                ))
                          ],
                        )
                      : SizedBox(
                          width: 10.0,
                        ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            "Amount paid",
                            style: TextStyle(fontSize: 18.0),
                          )),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                          flex: 2,
                          child: Text(
                            amountPaidstr,
                            style: TextStyle(fontSize: 16.0),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Expanded(
                    flex: _studentModel.lastpaidInstallment=="OneTime"?1:3,
                    child: Container(
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: _studentModel.listInstallment.length == 1
                          ? MediaQuery.of(context).size.height * 0.1
                          : MediaQuery.of(context).size.height * 0.4,
                      child: ListView.builder(
                          itemCount: _studentModel.listInstallment.length,
                          itemBuilder: (context, index) {
                            String paidtime =
                                _studentModel.listInstallment[index].paidTime !=""? "Payment Date: " +_studentModel.listInstallment[index].paidTime.replaceAll(" ", "/"): "";
                            String fineamount =
                                _studentModel.listInstallment[index].fine != ""? " + " +_studentModel.listInstallment[index].fine: "";

                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: ListTile(
                                title: Text(_studentModel
                                    .listInstallment[index].sequence),
                                subtitle: Text("Status: " +_studentModel.listInstallment[index].status +"\n" +paidtime),
                                trailing: Text(_studentModel.listInstallment[index].amount +fineamount),
                              ),
                            );
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Expanded(
                    flex: 1,
                                      child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            child: Text(
                              "E Receipt",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            onPressed: () {
                              //TODO
                            },
                          ),
                        )
                      ],
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
}
