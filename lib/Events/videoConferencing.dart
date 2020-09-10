import 'dart:async';

import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoConferencing extends StatefulWidget {
  final String passVariable;
  final String room, eventkey;
  final String subject;
  final int privilegelevel;
  final int hostprevilagelevel;
  final String hostuid;
  final bool fromcourse;
  VideoConferencing({
    this.passVariable,
    this.room,
    this.eventkey,
    this.subject,
    this.privilegelevel,
    this.hostuid,
    this.hostprevilagelevel,
    this.fromcourse
  });
  @override
  _VideoConferencingState createState() {
    return _VideoConferencingState();
  }
}

class _VideoConferencingState extends State<VideoConferencing> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 0), () async {
      await _joinMeeting();
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: UploadDialog(warning: 'Connecting to server'.tr())),
    );
  }

  _makeupdate() async {
    if(widget.fromcourse){
    if (FireBaseAuth.instance.previlagelevel >= 2) {
      FirebaseDatabase.instance
          .reference()
          .child(
              'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/events/${widget.passVariable}')
          .update({
        'isStarted': 1,
      });
    }
  }
  
  else{
    FirebaseDatabase.instance.reference()
          .child(
              'institute/${FireBaseAuth.instance.instituteid}/events/${widget.passVariable}')
          .update({
        'isStarted': 1,
      });
  }
  }

  _launchURL() async {
    bool _ishost = false;
    if (widget.hostuid == FireBaseAuth.instance.user.uid) _ishost = true;
    //"https://coachapp-5a4c.firebaseapp.com?previlagelevel="
    //"https://guru-cool-test.web.app?previlagelevel="
    var midurl = "https://coachapp-5a4c.firebaseapp.com?previlagelevel=" +
        FireBaseAuth.instance.previlagelevel.toString() +
        "&photourl=" +
        FireBaseAuth.instance.user.photoUrl +
        "&title=" +
        'GuruCoolSession' +
        widget.eventkey.toString() +
        "&displayName=" +
        FireBaseAuth.instance.user.displayName +
        "&eventkey=" +
        widget.eventkey.toString() +
        "&email=" +
        FireBaseAuth.instance.user.email+
        "&hostPrevilage=" +
        widget.hostprevilagelevel.toString() +
        "&ishost=" +
        _ishost.toString();
    Map<String, String> _map={"previlagelevel":FireBaseAuth.instance.previlagelevel.toString(), "photourl":FireBaseAuth.instance.user.photoUrl,
      "title": 'GuruCoolSession' + widget.eventkey.toString(), "displayName":FireBaseAuth.instance.user.displayName, "eventkey":widget.eventkey.toString(),
      "email":FireBaseAuth.instance.user.email, "hostPrevilage": widget.hostprevilagelevel.toString() , "ishost": _ishost.toString() };    

    var url = 'googlechrome://navigate?url=$midurl';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: false,
        headers: _map
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
