import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import '../Authentication/FirebaseAuth.dart';

class SessionDetail extends StatefulWidget {
  final String passVaraible;
  final String eventkey;
  final bool isedit;
  final String courseId;
  final String subjectName;
  SessionDetail({
    this.passVaraible,
    this.eventkey,
    this.isedit,
    @required this.courseId,
    @required this.subjectName,
  });
  @override
  _SessionDetailState createState() => _SessionDetailState();
}

class _SessionDetailState extends State<SessionDetail> {
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
        .child(widget.passVaraible)
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
    _pref.setString(descriptionText.text, widget.passVaraible);
    if (widget.isedit && descriptionText.text != previousDescriptionText) {
      _pref.remove(previousDescriptionText);
    }

    dbRef
        .reference()
        .child(
            'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/events')
        .child(widget.passVaraible)
        .update(EventsModal(
          title: titleText.text,
          description: descriptionText.text,
          time: _time.hour.toString() + ":" + _time.minute.toString(),
          isStarted: 0,
          eventkey: widget.eventkey,
          courseid: widget.courseId,
          subject: widget.subjectName,
          teacheruid: FireBaseAuth.instance.user.uid,
        ).toJson());
    Navigator.of(context).pop();
  }

  _delfromdatabase() async {
    dbRef
        .reference()
        .child(
            'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/events')
        .child(widget.passVaraible)
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
                            "Save".tr(),
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
