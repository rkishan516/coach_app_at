import 'package:coach_app/FeeSection/Fragments/FullReport.dart';
import 'package:coach_app/FeeSection/Fragments/StudentModel.dart';
import 'package:flutter/material.dart';

class DueFeeReport extends StatefulWidget {
  final List<StudentModel> _listStudentModel;
  DueFeeReport(this._listStudentModel);
  @override
  _DueFeeReportState createState() => _DueFeeReportState();
}

class _DueFeeReportState extends State<DueFeeReport> {
  List<StudentModel> _studentList = [];
  Map<String, NoInstallments> _coresspondingmap = {};
  Map<String, PaidInstallemnt> _coresspondingDueMap = {};
  List<StudentModel> list = [];
  _setstudentlist() {
    list = [];
    if (widget._listStudentModel.length == 0) {
      return;
    }
    if (widget._listStudentModel[0].isinstallmentAllowed) {
      DateTime dateTime = DateTime.now();
      int dd = int.parse(dateTime.day.toString().length == 1
          ? "0" + dateTime.day.toString()
          : dateTime.day.toString());
      int mm = int.parse(dateTime.month.toString().length == 1
          ? "0" + dateTime.month.toString()
          : dateTime.month.toString());
      int yyyy = int.parse(dateTime.year.toString());

      widget._listStudentModel.forEach((element1) {
        try {
          var index = element1.listInstallment?.firstWhere((element) {
            print(element.sequence);
            if (element.status == "Due" || element.status == "Fine") {
              String duration = element1
                  .listInstallment[int.parse(
                          element.sequence.replaceAll("Installment", "")) -
                      2]
                  ?.duration;
              print(duration);
              int enddd = int.parse(duration.split(" ")[0]);
              int endmm = int.parse(duration.split(" ")[1]);
              int endyy = int.parse(duration.split(" ")[2]);
              if (dd >= enddd && mm >= endmm && yyyy >= endyy)
                return true;
              else
                return false;
            } else
              return false;
          });
          if (index != null) list.add(element1);
          _coresspondingmap[element1.uid] = index;
        } catch (e) {
          print(e);
        }
      });
      setState(() {
        _studentList = list;
      });
    } else {
      try {
        widget._listStudentModel.forEach((element) {
          double sum = 0.0;
          double fine = 0.0;
          element.listInstallment.forEach((childelement) {
            if (childelement.status == "Due") {
              sum += double.parse(childelement.amount);
            } else if (childelement.status == "Fine") {
              fine += double.parse(childelement.fine);
            }
          });
          if (sum != 0.0) {
            list.add(element);
            _coresspondingDueMap[element.uid] = PaidInstallemnt(
                sum.toStringAsFixed(2), fine.toStringAsFixed(2));
          }
        });
      } catch (e) {
        print(e);
      }
      setState(() {
        _studentList = list;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget._listStudentModel != null) {
      _setstudentlist();
    }

    return Container(
      padding: EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: _studentList.length,
        itemBuilder: (context, index) {
          String text = _studentList[index].isinstallmentAllowed
              ? "Due " + _coresspondingmap[_studentList[index].uid].sequence
              : "Due " +
                  _coresspondingDueMap[_studentList[index].uid].amount +
                  " and Fine " +
                  _coresspondingDueMap[_studentList[index].uid].fine;
          return Card(
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FullReport(
                    _studentList[index],
                  ),
                ),
              ),
              child: Container(
                child: Column(
                  children: [
                    Text(
                      _studentList[index]?.name,
                    ),
                    Text(
                      text,
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

class PaidInstallemnt {
  String amount;
  String fine;
  PaidInstallemnt(this.amount, this.fine);
}
