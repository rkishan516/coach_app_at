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
  List<GeneralEventsModal> _allEvent = [];
  late Query _query;
  int previlagelevel = AppwriteAuth.instance.previlagelevel;
  final dbRef = FirebaseDatabase.instance;
  late StreamSubscription<DatabaseEvent> _onDataAddedSubscription;
  late StreamSubscription<DatabaseEvent> _onDataChangedSubscription;
  late StreamSubscription<DatabaseEvent> _onDataRemovedSubscription;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
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
      final dbref = FirebaseDatabase.instance.ref();
      dbref
          .child(
              'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}')
          .child('admin')
          .child(AppwriteAuth.instance.user!.$id)
          .child("tokenid")
          .set(token.toString());
    });
  }

  _initializeevent() {
    _query = dbRef
        .ref()
        .child('institute/${AppwriteAuth.instance.instituteid}')
        .child('events');
    _onDataAddedSubscription = _query.onChildAdded.listen(onEventAdded);
    _onDataChangedSubscription = _query.onChildChanged.listen(onEventChanged);
    _onDataRemovedSubscription = _query.onChildRemoved.listen(onEventRemoved);
    //_firebaseMessagingService.sendNotification();
  }

  Future<bool> checkentry(DatabaseEvent event) async {
    final data = event.snapshot.value as Map;
    String hostuid = data['hostuid'];
    String firstselecteduids = data['firstselecteduids'];
    int hostprevilage = data['hostprevilage'];
    String leftuids = data['leftUids'] ?? "";
    String type = data['type'];
    if (hostprevilage == 4) {
      if (type == "SubAdmins" &&
          previlagelevel == 3 &&
          !leftuids.contains(AppwriteAuth.instance.user!.$id))
        return true;
      else if (type == "MidAdmins" &&
          previlagelevel == 34 &&
          !leftuids.contains(AppwriteAuth.instance.user!.$id))
        return true;
      else if (type == "SubAdmins within a MidAdmin" &&
          (previlagelevel == 34 || previlagelevel == 3) &&
          !(firstselecteduids == "")) {
        if (previlagelevel == 34 &&
            firstselecteduids.contains(AppwriteAuth.instance.user!.$id))
          return true;
        else if (previlagelevel == 3) {
          final _snapshot = await dbRef
              .ref()
              .child('institute/${AppwriteAuth.instance.instituteid}/midAdmin')
              .child(firstselecteduids.split(":_:_:")[0])
              .child("branches")
              .once();
          String branches = _snapshot.snapshot.value.toString();
          if (branches.contains(AppwriteAuth.instance.branchid!) &&
              !leftuids.contains(AppwriteAuth.instance.user!.$id))
            return true;
          else
            return false;
        } else
          return false;
      } else if (type == "Authorities of a branch" &&
          (previlagelevel == 2 || previlagelevel == 3) &&
          firstselecteduids.contains(AppwriteAuth.instance.branchid!) &&
          !leftuids.contains(AppwriteAuth.instance.user!.$id))
        return true;
      else
        return false;
    } else if (hostprevilage == 34) {
      if (type == "Other MidAdmins" &&
          previlagelevel == 34 &&
          !leftuids.contains(AppwriteAuth.instance.user!.$id))
        return true;
      else if (type == "SubAdmins" && previlagelevel == 3) {
        final _snapshot = await dbRef
            .ref()
            .child('institute/${AppwriteAuth.instance.instituteid}/midAdmin')
            .child(hostuid)
            .child("branches")
            .once();
        String branches = _snapshot.snapshot.value.toString();
        if (branches.contains(AppwriteAuth.instance.branchid!) &&
            !leftuids.contains(AppwriteAuth.instance.user!.$id))
          return true;
        else
          return false;
      } else if (type == "Authorities of a branch" &&
          (previlagelevel == 2 || previlagelevel == 3) &&
          firstselecteduids.contains(AppwriteAuth.instance.branchid!) &&
          !leftuids.contains(AppwriteAuth.instance.user!.$id))
        return true;
      else
        return false;
    } else if (hostprevilage == 3) {
      if (type == "Teachers" &&
          previlagelevel == 2 &&
          !leftuids.contains(AppwriteAuth.instance.user!.$id))
        return true;
      else if (type == "All students" &&
          previlagelevel == 1 &&
          !leftuids.contains(AppwriteAuth.instance.user!.$id))
        return true;
      else if (type == "Teachers of a course" && previlagelevel == 2) {
        final _snapshot = await dbRef
            .ref()
            .child(
                'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/teachers/${AppwriteAuth.instance.user!.$id}/courses')
            .once();
        List list = _snapshot.snapshot.value as List;
        for (final element in list) {
          if (firstselecteduids.contains(element["id"]) &&
              !leftuids.contains(AppwriteAuth.instance.user!.$id))
            return true;
          else
            return false;
        }
      } else if (type == "Teachers of a subject" && previlagelevel == 2) {
        String courseid = firstselecteduids.split(":_:_:")[0].toString();
        String email = AppwriteAuth.instance.user!.email!;
        final _snapshot = await dbRef
            .ref()
            .child(
                'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/courses/$courseid/subjects')
            .orderByChild("mentor/${email.split("@")[0]}")
            .once();
        if (_snapshot.snapshot.value != null &&
            !leftuids.contains(AppwriteAuth.instance.user!.$id))
          return true;
        else
          return false;
      } else {
        return false;
      }
    }
    return true;
  }

  onEventAdded(DatabaseEvent event) async {
    bool isallowedtoadd = await checkentry(event);
    if (event.snapshot.key != null && isallowedtoadd) {
      setState(() {
        _allEvent.add(GeneralEventsModal.fromJson(
            event.snapshot.key!, event.snapshot.value! as Map));
      });
    }
  }

  onEventRemoved(DatabaseEvent event) {
    _allEvent.forEach((element) {
      if (element.eventKey == (event.snapshot.value as Map)['eventKey']) {
        var index = _allEvent.indexOf(element);

        setState(() {
          _allEvent.removeAt(index);
        });
      }
    });
  }

  onEventChanged(DatabaseEvent event) {
    _allEvent.forEach((element) async {
      if (element.eventKey == (event.snapshot.value as Map)['eventKey']) {
        var index = _allEvent.indexOf(element);
        bool isallowedtoadd = await checkentry(event);

        if (isallowedtoadd)
          setState(() {
            _allEvent[index] = GeneralEventsModal.fromJson(
                event.snapshot.key!, event.snapshot.value as Map);
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
                          _allEvent[index].hostname +
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
                                AppwriteAuth.instance.previlagelevel,
                            fromcourse: false,
                          );
                        }));
                      }
                    }));
          },
        ));
  }
}
