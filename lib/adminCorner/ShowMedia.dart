import 'package:coach_app/Models/model.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class ShowMedia extends StatefulWidget {
  final String url;
  final String type;
  final List<Messages> allMessages;
  ShowMedia({
    @required this.url,
    @required this.type,
    @required this.allMessages,
  });
  @override
  _ShowMediaState createState() => _ShowMediaState();
}

class _ShowMediaState extends State<ShowMedia> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;
  PageController scrollController;
  List<Messages> _allMessages = [];
  int currentpage, previouspage;
  double _scale = 1.0, _previousscale = 1.0;

  void dispose() {
    print("in dispose");
    if (_videoPlayerController != null && _chewieController != null) {
      _videoPlayerController?.dispose();

      _chewieController?.dispose();
    }
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    widget.allMessages.forEach((element) {
      _allMessages.add(element);
    });
    _allMessages.removeWhere((element) {
      if (element.type == "Text" || element.type == null)
        return true;
      else
        return false;
    });
    currentpage = _allMessages.indexWhere(
        (element) => element.textMsg.split(":_:_:")[0] == widget.url);
    previouspage = currentpage;
    scrollController = new PageController(initialPage: currentpage);

    if (widget.type == "video") {
      _videoPlayerController = VideoPlayerController.network(widget.url);
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
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Media"),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 24.0, 8.0),
              child: Text("${currentpage + 1}/${_allMessages.length}"),
            ),
          )
        ],
      ),
      body: PageView.builder(
          onPageChanged: (number) {
            print("--------------");
            print(number);
            print(_allMessages[number].type);
            print("--------------");

            if (_allMessages[previouspage].type == "video") {
              print("disposing");
              _videoPlayerController?.dispose();
              _chewieController?.dispose();
              _videoPlayerController = null;
              _chewieController = null;
            }
            if (_allMessages[number].type == "video") {
              print("in video");
              setState(() {
                currentpage = number;
                previouspage = currentpage;
                _videoPlayerController = VideoPlayerController.network(
                    _allMessages[number].textMsg.split(":_:_:")[0]);
                _chewieController = ChewieController(
                  videoPlayerController: _videoPlayerController,
                  aspectRatio: 1,
                  autoPlay: false,
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
              });
            } else {
              setState(() {
                currentpage = number;
                previouspage = currentpage;
              });
            }
          },
          physics: new BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: scrollController,
          itemCount: _allMessages.length,
          itemBuilder: (contex, index) {
            return Center(
                child: _allMessages[index].type == "image"
                    ? GestureDetector(
                        onScaleStart: (ScaleStartDetails details) {
                          setState(() {
                            _previousscale = _scale;
                          });
                        },
                        onScaleUpdate: (ScaleUpdateDetails details) {
                          setState(() {
                            _scale = _previousscale * details.scale;
                          });
                        },
                        onScaleEnd: (ScaleEndDetails details) {
                          setState(() {
                            _previousscale = 1.0;
                            _scale = 1.0;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 20.0, bottom: 16.0),
                          child: Transform(
                            alignment: FractionalOffset.center,
                            transform: Matrix4.diagonal3(
                                Vector3(_scale, _scale, _scale)),
                            child: FadeInImage(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              fit: BoxFit.contain,
                              image: NetworkImage(_allMessages[index]
                                  .textMsg
                                  .split(":_:_:")[0]),
                              placeholder: AssetImage('assets/blankimage.jpg'),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        padding: EdgeInsets.only(top: 20.0, bottom: 16.0),
                        child: Center(
                          child: _chewieController != null
                              ? Chewie(
                                  controller: _chewieController,
                                )
                              : CircularProgressIndicator(),
                        ),
                      ));
          }),
    );
  }
}
