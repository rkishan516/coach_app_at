import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class VideoConferencing extends StatefulWidget {
  final String? passVariable;
  final String? room, eventkey;
  final String? subject;
  final int? privilegelevel;
  final int? hostprevilagelevel;
  final String? hostuid;
  final bool? fromcourse;
  VideoConferencing({
    this.passVariable,
    this.room,
    this.eventkey,
    this.subject,
    this.privilegelevel,
    this.hostuid,
    this.hostprevilagelevel,
    this.fromcourse,
  });
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
        initialUrlRequest: URLRequest(
          url: Uri.parse(_joinMeeting()),
          headers: {
            "previlagelevel": AppwriteAuth.instance.previlagelevel.toString(),
            "photourl": '',
            "title": 'GuruCoolSession' + widget.eventkey.toString(),
            "name": AppwriteAuth.instance.user!.name ?? '',
            "eventkey": widget.eventkey.toString(),
            "email": AppwriteAuth.instance.user!.email ?? '',
            "hostPrevilage": widget.hostprevilagelevel.toString(),
            "ishost":
                (widget.hostuid == AppwriteAuth.instance.user!.$id).toString()
          },
        ),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            mediaPlaybackRequiresUserGesture: false,
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
    if (widget.fromcourse ?? true) {
      if (AppwriteAuth.instance.previlagelevel >= 2) {
        FirebaseDatabase.instance
            .ref()
            .child(
                'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/events/${widget.passVariable}')
            .update({
          'isStarted': 1,
        });
      }
    } else {
      FirebaseDatabase.instance
          .ref()
          .child(
              'institute/${AppwriteAuth.instance.instituteid}/events/${widget.passVariable}')
          .update({
        'isStarted': 1,
      });
    }
  }

  String _launchURL() {
    bool _ishost = false;
    if (widget.hostuid == AppwriteAuth.instance.user!.$id) _ishost = true;
    var midurl = "https://guru-cool-test.web.app?previlagelevel=" +
        AppwriteAuth.instance.previlagelevel.toString() +
        "&photourl=" +
        '' +
        "&title=" +
        'GuruCoolSession' +
        widget.eventkey.toString() +
        "&name=" +
        AppwriteAuth.instance.user!.name +
        "&eventkey=" +
        widget.eventkey.toString() +
        "&email=" +
        AppwriteAuth.instance.user!.email +
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
