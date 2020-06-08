import 'dart:async';

import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:easy_localization/easy_localization.dart';
import '../Authentication/FirebaseAuth.dart';

class VideoConferencing extends StatefulWidget {
  final String passVariable;
  final String room, eventkey;
  final String subject;
  final int privilegelevel;
  VideoConferencing({
    this.passVariable,
    this.room,
    this.eventkey,
    this.subject,
    this.privilegelevel,
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
  final String room, eventkey;
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
  final nameText = TextEditingController();
  final emailText = TextEditingController();
  var isAudioOnly = true;
  var isAudioMuted = false;
  var isVideoMuted = true;

  final dbRef = FirebaseDatabase.instance;

  _loaddatafromdatabase() async {
    dbRef
        .reference()
        .child(
          'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/events',
        )
        .child(passVariable)
        .once()
        .then(
      (value) {
        setState(
          () {
            roomText.text = value.value['eventkey'];
            subjectText.text = value.value['description'];
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
    if (privilegelevel >= 2) {
      _loaddatafromdatabase();
    } else {
      setState(() {
        roomText.text = eventkey;
        subjectText.text = subject;
      });
    }
    Timer(Duration(seconds: 3), () async {
      await _joinMeeting();
      Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
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
              Center(child: UploadDialog(warning: 'Connecting to server'.tr()))
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
              'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/events')
          .child(passVariable)
          .update({
        'isStarted': 1,
      });
    }
  }

  _joinMeeting() async {
    _makeupdate();
    String serverUrl =
        serverText.text?.trim()?.isEmpty ?? "" ? null : serverText.text;

    try {
      var options = JitsiMeetingOptions()
        ..room = roomText.text
        ..serverURL = serverUrl
        ..subject = subjectText.text
        ..userDisplayName = nameText.text
        ..userEmail = emailText.text
        //..iosAppBarRGBAColor = iosAppBarRGBAColor.text
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;

      debugPrint("JitsiMeetingOptions: $options");
      await JitsiMeet.joinMeeting(options,
          listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
            debugPrint("${options.room} will join with message: $message");
          }, onConferenceJoined: ({message}) {
            debugPrint("${options.room} joined with message: $message");
          }, onConferenceTerminated: ({message}) {
            if (privilegelevel >= 2) {
              dbRef
                  .reference()
                  .child(
                      'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/events')
                  .child(passVariable)
                  .update({
                'isStarted': 0,
              });
            }
            debugPrint("${options.room} terminated with message: $message");
          }));
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  void _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
