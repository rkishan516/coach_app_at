import 'package:coach_app/Drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YTPlayer extends StatefulWidget {
  final String link;
  YTPlayer({@required this.link});
  @override
  _YTPlayerState createState() => _YTPlayerState();
}

class _YTPlayerState extends State<YTPlayer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  YoutubePlayerController _controller;

  YoutubeMetaData _videoMetaData;

  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.link),
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _videoMetaData = YoutubeMetaData();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            'Video Player',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              topActions: <Widget>[
               
              ],
              onReady: () {
                _isPlayerReady = true;
              },
              onEnded: (data) {
                Navigator.of(context).pop();
              },
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _space,
                  _text('Title', _videoMetaData.title),
                  //TODO Description from streamBuilder
                ],
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      return Container();
      // Navigator.of(context).pop();
    }
  }

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value ?? '',
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _space => SizedBox(height: 10);
}
