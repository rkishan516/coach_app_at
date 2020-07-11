
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class PayOneTime extends StatelessWidget {
  String totalfees;
  String duration;
  String fine;
  bool isSuccessfull= true;
  PayOneTime(this.totalfees, this.duration, this.fine);
  final dbref= FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context) {
    DateTime dateTime= DateTime.now();
    String dd= dateTime.day.toString().length==1? "0"+dateTime.day.toString():dateTime.day.toString();
    String mm= dateTime.month.toString().length==1? "0"+dateTime.month.toString():dateTime.month.toString();
    String yyyy= dateTime.year.toString();
    String date= dd+" "+mm+" "+ yyyy;
    print(date);
    return Scaffold(
      appBar: AppBar(title: Text("Pay Installment"),),
      body: Center(
        child: RaisedButton(onPressed: () async{
          if(isSuccessfull){
          await dbref.reference().child("institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/E2PyrrbVVqNI8PqwRNwvZCfy57X2/course/410665312/fees/Installments").update({
        
            "OneTime": {
              "Amount" : totalfees ,
              "Duration": duration,
              "Status" : "Paid",
              "PaidTime" : date,
              "Fine" : fine
            }
          ,
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