import 'package:coach_app/Utils/Colors.dart';
import 'package:flutter/material.dart';

import 'FullReport.dart';
import 'StudentModel.dart';

class FineReport extends StatefulWidget {
  final List<StudentModel> _listStudentModel;
  FineReport(this._listStudentModel);
  @override
  _FineReportState createState() => _FineReportState();
}

class _FineReportState extends State<FineReport> {
  List<StudentModel> _studentList = [];
  Map<String, NoInstallments> _coresspondingmap = {};
  _setstudentlist() {
    List<StudentModel> list = [];

    widget._listStudentModel.forEach((element) {
      try {
        var index = element.listInstallment.firstWhere((element) =>
            element.fine != "" &&
            element.fine != "0.0" &&
            element.status == "Fine");
        if (index != null) {
          list.add(element);
          _coresspondingmap[element.uid] = index;
        }
      } catch (e) {}
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
          String _type = _studentList[index].allowedthrough == "OneTime"
              ? _studentList[index].allowedthrough
              : _coresspondingmap[_studentList[index].uid].sequence;
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
                      "Type: " +
                          _type +
                          "\n" +
                          "Fine: " +
                          _coresspondingmap[_studentList[index].uid].fine +
                          "\n"
                              "Total Amount: " +
                          (double.parse(
                                      _coresspondingmap[_studentList[index].uid]
                                          .amount) +
                                  double.parse(
                                      _coresspondingmap[_studentList[index].uid]
                                          .fine))
                              .toStringAsFixed(2),
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
