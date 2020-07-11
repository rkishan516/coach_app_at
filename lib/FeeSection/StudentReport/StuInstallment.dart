import 'dart:async';

import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'PayInstallment.dart';
class StuInstallment extends StatefulWidget {
  final bool toogleValue;
  StuInstallment(this.toogleValue);
  @override
  _StuInstallmentState createState() => _StuInstallmentState(toogleValue);
}

class _StuInstallmentState extends State<StuInstallment> {
  bool toggleValue;
  _StuInstallmentState(this.toggleValue);
  final dbref= FirebaseDatabase.instance;
  int noofInstallments;
  String discount;
  double totalfees;
  double minusValue=0.0;
  List<NoofInstallment> _listInstallment=[];
  _loadFromDatabase() async {
      
      DataSnapshot discountsnap=await  dbref.reference().child("institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/E2PyrrbVVqNI8PqwRNwvZCfy57X2/course/410665312/discount").once(); 
      discount= discountsnap.value;
      DateTime dateTime= DateTime.now();
        int dd= int.parse(dateTime.day.toString().length==1? "0"+dateTime.day.toString():dateTime.day.toString());
        int mm= int.parse(dateTime.month.toString().length==1? "0"+dateTime.month.toString():dateTime.month.toString());
        int yyyy= int.parse(dateTime.year.toString());  
        
      if(!toggleValue)
      dbref.reference().child("institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/410665312/fees").once()
      .then((snapshot){
        Map map = snapshot.value;
        Map installments=map["MaxInstallment"]["Installments"];
        double fees= double.parse(map["FeeSection"]["TotalFees"]);
        
        //discount check
        if(discount!=null){
          minusValue= double.parse( ((fees*(double.parse(discount)/100))/installments.length).toStringAsFixed(2));
        }

        //finecheck
           installments.forEach((key, value) { 
                 String status="";
                 String fine="";
                 int enddd= int.parse(value["Duration"].toString().split(" ")[0]);
                 int endmm= int.parse(value["Duration"].toString().split(" ")[1]);
                 int endyyyy= int.parse(value["Duration"].toString().split(" ")[2]);
                 if(dd <= enddd && mm <= endmm && yyyy <= endyyyy){
                  
                  status= "Due";
                  fine="";
                  }
                  else{
                     final difference= DateTime(yyyy,mm,dd).difference(DateTime(endyyyy, endmm, enddd)).inDays;
                      print("Difference is $difference");
                      
                      int count= int.parse(map["SetFine"]["Duration"].toString().split(" ")[0]);
                      String period= map["SetFine"]["Duration"].toString().split(" ")[1];
                      
                      int durationinDays= period=="Day(s)"? count: period=="Month(s)"? count*30: count*365; 
                      
                      
                        double val= double.parse(( (difference/durationinDays).ceil() * double.parse(map["SetFine"]["FineAmount"]) ).toStringAsFixed(2));
                        fine= val.toString();
                        status= "Fine";
                  }
                  
                 String amountPass= (double.parse(value["Amount"])-minusValue).toStringAsFixed(2);

                _listInstallment.add(NoofInstallment( key, amountPass , value["Duration"], fine, status ));
             
           
           });
        setState(() {
             noofInstallments= int.parse(map["MaxInstallment"]["MaxAllowedInstallment"]);
             totalfees= fees;
            _listInstallment.sort((a,b)=>int.parse(a.sequence.replaceAll("Installment", "")).compareTo(int.parse(b.sequence.replaceAll("Installment", ""))));
        });
      });

      else{

        DataSnapshot finesnapshot= await dbref.reference().child("institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/410665312/fees").once();
        Map fineMap=finesnapshot.value["SetFine"];
        double fees= double.parse(finesnapshot.value["FeeSection"]["TotalFees"]);
        

        dbref.reference().child("institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/E2PyrrbVVqNI8PqwRNwvZCfy57X2/course/410665312/fees").once()
       .then((snapshot){
        Map map = snapshot.value;
        

           
           Map installments=map["Installments"];
           int count=0;
            if(discount!=null){
                         installments.forEach((key, value) { 
                           if(key!="AllowedThrough" && key!="LastPaidInstallment"){
                           if(value["Status"].toString()!="Paid")
                           count=count+1;
                           }
                         });
                         minusValue= double.parse( (( fees*( double.parse(discount)/100 ) )/count).toStringAsFixed(2));
            }

           installments.forEach((key, value) { 

             if(key!="AllowedThrough" && key!="LastPaidInstallment"){
              
             
              if(value["Status"]=="Paid"){
                 _listInstallment.add(NoofInstallment(key, value["Amount"],value["Duration"],value["Fine"],value["Status"]));
              }
              else{
                   String status="";
                   String fine="";
                   int enddd= int.parse(value["Duration"].toString().split(" ")[0]);
                   int endmm= int.parse(value["Duration"].toString().split(" ")[1]);
                   int endyyyy= int.parse(value["Duration"].toString().split(" ")[2]);
                  if(dd <= enddd && mm <= endmm && yyyy <= endyyyy){
                  
                  status= value["Status"];
                  fine= value["Fine"];
                  }else{
                      final difference= DateTime(yyyy,mm,dd).difference(DateTime(endyyyy, endmm, enddd)).inDays;
                      print("Difference is $difference");
                      
                      int count= int.parse(fineMap["Duration"].toString().split(" ")[0]);
                      String period= fineMap["Duration"].toString().split(" ")[1];
                      
                      int durationinDays= period=="Day(s)"? count: period=="Month(s)"? count*30: count*365; 
                      
                      
                        double val= double.parse(( (difference/durationinDays).ceil() * double.parse(fineMap["FineAmount"]) ).toStringAsFixed(2));
                        fine= val.toString();
                        status= "Fine";
                        dbref.reference().child("institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/E2PyrrbVVqNI8PqwRNwvZCfy57X2/course/410665312/fees/Installments/$key")
                        .update({
                          "Fine": fine
                        });

                  }
                  String amountPass= (double.parse(value["Amount"])-minusValue).toStringAsFixed(2);
                _listInstallment.add(NoofInstallment(key, amountPass,value["Duration"],fine,status));
                  }
              
             
             }
           });
           setState(() {
           noofInstallments= _listInstallment.length;
           totalfees= fees;
          _listInstallment.sort((a,b)=>int.parse(a.sequence.replaceAll("Installment", "")).compareTo(int.parse(b.sequence.replaceAll("Installment", ""))));
       });
      });


      }
  }

  _updateList(String paidInstallment) async{
    
    if(!toggleValue){
      print(">>>>");
    for(int i=0;i<_listInstallment.length;i++){
      if(_listInstallment[i].sequence!=paidInstallment){
        dbref.reference().child("institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/E2PyrrbVVqNI8PqwRNwvZCfy57X2/course/410665312/fees/Installments").update({  
          _listInstallment[i].sequence :{
            "Amount" : ( double.parse(_listInstallment[i].amount) + minusValue).toString(),
              "Duration": _listInstallment[i].duration,
              "Status" : "Due",
              "PaidTime" : "",
              "Fine" : ""
          }
        
       });
      }
      toggleValue= true;
    }
    }
    var index= _listInstallment.singleWhere((element) => element.sequence==paidInstallment);
    setState(() {
     _listInstallment[_listInstallment.indexOf(index)]= NoofInstallment(paidInstallment, _listInstallment[_listInstallment.indexOf(index)].amount,_listInstallment[_listInstallment.indexOf(index)].duration, _listInstallment[_listInstallment.indexOf(index)].fine, "Paid");

    });
    
  }
  
  @override
  void initState() {
    super.initState();
     _loadFromDatabase();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Installments"),),
      body: ListView(
        padding: EdgeInsets.all(12.0),
         children: [
           Row(
             children: [
               Expanded(
                 flex: 1,
                 child: Text("No of Intsallmnets", style: TextStyle(fontSize: 18.0),),
                 ),
                SizedBox(width: 20.0,),
              Expanded(
                 flex: 1,
                 child: Text("$noofInstallments", style: TextStyle(fontSize: 18.0),),
                 ),
             ],
           ),
           SizedBox(height: 10.0,),
           Card(
             child: ListTile(
               title: Text("Total fees"),
               subtitle: Text("$totalfees"),
               trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange,),
             ),
           ),

           SizedBox(height: 10.0,),
           discount!=null? Card(
             child: ListTile(
               title: Text("Discount"),
               subtitle: Text("$discount"+"%\n"+"Fees After Discount: "+(totalfees*(1-(double.parse(discount)/100))).toString()),
               trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange,),
             ),
           ):SizedBox(width: 5.0,),

           SizedBox(height: 10.0,),
           Container(
             padding: EdgeInsets.all(3.0),
             color: Colors.orange,
             width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height*0.65,
             child: ListView.builder(
               itemCount: _listInstallment.length,
               itemBuilder: (context, index){
                 String amountstr=  _listInstallment[index].fine!=""?"+ ${_listInstallment[index].fine}":"";
                 String buttonStatus= _listInstallment[index].status=="Due"?"Pay Now":_listInstallment[index].status=="Fine"?"Pay Now": "Paid";
                  return Card(
                    child: ListTile(
                      leading: Text((index+1).toString(), style: TextStyle(fontSize: 18.0),),
                      title: Text(_listInstallment[index].amount + amountstr),
                      subtitle: Text( "End Time:\n"+_listInstallment[index].duration.replaceAll(" ", "/")+"\n" +"Status: "+_listInstallment[index].status),
                      trailing: RaisedButton(
                        onPressed: (){
                          if(buttonStatus=="Pay Now")
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PayInstallment(_listInstallment[index]))).
                          then((value){
                            if(value=="Paid")
                            _updateList(_listInstallment[index].sequence);
                          });
                        },
                        color: Colors.orange,
                        child: Text(buttonStatus),
                        ),
                    ),
                  );
             }),
           )
         ],
      )
    );
  }
}


class NoofInstallment{
  final String sequence;
  final String amount;
  final String duration;
  final String fine;
  final String status;
  NoofInstallment(this.sequence, this.amount, this.duration, this.fine, this.status);

  NoofInstallment.fromJSON(DataSnapshot snapshot):
    sequence= snapshot.key,
    amount= snapshot.value["Amount"],
    duration= snapshot.value["Duration"],
    fine= snapshot.value["Fine"],
    status= snapshot.value["Status"];
  
}