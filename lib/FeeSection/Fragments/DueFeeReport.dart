
import 'package:flutter/material.dart';

import 'FullReport.dart';
import 'StudentModel.dart';
class DueFeeReport extends StatefulWidget {
  final List<StudentModel> _listStudentModel;
  DueFeeReport(this._listStudentModel);
  @override
  _DueFeeReportState createState() => _DueFeeReportState();
}

class _DueFeeReportState extends State<DueFeeReport> {

  List<StudentModel> _studentList=[];
  Map<String, NoInstallments> _coresspondingmap={}; 
 
  _setstudentlist(){
        DateTime dateTime= DateTime.now();
        int dd= int.parse(dateTime.day.toString().length==1? "0"+dateTime.day.toString():dateTime.day.toString());
        int mm= int.parse(dateTime.month.toString().length==1? "0"+dateTime.month.toString():dateTime.month.toString());
        int yyyy= int.parse(dateTime.year.toString());  
        List<StudentModel> list=[];
     widget._listStudentModel.forEach((element1) { 
      
      try{
       var index= element1.listInstallment.firstWhere((element) {
         print(element.sequence);
          if(element.status=="Due"){
            String duration= element1.listInstallment[int.parse(element.sequence.replaceAll("Installment", ""))-2]?.duration;
            print(duration);
            int enddd= int.parse(duration.split(" ")[0]);
            int endmm= int.parse(duration.split(" ")[1]);
            int endyy= int.parse(duration.split(" ")[2]);
            if(dd>=enddd && mm>=endmm && yyyy>=endyy)
            return true;
            else 
            return false;
          }
          else
          return false;
          });
         if(index!=null)
         list.add(element1);
          _coresspondingmap[element1.uid]=index;
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
    
    if(widget._listStudentModel!= null){
      _setstudentlist();
    }
    
    
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
             title: Text(_studentList[index]?.name),
             subtitle: Text("Due "+_coresspondingmap[_studentList[index].uid].sequence),
            ),
          );
        }) 
    );
  }
}