import 'package:coach_app/Utils/Colors.dart';
import 'package:flutter/material.dart';

import 'FullReport.dart';
import 'StudentModel.dart';

class OneTimeReport extends StatefulWidget {
  final List<StudentModel> _listStudentModel;
  OneTimeReport(this._listStudentModel);
  @override
  _PayementReportState createState() => _PayementReportState();
}

class _PayementReportState extends State<OneTimeReport> {
  List<StudentModel> _studentList = [];
  Map<String, NoInstallments> _coresspondingmap = {};
  Map<String, String> _coresspondingStatus = {};
  bool count = true;

  _setstudentlist() {
    List<StudentModel> list = [];
    widget._listStudentModel.forEach((element) {
      if (element.lastpaidInstallment != null &&
          element.lastpaidInstallment == "OneTime") {
        list.add(element);

        _coresspondingStatus[element.uid] = "Paid";
      }
    });
    setState(() {
      _studentList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    _setstudentlist();

    return Container(
      padding: EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: _studentList.length,
        itemBuilder: (context, index) {
          String subTitle = "";

          if (_coresspondingStatus[_studentList[index].uid] == "Paid") {
            var indexof = _studentList[index].listInstallment.singleWhere(
                (element) =>
                    element.sequence ==
                    _studentList[index].lastpaidInstallment);

            String lastpaidtime = _studentList[index]
                .listInstallment[
                    _studentList[index].listInstallment.indexOf(indexof)]
                .paidTime
                .toString();
            String amount = _studentList[index]
                .listInstallment[
                    _studentList[index].listInstallment.indexOf(indexof)]
                .amount
                .toString();

            subTitle = "Paid Date: " +
                lastpaidtime.replaceAll(" ", "/") +
                "\n" +
                "Paid Amount: " +
                amount;
          } else if (_coresspondingStatus[_studentList[index].uid] == "Fine") {
            subTitle = "Fine of " +
                _coresspondingmap[_studentList[index].uid].fine +
                " in " +
                _coresspondingmap[_studentList[index].phoneNo].sequence;
          } else {
            subTitle =
                "Due " + _coresspondingmap[_studentList[index].uid].sequence;
          }

          return Card(
            elevation: 20,
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FullReport(
                    _studentList[index],
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                ),
                padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                child: ListView(
                  controller: ScrollController(),
                  shrinkWrap: true,
                  children: [
                    Text(
                      (index + 1).toString() +
                              ". " +
                              _studentList[index]?.name ??
                          "",
                      style: TextStyle(
                        color: _studentList[index]?.paymentType == "Online"
                            ? Colors.green
                            : GuruCoolLightColor.primaryColor,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      subTitle,
                      style: TextStyle(fontSize: 12.0),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
