import 'package:coach_app/Models/model.dart';
import 'package:coach_app/YT_player/yt_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentPage extends StatefulWidget {
  final Chapters chapters;
  ContentPage({@required this.chapters});
  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 20),
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
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff519ddb), Color(0xff54d179)])),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: Text(
                    widget.chapters.name,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.portLligatSans(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 12,
                child: ListView.builder(
                  itemCount: widget.chapters.content.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.videocam,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.blue,
                        ),
                        title: Text(
                          '${widget.chapters.content[index].title}',
                          style: TextStyle(color: Colors.blue),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Colors.blue,
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => YTPlayer(id: widget.chapters.content[index].yid),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
