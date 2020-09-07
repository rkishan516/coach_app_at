import 'package:flutter/material.dart';

import 'FullReport.dart';
import 'StudentModel.dart';

class PayementReport extends StatefulWidget {
  final List<StudentModel> _listStudentModel;
  PayementReport(this._listStudentModel);
  @override
  _PayementReportState createState() => _PayementReportState();
}

class _PayementReportState extends State<PayementReport> {
  List<StudentModel> _studentList = [];
  Map<String, NoInstallments> _coresspondingmap = {};
  Map<String, String> _coresspondingStatus = {};
  bool count = true;

  _setstudentlist() {
    List<StudentModel> list = [];
    widget._listStudentModel.forEach((element) {
      if (element.lastpaidInstallment != null &&
          element.lastpaidInstallment != "") {
        list.add(element);

        _coresspondingStatus[element.uid] = "Paid";
      } else {
        try {
          var index = element.listInstallment.firstWhere((element) {
            return element.status == "Due" || element.status == "Fine";
          });

          list.add(element);

          _coresspondingStatus[element.uid] = "Due";

          _coresspondingmap[element.uid] = index;
        } catch (e) {
          try {
            var index = element.listInstallment.firstWhere(
                (element) => element.fine != "" && element.status == "Fine");

            list.add(element);

            _coresspondingStatus[element.uid] = "Fine";

            _coresspondingmap[element.uid] = index;
          } catch (e) {}
        }
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
                try {
                  var indexof = _studentList[index].listInstallment.singleWhere(
                      (element) =>
                          element.sequence ==
                          _studentList[index].lastpaidInstallment);

                  String lastpaidtime = _studentList[index]
                      .listInstallment[
                          _studentList[index].listInstallment.indexOf(indexof)]
                      .paidTime
                      .toString();

                  subTitle = "Status: " +
                      "Paid" +
                      "\n" +
                      "Last Paid: " +
                      _studentList[index]
                          .lastpaidInstallment
                          .replaceAll("Installment", " Installment") +
                      "\n" +
                      "Paid Date: " +
                      lastpaidtime.replaceAll(" ", "/");
                } catch (e) {}
              } else if (_coresspondingStatus[_studentList[index].uid] ==
                  "Fine") {
                subTitle = "Status: Fine" +
                    "\n" +
                    "Fine Amount: " +
                    _coresspondingmap[_studentList[index].uid]?.fine +
                    "Type: " +
                    _coresspondingmap[_studentList[index].phoneNo]?.sequence;
              } else {
                subTitle = "Status: Due" +
                    "\n" +
                    "Due Amount: " +
                    _coresspondingmap[_studentList[index].uid]?.amount +
                    "\n" +
                    "Due Date: " +
                    _coresspondingmap[_studentList[index].uid]
                        ?.duration
                        ?.replaceAll(" ", "/") +
                    "\n" +
                    "Type: " +
                    _coresspondingmap[_studentList[index].uid]?.sequence;
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
                                : Color(0xffF36C24),
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
            }));
  }
}
