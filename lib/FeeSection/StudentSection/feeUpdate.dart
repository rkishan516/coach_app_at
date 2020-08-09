import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FeeUpdate extends StatefulWidget {
  final DatabaseReference ref;
  final String courseID;
  final String keyS;
  FeeUpdate({this.ref, this.courseID, this.keyS});
  @override
  _FeeUpdateState createState() => _FeeUpdateState();
}

class _FeeUpdateState extends State<FeeUpdate> {
  bool paidOneTime = true;
  List<bool> installments;
  Fees fees;
  DataSnapshot snap;

  paidOneTimeS(double totalfees, String duration, String date, String courseId,
      String studentUid) async {
    await FirebaseDatabase.instance
        .reference()
        .child(
            "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/$studentUid/course/$courseId/fees/")
        .update({
      "Installments": {
        "OneTime": {
          "Amount": totalfees,
          "Duration": duration,
          "Status": "Paid",
          "PaidTime": date,
          "Fine": "",
          "PaidInstallment": "",
          "PaidFine": "",
        },
        "AllowedThrough": "OneTime",
        "LastPaidInstallment": "OneTime"
      }
    });
  }

  _updateList(
      List<bool> paidInstallment,
      Map<String, Installment> _listInstallment,
      String courseId,
      String studentUid,
      String date) async {
    var keys = _listInstallment.keys.toList()..sort();
    String lastPaid = "";

    for (int i = 0; i < _listInstallment.length; i++) {
      if (i < paidInstallment.length ? !paidInstallment[i] : false) {
        FirebaseDatabase.instance
            .reference()
            .child(
                "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/$studentUid/course/$courseId/fees/Installments")
            .update({
          keys[i]: {
            "Amount":
                (double.parse(_listInstallment[keys[i]].amount)).toString(),
            "Duration": _listInstallment[keys[i]].duration,
            "Status": "Due",
            "PaidTime": "",
            "Fine": ""
          },
          "AllowedThrough": "Installments",
          "LastPaidInstallment": lastPaid,
        });
      } else {
        lastPaid = keys[i];
        FirebaseDatabase.instance
            .reference()
            .child(
                "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/$studentUid/course/$courseId/fees/Installments")
            .update(
          {
            keys[i]: {
              "Amount": _listInstallment[keys[i]].amount,
              "Duration": _listInstallment[keys[i]].duration,
              "Status": "Paid",
              "PaidTime": date,
              "Fine": ""
            },
            "AllowedThrough": "Installments",
            "LastPaidInstallment": keys[i]
          },
        );
      }
    }
  }

  @override
  void initState() {
    widget.ref.child("fees").onValue.listen((event) {
      if (event.snapshot.value == null) {
        fees = null;
        return;
      }
      setState(() {
        fees = Fees.fromJson(event.snapshot.value);
        if (installments == null &&
            (fees.maxInstallment?.isMaxAllowed ?? false)) {
          installments = List<bool>();
          for (int i = 0;
              i < int.parse(fees.maxInstallment.maxAllowedInstallment);
              i++) {
            installments.add(false);
          }
        }
      });
    });
    widget.ref
        .parent()
        .parent()
        .child(
            'students/${widget.keyS}/course/${widget.courseID}/fees/Installments')
        .onValue
        .listen((event) {
      if (event.snapshot.value == null) {
        return;
      }
      setState(() {
        snap = event.snapshot;
        if ((fees.oneTime?.isOneTimeAllowed ?? false) &&
            (fees.maxInstallment?.isMaxAllowed ?? false)) {
        } else {
          paidOneTime = fees.oneTime?.isOneTimeAllowed ?? false;
        }
        if (snap.value["AllowedThrough"] == "OneTime") {
          paidOneTime = true;
        } else if (snap.value["AllowedThrough"] == "Installments") {
          paidOneTime = false;
          for (int i = 0; i < installments.length; i++) {
            if (snap.value["${i + 1}" + "Installment"] != null) {
              installments[i] =
                  snap.value["${i + 1}" + "Installment"]["Status"] == "Paid";
            }
          }
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fee Update',
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            if (fees.oneTime?.isOneTimeAllowed ?? false)
              SwitchListTile.adaptive(
                title: Text('Paid One Time'),
                value: paidOneTime,
                onChanged: ((fees.oneTime?.isOneTimeAllowed ?? false) &&
                        (fees.maxInstallment?.isMaxAllowed ?? false))
                    ? (val) {
                        setState(() {
                          if (paidOneTime == true) {
                            return;
                          }
                          paidOneTime = !paidOneTime;
                        });
                      }
                    : null,
              ),
            if (fees.maxInstallment?.isMaxAllowed ?? false)
              SwitchListTile.adaptive(
                title: Text('Paid In Installments'),
                value: !paidOneTime,
                onChanged: ((fees.oneTime?.isOneTimeAllowed ?? false) &&
                        (fees.maxInstallment?.isMaxAllowed ?? false))
                    ? (val) {
                        setState(() {
                          if (paidOneTime == true) {
                            return;
                          }
                          paidOneTime = !paidOneTime;
                        });
                      }
                    : null,
              ),
            if (!paidOneTime)
              ListView.builder(
                shrinkWrap: true,
                itemCount: int.parse(
                    fees.maxInstallment?.maxAllowedInstallment ?? "0"),
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text('Installment ${index + 1}'),
                    value: installments[index],
                    onChanged: (val) {
                      setState(
                        () {
                          if (val == true) {
                            for (int i = 0; i <= index; i++) {
                              installments[i] = true;
                              print(i + 1);
                              print(installments[i]);
                            }
                          } else {
                            for (int i = index;
                                i <
                                    int.parse(fees
                                        .maxInstallment.maxAllowedInstallment);
                                i++) {
                              installments[i] = false;
                            }
                          }
                        },
                      );
                    },
                  );
                },
              ),
            RaisedButton(
              color: Color(0xffF36C24),
              onPressed: () {
                DateTime dateTime = DateTime.now();
                String dd = dateTime.day.toString().length == 1
                    ? "0" + dateTime.day.toString()
                    : dateTime.day.toString();
                String mm = dateTime.month.toString().length == 1
                    ? "0" + dateTime.month.toString()
                    : dateTime.month.toString();
                String yyyy = dateTime.year.toString();
                String date = dd + " " + mm + " " + yyyy;
                if ((fees.oneTime?.isOneTimeAllowed ?? false) && paidOneTime) {
                  paidOneTimeS(
                    double.parse(fees?.feeSection?.totalFees ?? "0"),
                    (fees.oneTime?.duration),
                    (date),
                    widget.courseID,
                    widget.keyS,
                  );
                } else if (!paidOneTime &&
                    (fees.maxInstallment?.isMaxAllowed ?? false)) {
                  _updateList(
                    installments,
                    fees.maxInstallment?.installment,
                    widget.courseID,
                    widget.keyS,
                    date,
                  );
                }
                Navigator.of(context).pop();
              },
              child: Text(
                'Update Fees',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
