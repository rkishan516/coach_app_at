import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Payment/razorPay.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PayOneTime extends StatelessWidget {
  final String totalfees;
  final String duration;
  final String fine;
  final String courseId;
  final String courseName;
  final double paidsum, paidfine;
  PayOneTime(
      {this.totalfees,
      this.duration,
      this.fine,
      this.courseId,
      this.courseName,
      this.paidfine,
      this.paidsum});
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
                .reference()
                .child(
                    '/institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/')
                .child('upiId')
                .once();
            upi = value.value;

            void _handlePaymentSuccess(PaymentSuccessResponse response) async {
              print('Payment Successful');
              await dbref
                  .reference()
                  .child(
                      "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/${FireBaseAuth.instance.user.uid}/course/$courseId/fees/")
                  .update({
                "Installments": {
                  "OneTime": {
                    "Amount": totalfees,
                    "Duration": duration,
                    "Status": "Paid",
                    "PaidTime": date,
                    "Fine": fine,
                    "PaidInstallment": paidsum.toString(),
                    "PaidFine": paidfine.toString()
                  },
                  "AllowedThrough": "OneTime",
                  "LastPaidInstallment": "OneTime"
                }
              });

              Navigator.of(context).pop("Paid");

              // Do something when payment succeeds
            }

            void _handlePaymentError(PaymentFailureResponse response) {
              print('Payment Failed');
              // Do something when payment fails
            }

            void _handleExternalWallet(ExternalWalletResponse response) {
              print('Payment External Wallet');
              // Do something when an external wallet was selected
            }

            RazorPayPayment _razorPay = RazorPayPayment(_handlePaymentSuccess,
                _handlePaymentError, _handleExternalWallet);

            _razorPay.checkoutPayment(
                double.parse(totalfees).toInt() * 100,
                FireBaseAuth.instance.user.displayName,
                'You are purchaing the course $courseName.',
                FireBaseAuth.instance.user.phoneNumber,
                FireBaseAuth.instance.user.email);
          },
          child: Text("Pay"),
        ),
      ),
    );
  }
}
