import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Fragmnets/SelectCandidate.dart';
import 'Fragmnets/TwoStepSelectCandidate.dart';

class SessionDetail extends StatefulWidget {
  final String passVaraible;
  final String eventkey;
  final bool isedit;
  SessionDetail(
      {this.passVaraible,
      this.eventkey,
      this.isedit,
      });
  @override
  _SessionDetailState createState() =>
      _SessionDetailState(passVaraible, eventkey, isedit);
}

class _SessionDetailState extends State<SessionDetail> {
  String passVariable;
  final String eventkey;
  final bool isedit;
  int previlagelevel= FireBaseAuth.instance.previlagelevel;
  _SessionDetailState(this.passVariable, this.eventkey, this.isedit);
  final titleText = TextEditingController();
  final descriptionText = TextEditingController();
  final dbRef = FirebaseDatabase.instance;
  SharedPreferences _pref;
  String previousDescriptionText = "";
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay _picked;
  String testtime = "hh:mm";
  var _finallist=["None"];
  var _currentItemSelected= "None";
  var _adminlist= ["None","SubAdmins","MidAdmins","SubAdmins within a MidAdmin","Authorities of a branch"];
  var _subadminlist=["None","Teachers","Teachers of a course","Teachers of a subject","All students"];
  var _midadminlist=["None","Other MidAdmins", "SubAdmins", "Authorities of a branch"];
  String _leftUids="", _firstselecteduids="";
  var _previoustypeSelected="";
  _loaddatafromdatabase() async {
    dbRef
        .reference()
        .child(
            'institute/${FireBaseAuth.instance.instituteid}/events')
        .child(passVariable)
        .once()
        .then((DataSnapshot value) {
      setState(() {
        titleText.text = value.value['title'];
        descriptionText.text = value.value['description'];
        _time = TimeOfDay(hour: int.parse(value.value['time'].toString().split(":")[0]), minute: int.parse(value.value['time'].toString().split(":")[1
        ]));
        previousDescriptionText = value.value['description'];
        _currentItemSelected= value.value['type'];
        _previoustypeSelected= _currentItemSelected;
        _leftUids = value.value["leftUids"];
        _firstselecteduids = value.value["firstselecteduids"];
      });
    });
  }

  _saveintodatabase() async {
    _pref.setString(descriptionText.text, passVariable);
    print(passVariable);
    if (isedit && descriptionText.text != previousDescriptionText) {
      _pref.remove(previousDescriptionText);
    }

    dbRef
        .reference()
        .child(
            'institute/${FireBaseAuth.instance.instituteid}/events')
        .child(passVariable)
        .update({
      'title': titleText.text,
      'description': descriptionText.text,
      'time': _time.hour.toString() + ":" + _time.minute.toString(),
      'eventkey': eventkey,
      'isStarted': 0,
      'hostprevilage': previlagelevel,
      'hostuid': FireBaseAuth.instance.user.uid,
      "firstselecteduids" : _firstselecteduids,
      "leftUids": _leftUids,
      "type" : _currentItemSelected
    });
    Navigator.of(context).pop();
  }

  _delfromdatabase() async {
    dbRef
        .reference()
        .child(
            'institute/${FireBaseAuth.instance.instituteid}/events')
        .child(passVariable)
        .remove();
    _pref.remove(previousDescriptionText);
    Navigator.of(context).pop();
  }

  Future<Null> _selectTime(BuildContext context) async {
    
    _picked = await showTimePicker(context: context, initialTime: _time);
    if (_picked != null) {
      setState(
        () {
          _time = _picked;
          testtime = _time.hour.toString() + ":" + _time.minute.toString();
        },
      );
    }
  }

  _sharedprefinit() async {
    _pref = await SharedPreferences.getInstance();
  }
  Widget _dropDownMenu(){
    return Center(
      child: DropdownButton<String>(

                  items: _finallist.map((String dropDownStringitem){
                    return DropdownMenuItem<String>(
                      value: dropDownStringitem,
                      child: Text(dropDownStringitem),
                    );
                  }).toList(),
               
                onChanged: (String newValueSelected){

                  setState(() {
                    this._currentItemSelected= newValueSelected;
                  });
                  if(_previoustypeSelected!= _currentItemSelected){
                    _leftUids="";
                    _firstselecteduids ="";
                  }
                  if(newValueSelected!="None" && newValueSelected=="SubAdmins" || newValueSelected=="MidAdmins" || newValueSelected=="Teachers" || newValueSelected=="All students" || newValueSelected=="Other MidAdmins")
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SelectCandidate(type: _currentItemSelected,leftuids: _leftUids,))).
                  then((value){
                    if(value!=null)
                   _leftUids = value;
                  }); 
                  else {
                  if(newValueSelected!="None")
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TwoStepSelectCandidate(type: _currentItemSelected,leftuids: _leftUids, firstselecteduids: _firstselecteduids, ))).
                  then((value){
                    if(value!=null){
                   _firstselecteduids = value.firstSelecteduids;
                   _leftUids= value.leftuids;
                   print("---==========---------======");
                   print(_firstselecteduids);
                   print(_leftUids);
                   print("---==========---------======");
                  }
                  });
                  }
                },

                isExpanded: true,
                hint: Text('Select Candidate'),

                value: _currentItemSelected,
                ),
    );
  }

  @override
  void initState() {
    super.initState();
    _sharedprefinit();
    if(previlagelevel==4)
     _finallist= _adminlist;
    else if(previlagelevel==34)
     _finallist = _midadminlist;
    else if(previlagelevel==3)
     _finallist = _subadminlist;    
    if (isedit) _loaddatafromdatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Enter Session Detail',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                      controller: titleText,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                        contentPadding: EdgeInsets.only(left: 8.0),
                        hintText: "Enter Title",
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                      controller: descriptionText,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 8.0),
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                        hintText: "Enter Description",
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Card(
                    color: Colors.white,
                    child: ListTile(
                      trailing: Icon(
                        Icons.alarm,
                        color: Color(0xffF36C24),
                      ),
                      title: Text('Live Session Start Time'),
                      onTap: () {
                        _selectTime(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(12.0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.1,
                    child: Row(  
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text("Select Meeting Candidates", style: TextStyle(fontSize: 16.0),),
                        ),

                      Expanded(
                        flex: 1,
                        child: _dropDownMenu()
                      ) 
                    ],
                            ),
                  ),
                  Divider(
                    height: 48.0,
                    thickness: 2.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      isedit
                          ? GestureDetector(
                              onTap: () {
                                _delfromdatabase();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Color(0xffF36C24)),
                                width: MediaQuery.of(context).size.width / 3.5,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  "Delete Session",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            )
                          : Container(),
                      GestureDetector(
                        onTap: () {
                          _saveintodatabase();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Color(0xffF36C24)),
                          width: MediaQuery.of(context).size.width / 3.5,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text(
                            isedit?"Update": "Save",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}