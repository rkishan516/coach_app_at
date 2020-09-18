import 'package:flutter/material.dart';
class ShowMedia extends StatefulWidget {
  final String imageurl;
  ShowMedia({this.imageurl});
  @override
  _ShowMediaState createState() => _ShowMediaState();
}

class _ShowMediaState extends State<ShowMedia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Media"),),
      body: Center(
        child: Container( 
                          padding: EdgeInsets.only(top: 20.0,bottom: 16.0),
                         
                          child: FadeInImage(
                            width: MediaQuery.of(context).size.width,
                               height: MediaQuery.of(context).size.height ,
                                      fit: BoxFit.contain,
                                      image: NetworkImage(widget.imageurl),
                                      placeholder:
                                          AssetImage('assets/blankimage.png'),
                                     
                                    ),
                        ),
      ),
    );
  }
}