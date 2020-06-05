import 'dart:async';

import 'package:coach_app/Events/FirebaseMessaging.dart';
import 'package:coach_app/Events/videoConferencing.dart';
import 'package:coach_app/Models/Events.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

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

    _initializeevent();
    storeTokenintoDatabase();
    super.initState();
  }

  void storeTokenintoDatabase() async {
    _firebaseMessaging.getToken().then((token) {
      print("/////////-----.........");
      print("........$token.............");

      final dbref = FirebaseDatabase.instance.reference();
      dbref
          .child(
              'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students')
          .child(FireBaseAuth.instance.user.uid)
          .update({"tokenid": token.toString()});
    });
  }

  _initializeevent() {
    _query = dbRef.reference().child(
        'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/events');
    _onDataAddedSubscription = _query.onChildAdded.listen(onEventAdded);
    _onDataChangedSubscription = _query.onChildChanged.listen(onEventChanged);
    _onDataRemovedSubscription = _query.onChildRemoved.listen(onEventRemoved);
    _firebaseMessagingService.sendNotification();
  }

  onEventAdded(Event event) {
    setState(() {
      print(event.snapshot.key);
      if (event.snapshot.key != null &&
          event.snapshot.value['courseid'] == widget.courseId) {
        _allEvent.add(EventsModal(
            event.snapshot.value['title'],
            event.snapshot.value['description'],
            event.snapshot.value['time'],
            event.snapshot.value['eventkey'],
            event.snapshot.value['isStarted'],
            event.snapshot.value['courseid'],
            event.snapshot.value['subject']));
      }
    });
  }

  onEventRemoved(Event event) {
    print(_allEvent);
    _allEvent.forEach((element) {
      if (element.eventkey == event.snapshot.value['eventkey']) {
        var index = _allEvent.indexOf(element);
        print(_allEvent[index]);
        setState(() {
          _allEvent.removeAt(index);
        });
      }
    });
  }

  onEventChanged(Event event) {
    print(_allEvent);
    _allEvent.forEach((element) {
      if (element.eventkey == event.snapshot.value['eventkey']) {
        var index = _allEvent.indexOf(element);
        print(_allEvent[index]);
        setState(() {
          _allEvent[index] = EventsModal(
              event.snapshot.value['title'],
              event.snapshot.value['description'],
              event.snapshot.value['time'],
              event.snapshot.value['eventkey'],
              event.snapshot.value['isStarted'],
              event.snapshot.value['courseid'],
              event.snapshot.value['subject']);
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
          title: Text('All Sessions'),
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
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.orange, Colors.deepOrange],
            ),
          ),
          child: ListView.builder(
            itemCount: _allEvent.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.video_call),
                        color: _allEvent[index].isStarted == 1
                            ? Colors.orange
                            : Colors.grey,
                        onPressed: () {
                          if (_allEvent[index].isStarted == 1) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return VideoConferencing(
                                room: _allEvent[index].title,
                                eventkey: _allEvent[index].eventkey,
                                subject: _allEvent[index].description,
                                privilegelevel:
                                    FireBaseAuth.instance.previlagelevel,
                              );
                            }));
                          }
                        },
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
                      onTap: () {}));
            },
          ),
        ));
  }
}
