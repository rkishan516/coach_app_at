import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class ShowMedia extends StatefulWidget {
  final String url;
  final String type;
  ShowMedia({@required this.url,@required this.type});
  @override
  _ShowMediaState createState() => _ShowMediaState();
}

class _ShowMediaState extends State<ShowMedia> {
  VideoPlayerController _videoPlayerController;
   ChewieController _chewieController;
   void dispose() {
     if(widget.type=="video"){
    _videoPlayerController.dispose();

    _chewieController.dispose();
     }
    super.dispose();
  }
  @override
  void initState() {
    if(widget.type=="video"){
    _videoPlayerController= VideoPlayerController.network(widget.url);
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
      appBar: AppBar(title: Text("Media"),),
      body: Center(
        child: widget.type=="image"? Container( 
                          padding: EdgeInsets.only(top: 20.0,bottom: 16.0),
                         
                          child: FadeInImage(
                            width: MediaQuery.of(context).size.width,
                               height: MediaQuery.of(context).size.height ,
                                      fit: BoxFit.contain,
                                      image: NetworkImage(widget.url),
                                      placeholder:
                                          AssetImage('assets/blankimage.png'),
                                     
                                    ),
                        ):
                Container( 
              height: MediaQuery.of(context).size.height*0.5,
                              padding: EdgeInsets.only(top: 20.0,bottom: 16.0),
                             
                              child: Center(
                                child: Chewie(
                                  controller: _chewieController,
                                
                                          ),
                              ),
                            )        
      ),
    );
  }
}