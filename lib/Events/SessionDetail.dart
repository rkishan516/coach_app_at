import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Authentication/FirebaseAuth.dart';

class SessionDetail extends StatefulWidget {
  final String passVaraible;
  final String eventkey;
  final bool isedit;
  final String courseId;
  final String subjectName;
  SessionDetail(
      {this.passVaraible,
      this.eventkey,
      this.isedit,
      @required this.courseId,
      @required this.subjectName});
  @override
  _SessionDetailState createState() =>
      _SessionDetailState(passVaraible, eventkey, isedit);
}

class _SessionDetailState extends State<SessionDetail> {
  String passVariable;
  final String eventkey;
  final bool isedit;
  _SessionDetailState(this.passVariable, this.eventkey, this.isedit);
  final titleText = TextEditingController();
  final descriptionText = TextEditingController();
  final dbRef = FirebaseDatabase.instance;
  SharedPreferences _pref;
  String previousDescriptionText = "";
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay _picked;
  String testtime = "hh:mm";
  _loaddatafromdatabase() async {
    dbRef
        .reference()
        .child(
            'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/events')
        .child(passVariable)
        .once()
        .then((DataSnapshot value) {
      setState(() {
        titleText.text = value.value['title'];
        descriptionText.text = value.value['description'];
        testtime = value.value['time'];
        previousDescriptionText = value.value['description'];
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
            'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/events')
        .child(passVariable)
        .update({
      'title': titleText.text,
      'description': descriptionText.text,
      'time': _time.hour.toString() + ":" + _time.minute.toString(),
      'eventkey': eventkey,
      'isStarted': 0,
      'teacheruid': "${FireBaseAuth.instance.user.uid}",
      "courseid": "${widget.courseId}",
      "subject": "${widget.subjectName}"
    });
    Navigator.of(context).pop();
  }

  _delfromdatabase() async {
    dbRef
        .reference()
        .child(
            'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/events')
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

  @override
  void initState() {
    super.initState();
    _sharedprefinit();
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
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.orange, Colors.deepOrange])),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(4.0),
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
                        labelText: "Enter Title",
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                      controller: descriptionText,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                        labelText: "Enter Description",
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Card(
                    color: Colors.white,
                    child: ListTile(
                      trailing: Icon(
                        Icons.alarm,
                        color: Colors.orange,
                      ),
                      title: Text('Live Session Start Time'),
                      onTap: () {
                        _selectTime(context);
                      },
                    ),
                  ),
                  Divider(
                    height: 48.0,
                    thickness: 2.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      _saveintodatabase();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.orange),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  isedit
                      ? GestureDetector(
                          onTap: () {
                            _delfromdatabase();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.white),
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            alignment: Alignment.center,
                            child: Text(
                              "Delete Session",
                              style: TextStyle(color: Colors.orange),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 10.0,
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
