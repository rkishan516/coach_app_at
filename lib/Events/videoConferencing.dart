import 'dart:async';

import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/YT_player/pdf_player.dart';
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
  VideoConferencing(
      {this.passVariable,
      this.room,
      this.eventkey,
      this.subject,
      this.privilegelevel,
      this.hostuid,
      this.hostprevilagelevel,
      this.fromcourse});
  @override
  _VideoConferencingState createState() {
    return _VideoConferencingState();
  }
}

class _VideoConferencingState extends State<VideoConferencing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PDFPlayer(
        link: _joinMeeting(),
      ),
    );
  }

  _makeupdate() async {
    if (widget.fromcourse) {
      if (FireBaseAuth.instance.previlagelevel >= 2) {
        FirebaseDatabase.instance
            .reference()
            .child(
                'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/events/${widget.passVariable}')
            .update({
          'isStarted': 1,
        });
      }
    } else {
      FirebaseDatabase.instance
          .reference()
          .child(
              'institute/${FireBaseAuth.instance.instituteid}/events/${widget.passVariable}')
          .update({
        'isStarted': 1,
      });
    }
  }

  String _launchURL() {
    bool _ishost = false;
    if (widget.hostuid == FireBaseAuth.instance.user.uid) _ishost = true;
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
        FireBaseAuth.instance.user.email +
        "&hostPrevilage=" +
        widget.hostprevilagelevel.toString() +
        "&ishost=" +
        _ishost.toString();

    var url = 'googlechrome://navigate?url=$midurl';
    return midurl;
    // if (await canLaunch(url)) {
    //   await launch(url, forceWebView: false, headers: {
    //     "previlagelevel": FireBaseAuth.instance.previlagelevel.toString(),
    //     "photourl": FireBaseAuth.instance.user.photoUrl,
    //     "title": 'GuruCoolSession' + widget.eventkey.toString(),
    //     "displayName": FireBaseAuth.instance.user.displayName,
    //     "eventkey": widget.eventkey.toString(),
    //     "email": FireBaseAuth.instance.user.email,
    //     "hostPrevilage": widget.hostprevilagelevel.toString(),
    //     "ishost": _ishost.toString()
    //   });
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  String _joinMeeting() {
    _makeupdate();
    return _launchURL();
  }
}
