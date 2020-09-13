import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text('GuruCool Meet'),
        automaticallyImplyLeading: false,
      ),
      body: InAppWebView(
        initialUrl: _joinMeeting(),
        initialHeaders: {
          "previlagelevel": FireBaseAuth.instance.previlagelevel.toString(),
          "photourl": FireBaseAuth.instance.user.photoUrl,
          "title": 'GuruCoolSession' + widget.eventkey.toString(),
          "displayName": FireBaseAuth.instance.user.displayName,
          "eventkey": widget.eventkey.toString(),
          "email": FireBaseAuth.instance.user.email,
          "hostPrevilage": widget.hostprevilagelevel.toString(),
          "ishost":
              (widget.hostuid == FireBaseAuth.instance.user.uid).toString()
        },
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            mediaPlaybackRequiresUserGesture: false,
            debuggingEnabled: true,
          ),
        ),
        androidOnPermissionRequest: (InAppWebViewController controller,
            String origin, List<String> resources) async {
          return PermissionRequestResponse(
              resources: resources,
              action: PermissionRequestResponseAction.GRANT);
        },
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
    var midurl = "https://guru-cool-test.web.app?previlagelevel=" +
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
    return midurl;
  }

  String _joinMeeting() {
    _makeupdate();
    return _launchURL();
  }
}
