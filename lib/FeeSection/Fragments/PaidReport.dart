import 'package:flutter/material.dart';

import 'FullReport.dart';
import 'StudentModel.dart';
class PaidReport extends StatefulWidget {
  final List<StudentModel> _listStudentModel;
  PaidReport(this._listStudentModel);
  @override
  _PaidReportState createState() => _PaidReportState();
}

class _PaidReportState extends State<PaidReport> {

  List<StudentModel> _studentList=[];
  _setstudentlist(){
    List<StudentModel> list=[];
     widget._listStudentModel.forEach((element) { 
      
      if(element.lastpaidInstallment!=null && element.lastpaidInstallment!="OneTime"){
        list.add(element); 
      }
    });
    setState(() {
          _studentList= list;
    });
        
  }
  @override
  Widget build(BuildContext context) {

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

          var indexof= _studentList[index].listInstallment.singleWhere((element) => element.sequence==_studentList[index].lastpaidInstallment);
          String lastpaidtime= _studentList[index].listInstallment[_studentList[index].listInstallment.indexOf(indexof)].paidTime.toString();
          
          return Card(
            child: ListTile(
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FullReport(_studentList[index]))),
             title: Text(_studentList[index]?.name??""),
             subtitle:Text("Last Paid " +_studentList[index].lastpaidInstallment.replaceAll("Installment", " Installment")+" on " +lastpaidtime.replaceAll(" ", "/")) ,
            ),
          );
        }) 
    );
  }
}