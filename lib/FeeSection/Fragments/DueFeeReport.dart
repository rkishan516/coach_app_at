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
    widget._listStudentModel.forEach((studentmodel) {
      if (studentmodel.isinstallmentAllowed) {
        if (studentmodel.lastpaidInstallment != "") {
          DateTime dateTime = DateTime.now();
          int dd = int.parse(dateTime.day.toString().length == 1
              ? "0" + dateTime.day.toString()
              : dateTime.day.toString());
          int mm = int.parse(dateTime.month.toString().length == 1
              ? "0" + dateTime.month.toString()
              : dateTime.month.toString());
          int yyyy = int.parse(dateTime.year.toString());

          try {
            var index = studentmodel.listInstallment.firstWhere((element) {
              if (element.status == "Due" || element.status == "Fine") {
                String duration = studentmodel
                    .listInstallment[int.parse(
                            element.sequence.replaceAll("Installment", "")) -
                        2]
                    .duration;

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
            list.add(studentmodel);
            _coresspondingmap[studentmodel.uid] = index;
          } catch (e) {}
          setState(() {
            _studentList = list;
          });
        } else {
          try {
            var index = studentmodel.listInstallment.firstWhere((element) =>
                element.status == "Due" || element.status == "Fine");
            list.add(studentmodel);
            _coresspondingmap[studentmodel.uid] = index;
          } catch (e) {}

          setState(() {
            _studentList = list;
          });
        }
      } else {
        try {
          double sum = 0.0;
          double fine = 0.0;
          studentmodel.listInstallment.forEach((childelement) {
            if (childelement.status == "Due") {
              sum += double.parse(childelement.amount);
            } else if (childelement.status == "Fine") {
              fine += double.parse(childelement.fine);
            }
          });
          if (sum != 0.0) {
            list.add(studentmodel);
            _coresspondingDueMap[studentmodel.uid] = PaidInstallemnt(
                sum.toStringAsFixed(2), fine.toStringAsFixed(2));
          }
        } catch (e) {}
        setState(() {
          _studentList = list;
        });
      }
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
          String text = _studentList[index].isinstallmentAllowed
              ? "Type: " +
                  _coresspondingmap[_studentList[index].uid]!.sequence +
                  "\n" +
                  "Due Date: " +
                  _coresspondingmap[_studentList[index].uid]!
                      .duration
                      .replaceAll(" ", "/") +
                  "\n"
                      "Due Amount: " +
                  _coresspondingmap[_studentList[index].uid]!.amount
              : "Due " +
                  _coresspondingDueMap[_studentList[index].uid]!.amount +
                  " and Fine " +
                  _coresspondingDueMap[_studentList[index].uid]!.fine;
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
                      (index + 1).toString() + ". " + _studentList[index].name,
                      style: TextStyle(
                        color: _studentList[index].paymentType == "Online"
                            ? Colors.green
                            : Color(0xffF36C24),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      text,
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

class PaidInstallemnt {
  String amount;
  String fine;
  PaidInstallemnt(this.amount, this.fine);
}
