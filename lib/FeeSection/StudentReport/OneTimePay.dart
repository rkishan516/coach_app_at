import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Payment/razorPay.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:coach_app/Utils/Colors.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

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
      onTap: () async {
        if (!toggleValue) {
          DateTime dateTime = DateTime.now();
          String dd = dateTime.day.toString().length == 1
              ? "0" + dateTime.day.toString()
              : dateTime.day.toString();
          String mm = dateTime.month.toString().length == 1
              ? "0" + dateTime.month.toString()
              : dateTime.month.toString();
          String yyyy = dateTime.year.toString();
          String date = dd + " " + mm + " " + yyyy;
          String accountId;
          var value = await FirebaseDatabase.instance
              .reference()
              .child(
                  '/institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/')
              .child('accountId')
              .once();
          accountId = value.value;

          void _handlePaymentSuccess(PaymentSuccessResponse response) async {
            await dbref
                .reference()
                .child(
                    "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/${FireBaseAuth.instance.user.uid}/course/${widget.courseId}/fees/")
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
            // Do something when payment fails
          }

          void _handleExternalWallet(ExternalWalletResponse response) {
            // Do something when an external wallet was selected
          }

          RazorPayPayment _razorPay = RazorPayPayment(_handlePaymentSuccess,
              _handlePaymentError, _handleExternalWallet);

          _razorPay.checkoutPayment(
              totalfees.toInt() * 100,
              FireBaseAuth.instance.user.displayName,
              'You are purchaing the course ${widget.courseName}.',
              FireBaseAuth.instance.user.phoneNumber,
              FireBaseAuth.instance.user.email,
              accountId);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Container(
          alignment: Alignment.center,
          width: SizeConfig.b * 50,
          height: SizeConfig.v * 6,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 243, 107, 40),
            borderRadius: BorderRadius.all(
              Radius.circular(
                SizeConfig.b * 3,
              ),
            ),
          ),
          child: Text(
            !toggleValue ? "Pay Now" : "Paid",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: GuruCoolLightColor.whiteColor,
              fontWeight: FontWeight.w600,
              fontSize: SizeConfig.b * 5,
            ),
          ),
        ),
      ),
    );
  }

  _loadFromDatabase() {
    if (!toggleValue) {
      DateTime dateTime = DateTime.now();
      int dd = int.parse(dateTime.day.toString()?.length == 1
          ? "0" + dateTime.day.toString()
          : dateTime.day.toString());
      int mm = int.parse(dateTime.month.toString()?.length == 1
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

          Map fineMap = map["SetFine"];
          int count = int.parse(fineMap["Duration"].toString().split(" ")[0]);
          String period = fineMap["Duration"].toString().split(" ")[1];

          int durationinDays = period == "Day(s)"
              ? count
              : period == "Month(s)"
                  ? count * 30
                  : count * 365;
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
          paidfine = double.parse(map["paidFine"] ?? "0");
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
    SizeConfig().init(context);
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
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.v * 10),
                  Row(
                    children: <Widget>[
                      SizedBox(width: SizeConfig.b * 8),
                      Text("Total Fees:     ",
                          style: TextStyle(fontSize: SizeConfig.b * 4.5)),
                      SizedBox(width: SizeConfig.b * 8),
                      Text(totalfees.toString(),
                          style: TextStyle(
                              color: Color.fromARGB(255, 243, 107, 40),
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.b * 4.5)),
                    ],
                  ),
                  if (widget.displaysum != "")
                    SizedBox(
                      height: 15.0,
                    ),
                  if (widget.displaysum != "")
                    Row(
                      children: <Widget>[
                        SizedBox(width: SizeConfig.b * 8),
                        Text("Paid Installment",
                            style: TextStyle(fontSize: SizeConfig.b * 4.5)),
                        SizedBox(width: SizeConfig.b * 3),
                        Text(
                            widget.displaysum != "0.0"
                                ? paidsum.toString()
                                : widget.displaysum,
                            style: TextStyle(
                                color: Color.fromARGB(255, 243, 107, 40),
                                fontWeight: FontWeight.w600,
                                fontSize: SizeConfig.b * 4.5)),
                      ],
                    ),
                  if (widget.displaysum != "")
                    SizedBox(
                      height: 15.0,
                    ),
                  if (widget.displaysum != "")
                    Row(
                      children: <Widget>[
                        SizedBox(width: SizeConfig.b * 8),
                        Text("Paid Fine",
                            style: TextStyle(fontSize: SizeConfig.b * 4.5)),
                        SizedBox(width: SizeConfig.b * 16),
                        Text(
                            widget.displaysum != "0.0"
                                ? paidfine.toString()
                                : "0.0",
                            style: TextStyle(
                                color: Color.fromARGB(255, 243, 107, 40),
                                fontWeight: FontWeight.w600,
                                fontSize: SizeConfig.b * 4.5)),
                      ],
                    ),
                  SizedBox(height: SizeConfig.v * 2),
                  Row(
                    children: <Widget>[
                      SizedBox(width: SizeConfig.b * 8),
                      Text("Discount:     ",
                          style: TextStyle(fontSize: SizeConfig.b * 4.5)),
                      SizedBox(width: SizeConfig.b * 11),
                      Text(discount == '' ? "0%" : discount,
                          style: TextStyle(
                              color: Color.fromARGB(255, 243, 107, 40),
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.b * 4.5)),
                    ],
                  ),
                  SizedBox(height: SizeConfig.v * 2),
                  Row(
                    children: <Widget>[
                      SizedBox(width: SizeConfig.b * 8),
                      Text("Fine:  ",
                          style: TextStyle(fontSize: SizeConfig.b * 4.5)),
                      SizedBox(width: SizeConfig.b * 22.5),
                      Text(fine == "" ? "0.0" : fine,
                          style: TextStyle(
                              color: Color.fromARGB(255, 243, 107, 40),
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.b * 4.5)),
                    ],
                  ),
                  SizedBox(height: SizeConfig.v * 2),
                  Row(
                    children: <Widget>[
                      SizedBox(width: SizeConfig.b * 8),
                      Text("End Date:    ",
                          style: TextStyle(fontSize: SizeConfig.b * 4.5)),
                      SizedBox(width: SizeConfig.b * 11.5),
                      Text(duration?.replaceAll(" ", "/"),
                          style: TextStyle(
                              color: Color.fromARGB(255, 243, 107, 40),
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.b * 4.5)),
                    ],
                  ),
                  if (toggleValue) SizedBox(height: SizeConfig.v * 2),
                  if (toggleValue)
                    Row(
                      children: <Widget>[
                        SizedBox(width: SizeConfig.b * 8),
                        Text("Payment Date:   ",
                            style: TextStyle(fontSize: SizeConfig.b * 4.5)),
                        SizedBox(width: SizeConfig.b * 2.4),
                        Text(paymentDate?.replaceAll(" ", "/"),
                            style: TextStyle(
                                color: Color.fromARGB(255, 243, 107, 40),
                                fontWeight: FontWeight.w600,
                                fontSize: SizeConfig.b * 4.5)),
                      ],
                    ),
                  SizedBox(height: SizeConfig.v * 2),
                  Row(
                    children: <Widget>[
                      SizedBox(width: SizeConfig.b * 8),
                      Text(toggleValue ? "Amount Paid" : "Payable Amount",
                          style: TextStyle(fontSize: SizeConfig.b * 4.5)),
                      SizedBox(width: SizeConfig.b * 4.5),
                      Text(
                          discountfeesadded.contains("-")
                              ? "0.0"
                              : discountfeesadded,
                          style: TextStyle(
                              color: Color.fromARGB(255, 243, 107, 40),
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.b * 4.5)),
                    ],
                  ),
                  _payButton(),
                ],
              ),
            ),
          ],
        ));
  }
}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double b;
  static double v;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    b = screenWidth / 100;
    v = screenHeight / 100;
  }
}
