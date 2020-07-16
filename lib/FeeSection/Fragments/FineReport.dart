
import 'package:flutter/material.dart';

import 'FullReport.dart';
import 'StudentModel.dart';
class FineReport extends StatefulWidget {
  final List<StudentModel> _listStudentModel;
  FineReport(this._listStudentModel);
   @override
  _FineReportState createState() => _FineReportState();
}

class _FineReportState extends State<FineReport> {

  List<StudentModel> _studentList=[];
  Map<String, NoInstallments> _coresspondingmap={}; 
  _setstudentlist(){
    List<StudentModel> list= [];
    
     widget._listStudentModel.forEach((element) { 
       
       try{
         var index= element.listInstallment.firstWhere((element) => element.sequence!="OneTime" && element.fine!="" && element.fine!="0.0" && element.status=="Fine");
         print(index);
         if(index!=null){
           list.add(element);
           _coresspondingmap[element.uid]=index;
         }
         
       }catch(e){
         print(e);
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
             subtitle: Text("Fine of "+ _coresspondingmap[_studentList[index].uid].fine +" in "+_coresspondingmap[_studentList[index].uid].sequence),
            ),
          );
        }) 
    );
  }
}