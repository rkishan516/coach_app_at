import 'package:flutter/material.dart';

import 'FullReport.dart';
import 'StudentModel.dart';
class PayementReport extends StatefulWidget {
  final List<StudentModel> _listStudentModel;
  PayementReport(this._listStudentModel);
  @override
  _PayementReportState createState() => _PayementReportState();
}

class _PayementReportState extends State<PayementReport> { 
 
  List<StudentModel> _studentList=[];
  Map<String, NoInstallments> _coresspondingmap={}; 
  Map<String, String> _coressponding_status={};
  bool count= true;
 
  
  _setstudentlist(){
    List<StudentModel> list=[];
     widget._listStudentModel.forEach((element) { 
      
      if(element.lastpaidInstallment!=null && element.lastpaidInstallment!="OneTime"){
      
        list.add(element);
       
        _coressponding_status[element.uid]= "Paid"; 
     
      }
      
      else{
       
        try{
          
           var index= element.listInstallment.firstWhere((element) => element.fine!="" && element.status=="Fine");
           
           list.add(element);
           
           _coressponding_status[element.uid]="Fine";
          
           _coresspondingmap[element.uid] =index;
        
        }catch(e){
           try{
             var index= element.listInstallment.firstWhere((element) => element.status=="Due");
           
           list.add(element);
          
           _coressponding_status[element.uid]="Due";
           
           _coresspondingmap[element.uid] = index;
          
          print(e);
           }
           catch(e){
             print(e); 
           }
           
        
        }

      }
    });
    setState(() {
          _studentList= list;
    });
        
  }
  @override
  Widget build(BuildContext context)  {
    
    _setstudentlist();

    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.orange
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      
      child: ListView.builder(
        
        itemCount: _studentList.length,
        
        itemBuilder: (context, index){
          
          String subTitle="";
          
          if(_coressponding_status[_studentList[index].uid]=="Paid"){

          var indexof= _studentList[index].listInstallment.singleWhere((element) => element.sequence==_studentList[index].lastpaidInstallment);
          
          String lastpaidtime= _studentList[index].listInstallment[_studentList[index].listInstallment.indexOf(indexof)].paidTime.toString();
          
          subTitle= "Last Paid " +_studentList[index].lastpaidInstallment.replaceAll("Installment", " Installment")+" on " +lastpaidtime.replaceAll(" ", "/");
          
          }
          
          else if(_coressponding_status[_studentList[index].uid] == "Fine"){
          
          subTitle= "Fine of "+ _coresspondingmap[_studentList[index].uid].fine +" in "+_coresspondingmap[_studentList[index].phoneNo].sequence;
         
          }
          
          else{
          
          subTitle="Due "+_coresspondingmap[_studentList[index].uid].sequence;
          
          }
          
          return Card(
            child: ListTile(
           
            onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FullReport(_studentList[index]))), 
             
             title: Text(_studentList[index]?.name??""),
             
             subtitle:Text(subTitle) ,
            
            ),
          );
        }) 
    );
  }
}

