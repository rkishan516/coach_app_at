import 'dart:async';

import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:coach_app/Events/FirebaseMessaging.dart';
import 'package:coach_app/Events/SessionDetail.dart';
import 'package:coach_app/Events/videoConferencing.dart';
import 'package:coach_app/GlobalFunction/SlideButton.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Models/random_string.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Authentication/FirebaseAuth.dart';

class Calender extends StatefulWidget {
  final String? courseId;
  final String? subjectName;
  final bool fromCourse;
  Calender({this.courseId, this.subjectName, required this.fromCourse});
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  String passVariable = "", previouspassVariable = "", eventkey = "";
  Map<DateTime, List<dynamic>> _events = {};
  final dbRef = FirebaseDatabase.instance;
  late StreamSubscription<DatabaseEvent> _onDataAddedSubscription;
  late StreamSubscription<DatabaseEvent> _onDataChangedSubscription;
  late StreamSubscription<DatabaseEvent> _onDataRemovedSubscription;
  final FirebaseMessagingService _firebaseMessagingService =
      FirebaseMessagingService();
  late Query _query;
  List<dynamic> _selectedEvents = [];
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _initializeevent();
  }

  _initializeevent() {
    if (widget.fromCourse)
      _query = dbRef.ref().child(
          'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/events');
    else
      _query = dbRef
          .ref()
          .child('institute/${AppwriteAuth.instance.instituteid}')
          .child('events');

    _onDataAddedSubscription = _query.onChildAdded.listen(onEventAdded);
    _onDataChangedSubscription = _query.onChildChanged.listen(onEventChanged);
    _onDataRemovedSubscription = _query.onChildRemoved.listen(onEventRemoved);
    _firebaseMessagingService.sendNotification();
    //_firebaseMessagingService.storeTokenintoDatabase();
  }

  onEventAdded(DatabaseEvent event) {
    setState(() {
      if (event.snapshot.key != null) {
        String str = event.snapshot.key!.substring(0, 10) + 'T12:00:00.000Z';
        DateTime _key = DateTime.parse(str);

        if (widget.fromCourse) {
          if ((event.snapshot.value as Map)['teacheruid'] ==
              "${AppwriteAuth.instance.user!.$id}") {
            if (_events[_key] == null) {
              _events[_key] = [
                EventsModal.fromJson(
                    event.snapshot.key!, event.snapshot.value as Map)
              ];
            } else {
              _events[_key]!.add(EventsModal.fromJson(
                  event.snapshot.key!, event.snapshot.value as Map));
            }
          }
        } else {
          if ((event.snapshot.value as Map)['hostuid'] ==
              AppwriteAuth.instance.user!.$id) {
            if (_events[_key] == null) {
              _events[_key] = [
                GeneralEventsModal.fromJson(
                    event.snapshot.key!, event.snapshot.value as Map)
              ];
            } else {
              _events[_key]!.add(
                GeneralEventsModal.fromJson(
                  event.snapshot.key!,
                  event.snapshot.value as Map,
                ),
              );
            }
          }
        }
      }
    });
  }

  onEventRemoved(DatabaseEvent event) {
    _showsnackbar(context, "Session is Removed".tr());
    String str = event.snapshot.key!.substring(0, 10) + 'T12:00:00.000Z';
    DateTime _key = DateTime.parse(str);
    var index;
    _events[_key]!.forEach((element) {
      if (element.eventKey == (event.snapshot.value as Map)['eventKey']) {
        index = _events[_key]!.indexOf(element);
      }
    });
    setState(() {
      _events[_key]!.removeAt(index);
    });
  }

  onEventChanged(DatabaseEvent event) {
    String str = event.snapshot.key!.substring(0, 10) + 'T12:00:00.000Z';
    DateTime _key = DateTime.parse(str);
    _events[_key]!.forEach((element) {
      if (element.eventKey == (event.snapshot.value as Map)['eventKey']) {
        var index = _events[_key]!.indexOf(element);
        setState(() {
          if (widget.fromCourse)
            _events[_key]![index] = EventsModal.fromJson(
                event.snapshot.key!, event.snapshot.value as Map);
          else
            _events[_key]![index] = GeneralEventsModal.fromJson(
                event.snapshot.key!, event.snapshot.value as Map);
        });
      }
    });
    _showsnackbar(context, "Session is Updated".tr());
  }

  void _showsnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    _onDataAddedSubscription.cancel();
    _onDataChangedSubscription.cancel();
    _onDataRemovedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Select Date'.tr()),
      ),
      floatingActionButton: SlideButtonR(
          text: 'Add Session'.tr(),
          onTap: () {
            if (passVariable != "") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SessionDetail(
                    passVaraible: passVariable,
                    eventkey: eventkey,
                    isedit: false,
                    courseId: widget.courseId!,
                    subjectName: widget.subjectName!,
                    fromcourse: widget.fromCourse,
                  ),
                ),
              );
            } else if (passVariable == previouspassVariable ||
                passVariable == "") _showsnackbar(context, "Select Date".tr());
          },
          width: 150,
          height: 50),
      body: Container(
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
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              color: Colors.white,
              child: TableCalendar(
                firstDay: DateTime.now().subtract(const Duration(days: 100)),
                lastDay: DateTime.now().add(const Duration(days: 100)),
                focusedDay: DateTime.now(),
                eventLoader: (day) {
                  return _events[day] ?? [];
                },
                calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Color(0xffF36C24),
                    ),
                    todayTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white)),
                headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonDecoration: BoxDecoration(
                      color: Color(0xffF36C24),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    formatButtonTextStyle: TextStyle(color: Colors.white),
                    formatButtonShowsNext: false),
                onDaySelected: (date, focusDay) {
                  String _month = date.month.toString();
                  String _day = date.day.toString();
                  if (_month.length == 1) {
                    _month = "0" + _month;
                  }
                  if (_day.length == 1) {
                    _day = "0" + _day;
                  }
                  eventkey = randomNumeric(10);
                  passVariable = date.year.toString() +
                      "-" +
                      _month +
                      "-" +
                      _day +
                      eventkey;
                  previouspassVariable = passVariable;
                  setState(() {
                    _selectedEvents = _events[date] ?? [];
                  });
                },
                calendarBuilders:
                    CalendarBuilders(selectedBuilder: (context, date, events) {
                  return Container(
                    margin: EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xffF36C24), shape: BoxShape.circle),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }),
              ),
            ),
            ..._selectedEvents.map((e) {
              int isStarted = e.isStarted;
              return Card(
                color: isStarted == 1 ? Colors.blue : Colors.white,
                elevation: 2.0,
                child: ListTile(
                  onTap: () async {
                    String pass2 =
                        AppwriteAuth.instance.prefs!.getString(e.description)!;
                    if (await Permission.camera.request().isGranted &&
                        await Permission.microphone.request().isGranted) {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          if (widget.fromCourse) {
                            print(e.teacheruid);
                            print("llllllllllllllllll");
                            return VideoConferencing(
                              passVariable: pass2,
                              eventkey: e.eventKey,
                              hostuid: e.teacheruid,
                              fromcourse: widget.fromCourse,
                            );
                          } else
                            return VideoConferencing(
                              passVariable: pass2,
                              privilegelevel:
                                  AppwriteAuth.instance.previlagelevel,
                              eventkey: e.eventKey,
                              hostprevilagelevel: e.hostPrevilage,
                              hostuid: e.hostuid,
                              fromcourse: widget.fromCourse,
                            );
                        }),
                      );
                    } else {
                      Alert.instance.alert(context,
                          "You don't have given permission for camera or microphone");
                    }
                    var res = await showDialog(
                        context: context,
                        builder: (context) => AreYouSure(
                              text: 'Do you want to close the session ?',
                            ));
                    if (res != 'Yes') {
                      return;
                    }
                    if (widget.fromCourse)
                      FirebaseDatabase.instance
                          .ref()
                          .child(
                              'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/events/$pass2/')
                          .update({"isStarted": 0});
                    else
                      FirebaseDatabase.instance
                          .ref()
                          .child(
                              'institute/${AppwriteAuth.instance.instituteid}/events/$pass2/')
                          .update({"isStarted": 0});
                  },
                  onLongPress: () {
                    String pass =
                        AppwriteAuth.instance.prefs!.getString(e.description)!;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SessionDetail(
                          courseId: widget.courseId!,
                          subjectName: widget.subjectName!,
                          passVaraible: pass,
                          eventkey: pass.substring(10, pass.length),
                          isedit: true,
                          fromcourse: widget.fromCourse,
                        ),
                      ),
                    );
                  },
                  title: Text(
                    e.title + " at " + e.time,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    e.description,
                    style:
                        TextStyle(fontSize: 13.0, fontWeight: FontWeight.w300),
                  ),
                  leading: Icon(
                    Icons.video_call,
                    color: Color(0xffF36C24),
                  ),
                ),
              );
            })
          ],
        )),
      ),
    );
  }
}
