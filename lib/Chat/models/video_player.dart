import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieDemo extends StatefulWidget {
  final String dataSource;
  final String title;
  ChewieDemo({required this.dataSource, required this.title});
  //final String title;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState(dataSource, title);
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  final String dataSource;
  final String title;
  _ChewieDemoState(this.dataSource, this.title);

  //TargetPlatform _platform;
  late VideoPlayerController _videoPlayerController1;
  late VideoPlayerController _videoPlayerController2;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 =
        VideoPlayerController.networkUrl(Uri.parse(dataSource));
    _videoPlayerController2 =
        VideoPlayerController.networkUrl(Uri.parse(dataSource));
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 1,
      autoPlay: true,
      looping: false,
      cupertinoProgressColors: ChewieProgressColors(
        playedColor: Color.fromARGB(255, 242, 108, 37),
        handleColor: Color.fromARGB(255, 242, 108, 37),
        backgroundColor: Colors.grey,
        bufferedColor: Color.fromARGB(255, 242, 108, 37),
      ),
      materialProgressColors: ChewieProgressColors(
        playedColor: Color.fromARGB(255, 242, 108, 37),
        handleColor: Color.fromARGB(255, 242, 108, 37),
        backgroundColor: Colors.grey,
        bufferedColor: Color.fromARGB(255, 242, 108, 37),
      ),
      placeholder: Container(
        color: Colors.grey,
      ),
      autoInitialize: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        platform: TargetPlatform.iOS,
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Color.fromARGB(255, 242, 108, 37),
          title: Text("Media"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(title,
                style: TextStyle(
                    color: Color.fromARGB(255, 242, 108, 37),
                    fontSize: 26)), //for title of the video
            Chewie(controller: _chewieController),
            Row(children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      _chewieController.dispose();
                      _videoPlayerController2.pause();
                      _videoPlayerController2.seekTo(Duration(seconds: 0));
                      _chewieController = ChewieController(
                        videoPlayerController: _videoPlayerController1,
                        aspectRatio: 3 / 2,
                        autoPlay: false,
                        looping: true,
                      );
                    });
                  },
                  child: Text(""),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
