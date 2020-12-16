import 'package:chewie/chewie.dart';
import 'package:coach_app/Utils/Colors.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class BeforeVideoLoading extends StatefulWidget {
  final videourl;
  BeforeVideoLoading({this.videourl});

  @override
  _BeforeVideoLoadingState createState() => _BeforeVideoLoadingState();
}

class _BeforeVideoLoadingState extends State<BeforeVideoLoading> {
  VideoPlayerController _videoPlayerController;
  TextEditingController _texController = TextEditingController();
  ChewieController _chewieController;
  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.file(widget.videourl);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
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

    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();

    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Caption"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 10,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              padding: EdgeInsets.only(top: 20.0, bottom: 16.0),
              child: Center(
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              color: GuruCoolLightColor.backgroundShade,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                      autofocus: false,
                      autocorrect: true,
                      controller: _texController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: 'Add a caption...'.tr(),
                        fillColor: GuruCoolLightColor.whiteColor,
                        filled: true,
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(22.0)),
                          borderSide: BorderSide(
                            color: GuruCoolLightColor.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    iconSize: 35.0,
                    alignment: Alignment.topRight,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).pop(_texController.text == ""
                          ? "EmpText"
                          : _texController.text);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
