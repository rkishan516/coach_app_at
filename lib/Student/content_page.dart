import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/YT_player/pdf_player.dart';
import 'package:coach_app/YT_player/quiz_player.dart';
import 'package:coach_app/YT_player/yt_player.dart';
import 'package:coach_app/noInternet/noInternet.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentPage extends StatefulWidget {
  final DatabaseReference reference;
  final String title;
  ContentPage({@required this.title, @required this.reference});
  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  int length;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          if (snapshot.data == ConnectivityResult.none) {
            return NoInternet();
          }
          return Scaffold(
            drawer: getDrawer(context),
            appBar: AppBar(
              elevation: 0.0,
              title: Text(
                widget.title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.portLligatSans(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height / 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
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
                  colors: [
                    Colors.orange,
                    Colors.deepOrange,
                  ],
                ),
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 12,
                    child: StreamBuilder<Event>(
                      stream: widget.reference.onValue,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Chapters chapter =
                              Chapters.fromJson(snapshot.data.snapshot.value);
                          length = chapter.content?.length ?? 0;
                          return ListView.builder(
                            itemCount: length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Icon(
                                      chapter.content[index].kind ==
                                              'Youtube Video'
                                          ? Icons.videocam
                                          : chapter.content[index].kind == 'PDF'
                                              ? Icons.library_books
                                              : Icons.question_answer,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Text(
                                    '${chapter.content[index].title}',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  trailing: Icon(
                                    Icons.chevron_right,
                                    color: Colors.blue,
                                  ),
                                  onTap: () {
                                    if (chapter.content[index].kind ==
                                        'Youtube Video') {
                                      Navigator.of(context).push(
                                        CupertinoPageRoute(
                                          builder: (context) => YTPlayer(
                                              link:
                                                  chapter.content[index].ylink),
                                        ),
                                      );
                                    } else if (chapter.content[index].kind ==
                                        'PDF') {
                                      Navigator.of(context).push(
                                        CupertinoPageRoute(
                                          builder: (context) => PDFPlayer(
                                            link: chapter.content[index].link,
                                          ),
                                        ),
                                      );
                                    } else if (chapter.content[index].kind ==
                                        'Quiz') {
                                      Navigator.of(context).push(
                                        CupertinoPageRoute(
                                          builder: (context) => Quiz(
                                            reference: widget.reference
                                                .child('content/$index'),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('${snapshot.error}'),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: 3,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: ListTile(
                                  title: PlaceholderLines(
                                    count: 1,
                                    animate: true,
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return NoInternet();
        }
      },
    );
  }
}
