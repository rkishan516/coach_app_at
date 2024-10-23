import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/Models/model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YTPlayer extends StatefulWidget {
  final String link;
  final DatabaseReference reference;
  YTPlayer({required this.link, required this.reference});
  @override
  _YTPlayerState createState() => _YTPlayerState();
}

class _YTPlayerState extends State<YTPlayer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late YoutubePlayerController _controller;

  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.link) ?? '',
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
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {});
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
            'Video Player'.tr(),
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.deepOrangeAccent,
              onReady: () {
                _isPlayerReady = true;
              },
              onEnded: (data) {
                Navigator.of(context).pop();
              },
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: StreamBuilder<DatabaseEvent>(
                stream: widget.reference.onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Card(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (snapshot.data!.snapshot.value as Map)['title'],
                              style: TextStyle(fontSize: 32),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (snapshot.data!.snapshot.value
                                  as Map)['description'],
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return PlaceholderLines(
                      count: 3,
                      animate: true,
                    );
                  }
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: StreamBuilder<DatabaseEvent>(
                  stream: widget.reference.parent?.onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Map<String, Content> contents = Map<String, Content>();
                      (snapshot.data?.snapshot.value as Map)
                          .forEach((key, value) {
                        Content content = Content.fromJson(value);
                        if (content.kind == 'Youtube Video') {
                          contents[key] = content;
                        }
                      });
                      return Card(
                        child: ListView.builder(
                          itemCount: contents.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final content =
                                contents[contents.keys.elementAt(index)]!;
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  CupertinoPageRoute(
                                    builder: (context) => YTPlayer(
                                        reference: widget.reference.parent!.child(
                                            '/${contents.keys.toList()[index]}'),
                                        link: content.ylink),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20, top: 20),
                                child: Container(
                                  height: 80,
                                  child: Row(
                                    children: [
                                      Image.network(
                                        YoutubePlayer.getThumbnail(
                                          videoId: YoutubePlayer.convertUrlToId(
                                            content.ylink,
                                          )!,
                                        ),
                                        height: 120,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 18.0),
                                        child: Text(
                                          contents[contents.keys
                                                  .elementAt(index)]!
                                              .title,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return PlaceholderLines(
                        count: 3,
                        animate: true,
                      );
                    }
                  },
                ),
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
}
