import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Student/course_registration_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:upi_india/upi_india.dart';

import 'StuInstallment.dart';

class PayInstallment extends StatelessWidget {
  final String courseId;
  final String courseName;
  final NoofInstallment seqinstallment;
  PayInstallment(this.seqinstallment,
      {@required this.courseId, @required this.courseName});
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Pay Installment"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            String upi;
            var value = await FirebaseDatabase.instance
                .reference()
                .child(
                    '/institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/')
                .child('upiId')
                .once();
            upi = value.value;

            // UpiApplication application
            String application = await showDialog(
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
            UpiResponse txnResponse = await UpiIndia().startTransaction(
                app: application,
                receiverUpiId: upi,
                receiverName: upi.split('@')[0],
                transactionNote: 'You are purchaing the course $courseName.',
                amount: double.parse(seqinstallment.amount) + double.parse(seqinstallment.fine == '' ? '0' : seqinstallment.fine) );
            // UpiTransactionResponse txnResponse =
            //     await UpiPay.initiateTransaction(
            //   amount:
            //       "${double.parse(seqinstallment.amount).toInt() + double.parse(seqinstallment.fine == '' ? '0' : seqinstallment.fine).toInt()}.00",
            //   app: application,
            //   receiverName: upi.split('@')[0],
            //   receiverUpiAddress: upi,
            //   transactionRef:
            //       '${courseName.hashCode}${courseId.hashCode}${FireBaseAuth.instance.user.uid.hashCode}',
            //   transactionNote: 'You are purchaing the course $courseName.',
            // );
            if (txnResponse.status == UpiPaymentStatus.SUCCESS) {
              await dbref
                  .reference()
                  .child(
                      "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/${FireBaseAuth.instance.user.uid}/course/$courseId/fees/Installments")
                  .update({
                seqinstallment.sequence: {
                  "Amount": seqinstallment.amount,
                  "Duration": seqinstallment.duration,
                  "Status": "Paid",
                  "PaidTime": date,
                  "Fine": seqinstallment.fine
                },
                "AllowedThrough": "Installments",
                "LastPaidInstallment": seqinstallment.sequence
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
