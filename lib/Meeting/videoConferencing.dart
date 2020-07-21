import 'dart:async';
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoConferencing extends StatefulWidget {
  final String passVariable;
  final String room, eventkey;
  final String subject;
  final int privilegelevel;
  final int hostprevilagelevel;
  final String hostuid;
  VideoConferencing({
    this.passVariable,
    this.room,
    this.eventkey,
    this.subject,
    this.privilegelevel,
    this.hostuid,
    this.hostprevilagelevel
  });
  @override
  _VideoConferencingState createState() {
    if (privilegelevel >= 2)
      return _VideoConferencingState(
          passVariable: passVariable, privilegelevel: privilegelevel);
    else
      return _VideoConferencingState(
        room: room,
        eventkey: eventkey,
        subject: subject,
        privilegelevel: privilegelevel,
      );
  }
}

class _VideoConferencingState extends State<VideoConferencing> {
  final String passVariable;
  String room, eventkey;
  final String subject;
  int privilegelevel;
  _VideoConferencingState({
    this.passVariable,
    this.room,
    this.eventkey,
    this.subject,
    this.privilegelevel,
  });
  final serverText = TextEditingController();
  final roomText = TextEditingController();
  final subjectText = TextEditingController();
  var isAudioOnly = true;
  var isAudioMuted = false;
  var isVideoMuted = true;

  final dbRef = FirebaseDatabase.instance;

  @override
  void initState() {
    super.initState();
    roomText.text = 'GuruCoolSession' + widget.eventkey;
    Timer(Duration(seconds: 0), () async {
      await _joinMeeting();
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Center(child: UploadDialog(warning: 'Connecting to server'.tr()))
            ],
          ),
        ),
      ),
    );
  }

  _makeupdate() async {
    if (privilegelevel >= 2) {
      dbRef
          .reference()
          .child(
              'institute/${FireBaseAuth.instance.instituteid}/events/$passVariable')
          .update({
        'isStarted': 1,
      });
    }
  }

  bool toggleValue = false;
  _launchURL() async {
    bool _ishost= false;
    if(widget.hostuid==FireBaseAuth.instance.user.uid)
    _ishost= true;

    var midurl = "https://guru-cool-test.web.app?previlagelevel=" +
        2.toString() +
        "&photourl=" +
         FireBaseAuth.instance.user.photoUrl+
        "&title=" +
        roomText.text.toString() +
        "&displayName=" +
        FireBaseAuth.instance.user.displayName +
        "&eventkey=" +
        widget.eventkey.toString() +
        "&email=" +
        FireBaseAuth.instance.user.email+
         "&hostPrevilage="+
         widget.hostprevilagelevel.toString()+
         "&ishost="+
         _ishost.toString();

    var url = 'googlechrome://navigate?url=$midurl';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  _joinMeeting() async {
    _makeupdate();
    _launchURL();
  }
}