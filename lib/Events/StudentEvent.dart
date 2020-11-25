import 'dart:async';

import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Events/FirebaseMessaging.dart';
import 'package:coach_app/Events/videoConferencing.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Utils/Colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Authentication/FirebaseAuth.dart';

class StudentEvent extends StatefulWidget {
  final String courseId;
  StudentEvent({@required this.courseId});
  @override
  _StudentEventState createState() => _StudentEventState();
}

class _StudentEventState extends State<StudentEvent> {
  List<EventsModal> _allEvent;
  Query _query;
  StreamSubscription<Event> _onDataAddedSubscription;
  StreamSubscription<Event> _onDataChangedSubscription;
  StreamSubscription<Event> _onDataRemovedSubscription;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final FirebaseMessagingService _firebaseMessagingService =
      FirebaseMessagingService();
  @override
  void initState() {
    _allEvent = [];
    _initializeevent();
    storeTokenintoDatabase();
    super.initState();
  }

  void storeTokenintoDatabase() {
    _firebaseMessaging.getToken().then((token) {
      FirebaseDatabase.instance
          .reference()
          .child(
              'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/${FireBaseAuth.instance.user.uid}')
          .update({"tokenid": token.toString()});
    });
  }

  _initializeevent() {
    //Getting Query
    _query = FirebaseDatabase.instance.reference().child(
        'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/events');

    //Setting Listener for data add
    _onDataAddedSubscription = _query.onChildAdded.listen((Event event) {
      setState(() {
        if (event.snapshot.key != null &&
            event.snapshot.value['courseid'] == widget.courseId) {
          _allEvent.add(
              EventsModal.fromJson(event.snapshot.key, event.snapshot.value));
        }
      });
    });

    //Setting Listener for data change
    _onDataChangedSubscription = _query.onChildChanged.listen((Event event) {
      _allEvent.forEach((element) {
        if (element.eventKey == event.snapshot.value['eventKey']) {
          var index = _allEvent.indexOf(element);
          setState(() {
            _allEvent[index] =
                EventsModal.fromJson(event.snapshot.key, event.snapshot.value);
          });
        }
      });
    });

    //Setting Listener for data removal
    _onDataRemovedSubscription = _query.onChildRemoved.listen((Event event) {
      _allEvent.forEach((element) {
        if (element.eventKey == event.snapshot.value['eventKey']) {
          var index = _allEvent.indexOf(element);
          setState(() {
            _allEvent.removeAt(index);
          });
        }
      });
    });
    _firebaseMessagingService.sendNotification();
  }

  @override
  void dispose() {
    _onDataAddedSubscription?.cancel();
    _onDataChangedSubscription?.cancel();
    _onDataRemovedSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GuruCoolLightColor.whiteColor,
        title: Text('All Sessions'.tr()),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: GuruCoolLightColor.backgroundShade,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [GuruCoolLightColor.whiteColor, GuruCoolLightColor.primaryColor],
          ),
        ),
        child: (_allEvent?.length == 0)
            ? Center(
                child: Text(
                  'Currently no live session is scheduled',
                ),
              )
            : ListView.builder(
                itemCount: _allEvent.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: GuruCoolLightColor.whiteColor,
                    elevation: 2.0,
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.video_call,
                          color: _allEvent[index].isStarted == 1
                              ? GuruCoolLightColor.primaryColor
                              : Colors.grey,
                        ),
                      ),
                      title: Text(
                        _allEvent[index].title +
                            " (" +
                            _allEvent[index].subject +
                            ")",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        _allEvent[index].description,
                        style: TextStyle(
                            fontSize: 13.0, fontWeight: FontWeight.w300),
                      ),
                      trailing: Text(
                        (_allEvent[index].time),
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                      onTap: () async {
                        if (await Permission.camera.request().isGranted &&
                            await Permission.microphone.request().isGranted) {
                          if (_allEvent[index].isStarted == 1) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => VideoConferencing(
                                  room: _allEvent[index].title,
                                  eventkey: _allEvent[index].eventKey,
                                  subject: _allEvent[index].description,
                                ),
                              ),
                            );
                          }
                        } else {
                          Alert.instance.alert(context,
                              "You don't have given permission for camera or microphone");
                        }
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
