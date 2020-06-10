import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/YT_player/pdf_player.dart';
import 'package:coach_app/YT_player/quiz_player.dart';
import 'package:coach_app/YT_player/yt_player.dart';
import 'package:coach_app/noInternet/XD_Nointernet.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';

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
          return Scaffold(
            drawer: getDrawer(context),
            appBar: getAppBar(context),
            body: Container(
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
                              bool isEnabled = true;
                              if (chapter
                                      .content[
                                          chapter.content.keys.toList()[index]]
                                      .kind ==
                                  'Quiz') {
                                isEnabled = false;
                                DateTime endTime = chapter
                                    .content[
                                        chapter.content.keys.toList()[index]]
                                    .quizModel
                                    .startTime
                                    .add(chapter
                                        .content[chapter.content.keys
                                            .toList()[index]]
                                        .quizModel
                                        .testTime);
                                if (DateTime.now().isAfter(chapter
                                        .content[chapter.content.keys
                                            .toList()[index]]
                                        .quizModel
                                        .startTime) &&
                                    DateTime.now().isBefore(endTime)) {
                                  isEnabled = true;
                                }
                              }
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor:
                                          isEnabled ? Color(0xffF36C24) : null,
                                      child: Icon(
                                        chapter
                                                    .content[chapter
                                                        .content.keys
                                                        .toList()[index]]
                                                    .kind ==
                                                'Youtube Video'
                                            ? Icons.videocam
                                            : chapter
                                                        .content[chapter
                                                            .content.keys
                                                            .toList()[index]]
                                                        .kind ==
                                                    'PDF'
                                                ? Icons.library_books
                                                : Icons.question_answer,
                                        color: Colors.white,
                                      ),
                                    ),
                                    enabled: isEnabled,
                                    title: Text(
                                      '${chapter.content[chapter.content.keys.toList()[index]].title}',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    trailing: Icon(
                                      Icons.chevron_right,
                                      color: Colors.blue,
                                    ),
                                    onTap: () {
                                      if (chapter
                                              .content[chapter.content.keys
                                                  .toList()[index]]
                                              .kind ==
                                          'Youtube Video') {
                                        Navigator.of(context).push(
                                          CupertinoPageRoute(
                                            builder: (context) => YTPlayer(
                                                reference: widget.reference.child(
                                                    'content/${chapter.content.keys.toList()[index]}'),
                                                link: chapter
                                                    .content[chapter
                                                        .content.keys
                                                        .toList()[index]]
                                                    .ylink),
                                          ),
                                        );
                                      } else if (chapter
                                              .content[chapter.content.keys
                                                  .toList()[index]]
                                              .kind ==
                                          'PDF') {
                                        Navigator.of(context).push(
                                          CupertinoPageRoute(
                                            builder: (context) => PDFPlayer(
                                              link: chapter
                                                  .content[chapter.content.keys
                                                      .toList()[index]]
                                                  .link,
                                            ),
                                          ),
                                        );
                                      } else if (chapter
                                              .content[chapter.content.keys
                                                  .toList()[index]]
                                              .kind ==
                                          'Quiz') {
                                        if(snapshot.data.snapshot.value['content'][chapter.content.keys.toList()[index]]['quizModel']['result'][FireBaseAuth.instance.user.uid] != null){
                                          Alert.instance.alert(context, 'You have already submitted the quiz'.tr());
                                          return;
                                        }
                                        DateTime endTime = chapter
                                            .content[chapter.content.keys
                                                .toList()[index]]
                                            .quizModel
                                            .startTime
                                            .add(chapter
                                                .content[chapter.content.keys
                                                    .toList()[index]]
                                                .quizModel
                                                .testTime);
                                        if (!DateTime.now().isAfter(chapter
                                                .content[chapter.content.keys
                                                    .toList()[index]]
                                                .quizModel
                                                .startTime) ||
                                            !DateTime.now().isBefore(endTime)) {
                                          return;
                                        }
                                        Navigator.of(context).push(
                                          CupertinoPageRoute(
                                            builder: (context) => Quiz(
                                              reference: widget.reference.child(
                                                  'content/${chapter.content.keys.toList()[index]}'),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
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
          return XD_Nointernet();
        }
      },
    );
  }
}
