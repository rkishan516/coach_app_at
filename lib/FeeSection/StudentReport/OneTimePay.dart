import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'PayOneTime.dart';

class OneTimeInstallment extends StatefulWidget {
  final String courseId;
  final String courseName;
  final bool toggleValue;
  final String displaysum;
  final double paidsum;
  final double paidfine;
  OneTimeInstallment(
      {this.toggleValue,
      this.displaysum,
      this.paidsum,
      this.paidfine,
      this.courseId,
      this.courseName});
  @override
  _StuInstallmentState createState() =>
      _StuInstallmentState(toggleValue, paidsum, paidfine);
}

class _StuInstallmentState extends State<OneTimeInstallment> {
  double paidsum;
  double paidfine;
  bool toggleValue;
  _StuInstallmentState(this.toggleValue, this.paidsum, this.paidfine);
  final dbref = FirebaseDatabase.instance;
  double totalfees = 0.0;
  String discount = "";
  String duration = "";
  String fine = "";

  String paymentDate = "";
  Widget _payButton() {
    return GestureDetector(
      onTap: () {
        if (!toggleValue)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PayOneTime(
                totalfees: totalfees.toString(),
                duration: duration,
                fine: fine,
                paidfine: paidfine,
                paidsum: paidsum,
                courseId: widget.courseId,
                courseName: widget.courseName,
              ),
            ),
          ).then((value) {
            print(value);
          });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), color: Colors.orange),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        child: Text(
          !toggleValue ? "Pay Now" : "Paid",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  _loadFromDatabase() {
    if (!toggleValue) {
      DateTime dateTime = DateTime.now();
      int dd = int.parse(dateTime.day.toString().length == 1
          ? "0" + dateTime.day.toString()
          : dateTime.day.toString());
      int mm = int.parse(dateTime.month.toString().length == 1
          ? "0" + dateTime.month.toString()
          : dateTime.month.toString());
      int yyyy = int.parse(dateTime.year.toString());
      dbref
          .reference()
          .child(
              "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseId}/fees")
          .once()
          .then((snapshot) {
        Map map = snapshot.value;
        duration = map["OneTime"]["Duration"];
        int enddd = int.parse(duration.toString().split(" ")[0]);
        int endmm = int.parse(duration.toString().split(" ")[1]);
        int endyyyy = int.parse(duration.toString().split(" ")[2]);

        if (dd <= enddd && mm <= endmm && yyyy <= endyyyy) {
          fine = "";
        } else {
          final difference = DateTime(yyyy, mm, dd)
              .difference(DateTime(endyyyy, endmm, enddd))
              .inDays;
          print("Difference is $difference");
          Map fineMap = map["SetFine"];
          int count = int.parse(fineMap["Duration"].toString().split(" ")[0]);
          String period = fineMap["Duration"].toString().split(" ")[1];

          int durationinDays = period == "Day(s)"
              ? count
              : period == "Month(s)" ? count * 30 : count * 365;
          double val = 0.0;
          if (durationinDays != 0)
            val = double.parse((((difference / durationinDays)).ceil() *
                    double.parse(fineMap["FineAmount"]))
                .toStringAsFixed(2));

          setState(() {
            fine = val.toString() == "0.0" ? "" : val.toString();
          });
        }
        dbref
            .reference()
            .child(
                "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/${FireBaseAuth.instance.user.uid}/course/${widget.courseId}/discount")
            .once()
            .then((value) {
          setState(() {
            discount = value.value == null ? "" : value.value + "%";
            duration = map["OneTime"]["Duration"];
            totalfees = double.parse(map["FeeSection"]["TotalFees"]);
          });
        });
      });
    } else {
      dbref
          .reference()
          .child(
              "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseId}/fees")
          .once()
          .then((snapshot) {
        Map map = snapshot.value;
        setState(() {
          duration = map["OneTime"]["Duration"].toString();
          totalfees = double.parse(map["FeeSection"]["TotalFees"]);
        });
      });
      dbref
          .reference()
          .child(
              "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/${FireBaseAuth.instance.user.uid}/course/${widget.courseId}/fees/Installments/OneTime")
          .once()
          .then((value) {
        Map map = value.value;
        setState(() {
          fine = map["Fine"];
          paymentDate = map["PaidTime"];
          paidsum = double.parse(map["PaidInstallment"]);
          paidfine = double.parse(map["paidFine"]);
        });
      });
      dbref
          .reference()
          .child(
              "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/${FireBaseAuth.instance.user.uid}/course/${widget.courseId}/discount")
          .once()
          .then((value) {
        setState(() {
          discount = value.value == null ? "" : value.value + "%";
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    double addfine = fine != "" ? double.parse(fine) : 0.0;
    double addTotalFees = totalfees != 0.0 ? totalfees : 0.0;
    String discountfeesadded = "";
    if (discount != "")
      discountfeesadded = (totalfees *
                  (1 - (double.parse(discount.replaceAll("%", "")) / 100)) +
              addfine -
              paidsum)
          .toString();
    else
      discountfeesadded = (addfine + addTotalFees - paidsum).toString();
    return Scaffold(
        appBar: AppBar(
          title: Text("Full Payment"),
        ),
        body: ListView(
          padding: EdgeInsets.all(12.0),
          children: [
            Container(
                padding: EdgeInsets.all(20.0),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.orange,
                ),
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(
                            "Total Fees",
                            style: TextStyle(fontSize: 22.0),
                          )),
                      SizedBox(
                        width: 35.0,
                      ),
                      Expanded(
                          flex: 2,
                          child: Text(
                            totalfees.toString(),
                            style: TextStyle(fontSize: 20.0),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  if (widget.displaysum != "")
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Paid Installment",
                              style: TextStyle(fontSize: 22.0),
                            )),
                        SizedBox(
                          width: 35.0,
                        ),
                        Expanded(
                            flex: 2,
                            child: Text(
                              widget.displaysum != "0.0"
                                  ? paidsum.toString()
                                  : widget.displaysum,
                              style: TextStyle(fontSize: 20.0),
                            ))
                      ],
                    ),
                  SizedBox(
                    height: 15.0,
                  ),
                  if (widget.displaysum != "")
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Paid Fine",
                              style: TextStyle(fontSize: 22.0),
                            )),
                        SizedBox(
                          width: 35.0,
                        ),
                        Expanded(
                            flex: 2,
                            child: Text(
                              widget.displaysum != "0.0"
                                  ? paidfine.toString()
                                  : "0.0",
                              style: TextStyle(fontSize: 20.0),
                            ))
                      ],
                    ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(
                            "Discount",
                            style: TextStyle(fontSize: 22.0),
                          )),
                      SizedBox(
                        width: 35.0,
                      ),
                      Expanded(
                          flex: 2,
                          child: Text(
                            discount,
                            style: TextStyle(fontSize: 20.0),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(
                            "Fine",
                            style: TextStyle(fontSize: 22.0),
                          )),
                      SizedBox(
                        width: 35.0,
                      ),
                      Expanded(
                          flex: 2,
                          child: Text(
                            fine == "" ? "0.0" : fine,
                            style: TextStyle(fontSize: 20.0),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(
                            "End Date",
                            style: TextStyle(fontSize: 22.0),
                          )),
                      SizedBox(
                        width: 35.0,
                      ),
                      Expanded(
                          flex: 2,
                          child: Text(
                            duration?.replaceAll(" ", "/"),
                            style: TextStyle(fontSize: 20.0),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  toggleValue
                      ? Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text(
                                  "Payment Date",
                                  style: TextStyle(fontSize: 22.0),
                                )),
                            SizedBox(
                              width: 35.0,
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  paymentDate?.replaceAll(" ", "/"),
                                  style: TextStyle(fontSize: 20.0),
                                ))
                          ],
                        )
                      : SizedBox(
                          height: 15.0,
                        ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(
                            toggleValue ? "Amount Paid" : "Payable Amount",
                            style: TextStyle(fontSize: 22.0),
                          )),
                      SizedBox(
                        width: 35.0,
                      ),
                      Expanded(
                          flex: 2,
                          child: Text(
                            discountfeesadded.contains("-")
                                ? "0.0"
                                : discountfeesadded,
                            style: TextStyle(fontSize: 20.0),
                          ))
                    ],
                  )
                ])),
            SizedBox(
              height: 15.0,
            ),
            _payButton(),
          ],
        ));
  }
}
