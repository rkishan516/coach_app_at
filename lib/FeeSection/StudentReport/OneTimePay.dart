
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'PayOneTime.dart';
class OneTimeInstallment extends StatefulWidget {
  final bool toggleValue;
  OneTimeInstallment(this.toggleValue);
  @override
  _StuInstallmentState createState() => _StuInstallmentState(toggleValue);
}

class _StuInstallmentState extends State<OneTimeInstallment> {
  
  bool toggleValue;
 _StuInstallmentState(this.toggleValue);
 final dbref= FirebaseDatabase.instance;
 double totalfees =0.0;
 String discount="";
 String duration="";
 String fine="";
String paymentDate="";
  Widget _payButton() {
    return GestureDetector(
      onTap: () {
       if(!toggleValue)
       Navigator.push(context,MaterialPageRoute(builder: (context)=>PayOneTime(totalfees.toString(), duration, fine) ));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), color: Colors.orange),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        child: Text(
          !toggleValue? "Pay Now":"Paid",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
 
 _loadFromDatabase(){
  
  if(!toggleValue){
   DateTime dateTime= DateTime.now();
        int dd= int.parse(dateTime.day.toString().length==1? "0"+dateTime.day.toString():dateTime.day.toString());
        int mm= int.parse(dateTime.month.toString().length==1? "0"+dateTime.month.toString():dateTime.month.toString());
        int yyyy= int.parse(dateTime.year.toString()); 
        dbref.reference().child("institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/410665312/fees").once()
        .then((snapshot){ 

        Map map = snapshot.value;
        duration=map["OneTime"]["Duration"];
        int enddd= int.parse(duration.toString().split(" ")[0]);
        int endmm= int.parse(duration.toString().split(" ")[1]);
        int endyyyy= int.parse(duration.toString().split(" ")[2]);
       
        if(dd <= enddd && mm <= endmm && yyyy <= endyyyy){
          fine="";
        }
        else{
            final difference= DateTime(yyyy,mm,dd).difference(DateTime(endyyyy, endmm, enddd)).inDays;
            print("Difference is $difference");
             Map fineMap=map["SetFine"];
              int count= int.parse(fineMap["Duration"].toString().split(" ")[0]);
              String period= fineMap["Duration"].toString().split(" ")[1];
                      
              int durationinDays= period=="Day(s)"? count: period=="Month(s)"? count*30: count*365; 
              double val=0.0;        
              if(durationinDays!=0)        
              val= double.parse(( ((difference/durationinDays)).ceil() * double.parse(fineMap["FineAmount"]) ).toStringAsFixed(2));
              
              setState(() {
              fine= val.toString()=="0.0"?"":val.toString();  
              
              });
        }
         dbref.reference().child("institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/E2PyrrbVVqNI8PqwRNwvZCfy57X2/course/410665312/discount").once()
        .then((value) {
        setState(() {
         discount= value.value==null?"":value.value+"%";
         duration=map["OneTime"]["Duration"];
        totalfees= double.parse(map["FeeSection"]["TotalFees"]); 
        });
        });
        
        });
  }
   
  else{
   
    dbref.reference().child("institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/410665312/fees").once()
      .then((snapshot){
        Map map = snapshot.value;
        setState(() {
        duration=map["OneTime"]["Duration"].toString();
        totalfees= double.parse(map["FeeSection"]["TotalFees"]);  
  
        });
        
      });
     dbref.reference().child("institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/E2PyrrbVVqNI8PqwRNwvZCfy57X2/course/410665312/fees/Installments/OneTime").once()
     .then((value) {
       Map map= value.value;
       setState(() {
         fine= map["Fine"];
         paymentDate= map["PaidTime"];
       });
     });
     dbref.reference().child("institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/E2PyrrbVVqNI8PqwRNwvZCfy57X2/course/410665312/discount").once()
     .then((value) {
       setState(() {
         discount= value.value==null?"":value.value+"%";
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

    double addfine=fine!=""?double.parse(fine):0.0;
    double addTotalFees= totalfees!=0.0?totalfees:0.0;
    return Scaffold(
      appBar: AppBar(title: Text("Full Payment"),),
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            width: MediaQuery.of(context).size.width*0.8,
            height: MediaQuery.of(context).size.height*0.6,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.orange,
              ),
            child: Column(
              
                children: [
                  
                   Row(children: [
                    Expanded(
                      flex: 2,
                      child: Text("Total Fees",style: TextStyle(fontSize: 22.0),)),
                    SizedBox(width: 35.0,),
                    Expanded(
                      flex: 2,
                      child: Text(totalfees.toString(),
                      style: TextStyle(fontSize: 20.0),))
                  ],),
                  SizedBox(height: 15.0,),

                  Row(children: [
                    Expanded(
                      flex: 2,
                      child: Text("Discount",
                      style: TextStyle(fontSize: 22.0),)),
                    SizedBox(width: 35.0,),
                    Expanded(
                      flex: 2,
                      child: Text(discount,
                      style: TextStyle(fontSize: 20.0),))
                  ],),
                  SizedBox(height: 15.0,),

                   Row(children: [
                    Expanded(
                      flex: 2,
                      child: Text("Fine",
                      style: TextStyle(fontSize: 22.0),)),
                    SizedBox(width: 35.0,),
                    Expanded(
                      flex: 2,
                      child: Text(fine==""?"0.0":fine,
                      style: TextStyle(fontSize: 20.0),))
                  ],),
                  SizedBox(height: 15.0,),

                   Row(children: [
                    Expanded(
                      flex: 2,
                      child: Text("End Date",
                      style: TextStyle(fontSize: 22.0),)),
                    SizedBox(width: 35.0,),
                    Expanded(
                      flex: 2,
                      child: Text(duration?.replaceAll(" ", "/"),
                      style: TextStyle(fontSize: 20.0),))
                  ],),
                  SizedBox(height: 15.0,),

                  toggleValue? Row(children: [
                    Expanded(
                      flex: 2,
                      child: Text("Payment Date",
                      style: TextStyle(fontSize: 22.0),)),
                    SizedBox(width: 35.0,),
                    Expanded(
                      flex: 2,
                      child: Text(paymentDate?.replaceAll(" ","/"),
                      style: TextStyle(fontSize: 20.0),))
                  ],):
                  SizedBox(height: 15.0,),
                  SizedBox(height: 15.0,),
                  Row(children: [
                    Expanded(
                      flex: 2,
                      child: Text(toggleValue?"Amount Paid":"Payable Amount",
                      style: TextStyle(fontSize: 22.0),)),
                    SizedBox(width: 35.0,),
                    Expanded(
                      flex: 2,
                      child: Text(discount!=""? (totalfees*(1-(double.parse(discount.replaceAll("%", ""))/100) ) +addfine).toString():(addfine+addTotalFees).toString(),
                      style: TextStyle(fontSize: 20.0),))
                  ],)
                ])  
          ),
          SizedBox(height: 15.0,),
          _payButton(),
        ],
      )
    );
  }
}