
import 'package:flutter/material.dart';

import 'FullReport.dart';
import 'StudentModel.dart';
class DiscountReport extends StatefulWidget {
  final List<StudentModel> _listStudentModel;
  DiscountReport(this._listStudentModel);
  @override
  _PayementReportState createState() => _PayementReportState();
}

class _PayementReportState extends State<DiscountReport> {

  List<StudentModel> _studentList=[];

  _setstudentlist(){
    List<StudentModel> list=[];
     widget._listStudentModel.forEach((element) { 
      
      if(element.lastpaidInstallment!=null && element.discount!=null){
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
          return Card(
            child: ListTile(
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=> FullReport(_studentList[index]))),
             title: Text(_studentList[index].name),
             subtitle: Text(_studentList[index].discount+"%"),
            ),
          );
        }) 
    );
  }
}