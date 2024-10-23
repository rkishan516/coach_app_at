import 'package:coach_app/Meeting/Fragmnets/SelectCandidate.dart';
import 'package:coach_app/Meeting/Fragmnets/TwoStepSelectCandidate.dart';
import 'package:coach_app/Models/model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../Authentication/FirebaseAuth.dart';

class SessionDetail extends StatefulWidget {
  final String passVaraible;
  final String eventkey;
  final bool isedit;
  final String courseId;
  final String subjectName;
  final bool fromcourse;

  SessionDetail({
    required this.passVaraible,
    required this.eventkey,
    this.isedit = false,
    required this.fromcourse,
    required this.courseId,
    required this.subjectName,
  });
  @override
  _SessionDetailState createState() => _SessionDetailState();
}

class _SessionDetailState extends State<SessionDetail> {
  final titleText = TextEditingController();
  final descriptionText = TextEditingController();
  final dbRef = FirebaseDatabase.instance;
  int previlagelevel = AppwriteAuth.instance.previlagelevel;
  String previousDescriptionText = "";
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay? _picked;
  String testtime = "hh:mm";
  var _finallist = ["None"];
  var _currentItemSelected = "None";
  var _adminlist = [
    "None",
    "SubAdmins",
    "MidAdmins",
    "SubAdmins within a MidAdmin",
    "Authorities of a branch"
  ];
  var _subadminlist = [
    "None",
    "Teachers",
    "Teachers of a course",
    "Teachers of a subject",
  ];
  var _midadminlist = [
    "None",
    "Other MidAdmins",
    "SubAdmins",
    "Authorities of a branch"
  ];
  String _leftUids = "", _firstselecteduids = "";
  var _previoustypeSelected = "";

  _loaddatafromdatabase() async {
    if (widget.fromcourse) {
      dbRef
          .ref()
          .child(
              'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/events')
          .child(widget.passVaraible)
          .once()
          .then((value) {
        setState(() {
          titleText.text = (value.snapshot.value as Map)['title'];
          descriptionText.text = (value.snapshot.value as Map)['description'];
          testtime = (value.snapshot.value as Map)['time'];
          _time = TimeOfDay(
              hour: int.parse((value.snapshot.value as Map)['time']
                  .toString()
                  .split(":")[0]),
              minute: int.parse((value.snapshot.value as Map)['time']
                  .toString()
                  .split(":")[1]));
          previousDescriptionText =
              (value.snapshot.value as Map)['description'];
        });
      });
    } else {
      dbRef
          .ref()
          .child('institute/${AppwriteAuth.instance.instituteid}/events')
          .child(widget.passVaraible)
          .once()
          .then((value) {
        setState(() {
          titleText.text = (value.snapshot.value as Map)['title'];
          descriptionText.text = (value.snapshot.value as Map)['description'];
          _time = TimeOfDay(
              hour: int.parse((value.snapshot.value as Map)['time']
                  .toString()
                  .split(":")[0]),
              minute: int.parse((value.snapshot.value as Map)['time']
                  .toString()
                  .split(":")[1]));
          previousDescriptionText =
              (value.snapshot.value as Map)['description'];
          _currentItemSelected = (value.snapshot.value as Map)['type'];
          _previoustypeSelected = _currentItemSelected;
          _leftUids = (value.snapshot.value as Map)["leftUids"];
          _firstselecteduids =
              (value.snapshot.value as Map)["firstselecteduids"];
        });
      });
    }
  }

  _saveintodatabase() async {
    AppwriteAuth.instance.prefs!
        .setString(descriptionText.text, widget.passVaraible);
    if (widget.isedit && descriptionText.text != previousDescriptionText) {
      AppwriteAuth.instance.prefs!.remove(previousDescriptionText);
    }
    if (widget.fromcourse) {
      dbRef
          .ref()
          .child(
              'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/events')
          .child(widget.passVaraible)
          .update(EventsModal(
            title: titleText.text,
            description: descriptionText.text,
            time: _time.hour.toString() + ":" + _time.minute.toString(),
            isStarted: 0,
            eventKey: widget.eventkey,
            courseid: widget.courseId,
            subject: widget.subjectName,
            teacheruid: AppwriteAuth.instance.user!.$id,
          ).toJson());
    } else {
      dbRef
          .ref()
          .child('institute/${AppwriteAuth.instance.instituteid}/events')
          .child(widget.passVaraible)
          .update({
        'title': titleText.text,
        'description': descriptionText.text,
        'time': _time.hour.toString() + ":" + _time.minute.toString(),
        'eventKey': widget.eventkey,
        'isStarted': 0,
        'hostprevilage': previlagelevel,
        'hostuid': AppwriteAuth.instance.user!.$id,
        'hostname': AppwriteAuth.instance.user!.name,
        "firstselecteduids": _firstselecteduids,
        "leftUids": _leftUids,
        "type": _currentItemSelected
      });
    }
    Navigator.of(context).pop();
  }

  _delfromdatabase() async {
    if (widget.fromcourse) {
      dbRef
          .ref()
          .child(
              'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/events')
          .child(widget.passVaraible)
          .remove();
    } else {
      dbRef
          .ref()
          .child('institute/${AppwriteAuth.instance.instituteid}/events')
          .child(widget.passVaraible)
          .remove();
    }
    AppwriteAuth.instance.prefs!.remove(previousDescriptionText);
    Navigator.of(context).pop();
  }

  Future<Null> _selectTime(BuildContext context) async {
    _picked = await showTimePicker(context: context, initialTime: _time);
    if (_picked == null) return;
    setState(
      () {
        _time = _picked!;
        testtime = _time.hour.toString() + ":" + _time.minute.toString();
      },
    );
  }

  Widget _dropDownMenu() {
    return Center(
      child: DropdownButton<String>(
        items: _finallist.map((String dropDownStringitem) {
          return DropdownMenuItem<String>(
            value: dropDownStringitem,
            child: Text(dropDownStringitem),
          );
        }).toList(),
        onChanged: (String? newValueSelected) {
          if (newValueSelected == null) return;
          setState(() {
            this._currentItemSelected = newValueSelected;
          });
          if (_previoustypeSelected != _currentItemSelected) {
            _leftUids = "";
            _firstselecteduids = "";
          }
          if (newValueSelected != "None" && newValueSelected == "SubAdmins" ||
              newValueSelected == "MidAdmins" ||
              newValueSelected == "Teachers" ||
              newValueSelected == "All students" ||
              newValueSelected == "Other MidAdmins")
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (context) => SelectCandidate(
                          type: _currentItemSelected,
                          leftuids: _leftUids,
                        )))
                .then((value) {
              if (value != null) _leftUids = value;
            });
          else {
            if (newValueSelected != "None")
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (context) => TwoStepSelectCandidate(
                            type: _currentItemSelected,
                            leftuids: _leftUids,
                            firstselecteduids: _firstselecteduids,
                          )))
                  .then((value) {
                if (value != null) {
                  _firstselecteduids = value.firstSelecteduids;
                  _leftUids = value.leftuids;
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

    if (!widget.fromcourse) {
      if (previlagelevel == 4)
        _finallist = _adminlist;
      else if (previlagelevel == 34)
        _finallist = _midadminlist;
      else if (previlagelevel == 3) _finallist = _subadminlist;
    }

    if (widget.isedit) _loaddatafromdatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Enter Session Detail'.tr(),
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
                        hintText: "Enter Title".tr(),
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
                      hintText: "Enter Description".tr(),
                    ),
                  ),
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
                      title: Text('Live Session Start Time'.tr()),
                      onTap: () {
                        _selectTime(context);
                      },
                    ),
                  ),
                  if (!widget.fromcourse)
                    Container(
                      padding: EdgeInsets.all(12.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Select Meeting Candidates",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Expanded(flex: 1, child: _dropDownMenu())
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
                      if (widget.isedit)
                        GestureDetector(
                          onTap: () {
                            _delfromdatabase();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                5.0,
                              ),
                              color: Color(
                                0xffF36C24,
                              ),
                            ),
                            width: MediaQuery.of(context).size.width / 3.5,
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Delete Session".tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      GestureDetector(
                        onTap: () {
                          _saveintodatabase();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5.0,
                            ),
                            color: Color(
                              0xffF36C24,
                            ),
                          ),
                          width: MediaQuery.of(context).size.width / 3.5,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text(
                            widget.isedit ? "Update".tr() : "Save".tr(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
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
