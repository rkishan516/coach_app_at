import 'package:coach_app/Utils/Colors.dart';
import 'package:flutter/material.dart';

import 'FullReport.dart';
import 'StudentModel.dart';

class PaidReport extends StatefulWidget {
  final List<StudentModel> _listStudentModel;
  PaidReport(this._listStudentModel);
  @override
  _PaidReportState createState() => _PaidReportState();
}

class _PaidReportState extends State<PaidReport> {
  List<StudentModel> _studentList = [];
  _setstudentlist() {
    List<StudentModel> list = [];
    try {
      widget._listStudentModel.forEach((element) {
        if (element.lastpaidInstallment != null &&
            element.lastpaidInstallment != "OneTime") {
          list.add(element);
        }
      });
      setState(() {
        _studentList = list;
      });
    } catch (e) {}
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
          var indexof;

          String lastpaidtime = "";
          String amount = "";
          try {
            indexof = _studentList[index].listInstallment.singleWhere(
                (element) =>
                    element.sequence ==
                    _studentList[index].lastpaidInstallment);

            if (indexof != null) {
              lastpaidtime = _studentList[index]
                  .listInstallment[
                      _studentList[index].listInstallment.indexOf(indexof)]
                  .paidTime
                  .toString();
              amount = _studentList[index]
                  .listInstallment[
                      _studentList[index].listInstallment.indexOf(indexof)]
                  .amount;
            }
          } catch (e) {
            return null;
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
                      (index + 1).toString() + ". " + _studentList[index]?.name,
                      style: TextStyle(
                        color: _studentList[index]?.paymentType == "Online"
                            ? Colors.green
                            : GuruCoolLightColor.primaryColor,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Last Paid: " +
                          _studentList[index]
                              .lastpaidInstallment
                              .replaceAll("Installment", " Installment") +
                          "\n" +
                          "Paid Date: " +
                          lastpaidtime.replaceAll(" ", "/") +
                          "\n"
                              "Paid Amount: " +
                          amount,
                      style: TextStyle(fontSize: 12.0),
                    ),
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
