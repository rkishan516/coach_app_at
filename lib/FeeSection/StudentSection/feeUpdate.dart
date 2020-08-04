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
          }
        });
      } else {
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
        child: StreamBuilder<Event>(
          stream: widget.ref.child("fees").onValue,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            if (snapshot.data.snapshot.value == null) {
              return Center(child: Text('No Payment Option Available'));
            }
            Fees fees = Fees.fromJson(snapshot.data.snapshot.value);
            if (installments == null &&
                (fees.maxInstallment?.isMaxAllowed ?? false)) {
              installments = List<bool>();
              for (int i = 0;
                  i < int.parse(fees.maxInstallment.maxAllowedInstallment);
                  i++) {
                installments.add(false);
              }
            }
            if ((fees.oneTime?.isOneTimeAllowed ?? false) &&
                (fees.maxInstallment?.isMaxAllowed ?? false)) {
            } else {
              paidOneTime = fees.oneTime?.isOneTimeAllowed ?? false;
            }

            return ListView(
              children: [
                if (fees.oneTime?.isOneTimeAllowed ?? false)
                  SwitchListTile.adaptive(
                    title: Text('Paid One Time'),
                    value: paidOneTime,
                    onChanged: ((fees.oneTime?.isOneTimeAllowed ?? false) &&
                            (fees.maxInstallment?.isMaxAllowed ?? false))
                        ? (val) {
                            setState(() {
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
                                }
                              } else {
                                for (int i = index;
                                    i <
                                        int.parse(fees.maxInstallment
                                            .maxAllowedInstallment);
                                    i++) {
                                  installments[index] = false;
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
                    if ((fees.oneTime?.isOneTimeAllowed ?? false) &&
                        paidOneTime) {
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
            );
          },
        ),
      ),
    );
  }
}
