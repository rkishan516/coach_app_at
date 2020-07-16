import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Student/course_registration_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:upi_pay/upi_pay.dart';
import 'package:easy_localization/easy_localization.dart';

class PayOneTime extends StatelessWidget {
  String totalfees;
  String duration;
  String fine;
  String courseId;
  String courseName;
  bool isSuccessfull = true;
  PayOneTime(
      {this.totalfees,
      this.duration,
      this.fine,
      this.courseId,
      this.courseName});
  final dbref = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
    String dd = dateTime.day.toString().length == 1
        ? "0" + dateTime.day.toString()
        : dateTime.day.toString();
    String mm = dateTime.month.toString().length == 1
        ? "0" + dateTime.month.toString()
        : dateTime.month.toString();
    String yyyy = dateTime.year.toString();
    String date = dd + " " + mm + " " + yyyy;
    print(date);
    return Scaffold(
      appBar: AppBar(
        title: Text("Pay Installment"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            String upi;
            var value = await FirebaseDatabase.instance
                .reference().child('/institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/')
                .child('upiId')
                .once();
            upi = value.value;

            UpiApplication application = await showDialog(
              context: context,
              child: Dialog(
                child: Screen(),
              ),
            );
            if (application == null) {
              Alert.instance
                  .alert(context, 'No application selected or available'.tr());
              return;
            }
            UpiTransactionResponse txnResponse =
                await UpiPay.initiateTransaction(
              amount: "$totalfees",
              app: application,
              receiverName: upi.split('@')[0],
              receiverUpiAddress: upi,
              transactionRef:
                  '${courseName.hashCode}${courseId.hashCode}${FireBaseAuth.instance.user.uid.hashCode}',
              transactionNote: 'You are purchaing the course ${courseName}.',
            );
            isSuccessfull = txnResponse.status == UpiTransactionStatus.success;
            if (isSuccessfull) {
              await dbref
                  .reference()
                  .child(
                      "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/${FireBaseAuth.instance.user.uid}/course/${courseId}/fees/Installments")
                  .update({
                "OneTime": {
                  "Amount": totalfees,
                  "Duration": duration,
                  "Status": "Paid",
                  "PaidTime": date,
                  "Fine": fine
                },
                "AllowedThrough": "OneTime",
                "LastPaidInstallment": "OneTime"
              });

              Navigator.of(context).pop("Paid");
            }
          },
          child: Text("Pay"),
        ),
      ),
    );
  }
}
