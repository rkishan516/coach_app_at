import 'dart:async';

import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Events/FirebaseMessaging.dart';
import 'package:coach_app/Events/videoConferencing.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class AllMeetingSession extends StatefulWidget {
  @override
  _AllMeetingSessionState createState() => _AllMeetingSessionState();
}

class _AllMeetingSessionState extends State<AllMeetingSession> {
  List<GeneralEventsModal> _allEvent;
  Query _query;
  int previlagelevel = FireBaseAuth.instance.previlagelevel;
  final dbRef = FirebaseDatabase.instance;
  StreamSubscription<Event> _onDataAddedSubscription;
  StreamSubscription<Event> _onDataChangedSubscription;
  StreamSubscription<Event> _onDataRemovedSubscription;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final FirebaseMessagingService _firebaseMessagingService =
      FirebaseMessagingService();

  @override
  void initState() {
    _allEvent = [];
    _firebaseMessagingService.sendNotification();

    _initializeevent();
    storeTokenintoDatabase();
    super.initState();
  }

  void storeTokenintoDatabase() async {
    _firebaseMessaging.getToken().then((token) {
      final dbref = FirebaseDatabase.instance.reference();
      dbref
          .child(
              'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}')
          .child('admin')
          .child(FireBaseAuth.instance.user.uid)
          .child("tokenid")
          .set(token.toString());
    });
  }

  _initializeevent() {
    _query = dbRef
        .reference()
        .child('institute/${FireBaseAuth.instance.instituteid}')
        .child('events');
    _onDataAddedSubscription = _query.onChildAdded.listen(onEventAdded);
    _onDataChangedSubscription = _query.onChildChanged.listen(onEventChanged);
    _onDataRemovedSubscription = _query.onChildRemoved.listen(onEventRemoved);
    //_firebaseMessagingService.sendNotification();
  }

  Future<bool> checkentry(Event event) async {
    String hostuid = event.snapshot.value['hostuid'];
    String firstselecteduids = event.snapshot.value['firstselecteduids'];
    int hostprevilage = event.snapshot.value['hostprevilage'];
    String leftuids = event.snapshot.value['leftUids'] ?? "";
    String type = event.snapshot.value['type'];
    if (hostprevilage == 4) {
      if (type == "SubAdmins" &&
          previlagelevel == 3 &&
          !leftuids.contains(FireBaseAuth.instance.user.uid))
        return true;
      else if (type == "MidAdmins" &&
          previlagelevel == 34 &&
          !leftuids.contains(FireBaseAuth.instance.user.uid))
        return true;
      else if (type == "SubAdmins within a MidAdmin" &&
          (previlagelevel == 34 || previlagelevel == 3) &&
          !(firstselecteduids == "")) {
        if (previlagelevel == 34 &&
            firstselecteduids.contains(FireBaseAuth.instance.user.uid))
          return true;
        else if (previlagelevel == 3) {
          DataSnapshot _snapshot = await dbRef
              .reference()
              .child('institute/${FireBaseAuth.instance.instituteid}/midAdmin')
              .child(firstselecteduids.split(":_:_:")[0])
              .child("branches")
              .once();
          String branches = _snapshot.value.toString();
          if (branches.contains(FireBaseAuth.instance.branchid) &&
              !leftuids.contains(FireBaseAuth.instance.user.uid))
            return true;
          else
            return false;
        } else
          return false;
      } else if (type == "Authorities of a branch" &&
          (previlagelevel == 2 || previlagelevel == 3) &&
          firstselecteduids.contains(FireBaseAuth.instance.branchid) &&
          !leftuids.contains(FireBaseAuth.instance.user.uid))
        return true;
      else
        return false;
    } else if (hostprevilage == 34) {
      if (type == "Other MidAdmins" &&
          previlagelevel == 34 &&
          !leftuids.contains(FireBaseAuth.instance.user.uid))
        return true;
      else if (type == "SubAdmins" && previlagelevel == 3) {
        DataSnapshot _snapshot = await dbRef
            .reference()
            .child('institute/${FireBaseAuth.instance.instituteid}/midAdmin')
            .child(hostuid)
            .child("branches")
            .once();
        String branches = _snapshot.value.toString();
        if (branches.contains(FireBaseAuth.instance.branchid) &&
            !leftuids.contains(FireBaseAuth.instance.user.uid))
          return true;
        else
          return false;
      } else if (type == "Authorities of a branch" &&
          (previlagelevel == 2 || previlagelevel == 3) &&
          firstselecteduids.contains(FireBaseAuth.instance.branchid) &&
          !leftuids.contains(FireBaseAuth.instance.user.uid))
        return true;
      else
        return false;
    } else if (hostprevilage == 3) {
      if (type == "Teachers" &&
          previlagelevel == 2 &&
          !leftuids.contains(FireBaseAuth.instance.user.uid))
        return true;
      else if (type == "All students" &&
          previlagelevel == 1 &&
          !leftuids.contains(FireBaseAuth.instance.user.uid))
        return true;
      else if (type == "Teachers of a course" && previlagelevel == 2) {
        DataSnapshot _snapshot = await dbRef
            .reference()
            .child(
                'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/teachers/${FireBaseAuth.instance.user.uid}/courses')
            .once();
        List list = _snapshot.value;
        list.forEach((element) {
          if (firstselecteduids.contains(element["id"]) &&
              !leftuids.contains(FireBaseAuth.instance.user.uid))
            return true;
          else
            return false;
        });
      } else if (type == "Teachers of a subject" && previlagelevel == 2) {
        String courseid = firstselecteduids.split(":_:_:")[0].toString();
        String email = FireBaseAuth.instance.user.email;
        DataSnapshot _snapshot = await dbRef
            .reference()
            .child(
                'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/$courseid/subjects')
            .orderByChild("mentor/${email.split("@")[0]}")
            .once();
        if (_snapshot.value != null &&
            !leftuids.contains(FireBaseAuth.instance.user.uid))
          return true;
        else
          return false;
      } else {
        return false;
      }
    }
    return true;
  }

  onEventAdded(Event event) async {
    bool isallowedtoadd = await checkentry(event);
    if (event.snapshot.key != null && isallowedtoadd) {
      setState(() {
        _allEvent.add(GeneralEventsModal.fromJson(
            event.snapshot.key, event.snapshot.value));
      });
    }
  }

  onEventRemoved(Event event) {
    _allEvent.forEach((element) {
      if (element.eventKey == event.snapshot.value['eventKey']) {
        var index = _allEvent.indexOf(element);

        setState(() {
          _allEvent.removeAt(index);
        });
      }
    });
  }

  onEventChanged(Event event) {
    _allEvent.forEach((element) async {
      if (element.eventKey == event.snapshot.value['eventKey']) {
        var index = _allEvent.indexOf(element);
        bool isallowedtoadd = await checkentry(event);

        if (isallowedtoadd)
          setState(() {
            _allEvent[index] = GeneralEventsModal.fromJson(
                event.snapshot.key, event.snapshot.value);
          });
        else
          setState(() {
            _allEvent.removeAt(index);
          });
      }
    });
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
        appBar: AppBar(
          title: Text('All Events'),
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(12.0),
          itemCount: _allEvent.length,
          itemBuilder: (BuildContext context, int index) {
            String date = _allEvent[index].meetingkey.substring(0, 10);
            String eventdate = date.split("-")[2] +
                "/" +
                date.split("-")[1] +
                "/" +
                date.split("-")[0];
            return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Color(0xffF36C24),
                elevation: 2.0,
                child: ListTile(
                    leading: IconButton(
                      icon: Icon(
                        Icons.video_call,
                      ),
                      color: _allEvent[index].isStarted == 1
                          ? Colors.blue
                          : Colors.white,
                      onPressed: () {},
                    ),
                    title: Text(
                      _allEvent[index].title +
                          " (created by " +
                          _allEvent[index]?.hostname +
                          ")",
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      _allEvent[index].description,
                      style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    trailing: Text(
                      eventdate + "\n" + (_allEvent[index].time),
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onTap: () {
                      if (_allEvent[index].isStarted == 1) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return VideoConferencing(
                            passVariable: _allEvent[index].meetingkey,
                            room: _allEvent[index].title,
                            subject: _allEvent[index].description,
                            hostprevilagelevel: _allEvent[index].hostPrevilage,
                            hostuid: _allEvent[index].hostuid,
                            eventkey: _allEvent[index].eventKey,
                            privilegelevel:
                                FireBaseAuth.instance.previlagelevel,
                            fromcourse: false,
                          );
                        }));
                      }
                    }));
          },
        ));
  }
}
