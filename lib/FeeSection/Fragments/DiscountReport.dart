import 'package:flutter/material.dart';

import 'FullReport.dart';
import 'StudentModel.dart';

class DiscountReport extends StatefulWidget {
  final List<StudentModel> _listStudentModel;
  DiscountReport(this._listStudentModel);
  @override
  _PayementReportState createState() => _PayementReportState();
}

class _PayementReportState extends State<DiscountReport> {
  List<StudentModel> _studentList = [];

  _setstudentlist() {
    List<StudentModel> list = [];
    widget._listStudentModel.forEach((element) {
      if (element.lastpaidInstallment != null && element.discount != null) {
        list.add(element);
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
                        color: Color(0xffF36C24),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Type: " +
                          _studentList[index].allowedthrough +
                          "\n"
                              "Discount Coupon: " +
                          _studentList[index].discount +
                          "%",
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
