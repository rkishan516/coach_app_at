
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'StuInstallment.dart';
class PayInstallment extends StatelessWidget {
  NoofInstallment seqinstallment;
  bool isSuccessfull= true;
  PayInstallment(this.seqinstallment);
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
        
            seqinstallment.sequence: {
              "Amount" : seqinstallment.amount,
              "Duration": seqinstallment.duration,
              "Status" : "Paid",
              "PaidTime" : date,
              "Fine" : seqinstallment.fine
            }
          ,
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