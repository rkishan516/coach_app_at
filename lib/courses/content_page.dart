import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/GlobalFunction/SlideButton.dart';
import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/QuizResponse/quiz_display.dart';
import 'package:coach_app/YT_player/pdf_player.dart';
import 'package:coach_app/YT_player/quiz_player.dart';
import 'package:coach_app/YT_player/yt_player.dart';
import 'package:coach_app/courses/FormGeneration/form_generator.dart';
import 'package:coach_app/noInternet/XD_Nointernet.dart';
import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
    return StreamBuilder<ConnectivityStatus>(
      stream: Connectivity().onConnectivityChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          if (snapshot.data == ConnectivityStatus.none) {
            return XD_Nointernet();
          }
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
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: ListTile(
                                    leading: CircleAvatar(
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
                                      backgroundColor: Color(0xffF36C24),
                                    ),
                                    title: Text(
                                      '${chapter.content[chapter.content.keys.toList()[index]].title}',
                                      style: TextStyle(color: Color(0xffF36C24)),
                                    ),
                                    trailing: Icon(
                                      Icons.chevron_right,
                                      color: Color(0xffF36C24),
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
                                        if (FireBaseAuth
                                                .instance.previlagelevel >
                                            1) {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      QuizModalResponse(
                                                        databaseReference: widget
                                                            .reference
                                                            .child(
                                                                'content/${chapter.content.keys.toList()[index]}'),
                                                      )));
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
                                    onLongPress: () => addContent(
                                        context, widget.reference,
                                        key: chapter.content.keys
                                            .toList()[index],
                                        title: chapter
                                            .content[chapter.content.keys
                                                .toList()[index]]
                                            .title,
                                        link: chapter.content[chapter.content.keys.toList()[index]].kind ==
                                                'Youtube Video'
                                            ? chapter
                                                .content[chapter.content.keys
                                                    .toList()[index]]
                                                .ylink
                                            : chapter.content[chapter.content.keys.toList()[index]].kind == 'PDF'
                                                ? chapter.content[chapter.content.keys.toList()[index]].link
                                                : '',
                                        quizModel: chapter.content[chapter.content.keys.toList()[index]].quizModel,
                                        description: chapter.content[chapter.content.keys.toList()[index]].description,
                                        type: chapter.content[chapter.content.keys.toList()[index]].kind),
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
            floatingActionButton: SlideButtonR(
              text: 'Add Content'.tr(),
              onTap: () => addContent(context, widget.reference),
              width: 150,
              height: 50,
            ),
          );
        } else {
          return XD_Nointernet();
        }
      },
    );
  }

  addContent(BuildContext context, DatabaseReference reference,
      {String key,
      String title = '',
      String description = '',
      String link = '',
      String type = 'Youtube Video',
      QuizModel quizModel}) async {
    await showDialog(
      context: context,
      builder: (context) => ContentUploadDialog(
        type: type,
        link: link,
        title: title,
        description: description,
        reference: reference,
        keyC: key,
        quizModel: quizModel,
      ),
    );
  }
}

class ContentUploadDialog extends StatefulWidget {
  final String title;
  final String description;
  final String link;
  final DatabaseReference reference;
  final String keyC;
  final String type;
  final QuizModel quizModel;
  ContentUploadDialog({
    @required this.title,
    @required this.description,
    @required this.reference,
    @required this.link,
    @required this.keyC,
    @required this.type,
    @required this.quizModel,
  });
  @override
  _ContentUploadDialogState createState() => _ContentUploadDialogState();
}

class _ContentUploadDialogState extends State<ContentUploadDialog> {
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  TextEditingController linkTextEditingController = TextEditingController();
  String type;
  @override
  void initState() {
    type = widget.type;
    titleTextEditingController.text = widget.title;
    descriptionTextEditingController.text = widget.description;
    linkTextEditingController.text = widget.link;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(
              16.0,
            ),
            margin: EdgeInsets.only(top: 66.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Type'.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButton(
                        value: type,
                        elevation: 0,
                        isExpanded: true,
                        items: ['Youtube Video', 'Quiz', 'PDF']
                            .map(
                              (e) => DropdownMenuItem(
                                child: Text(e.tr()),
                                value: e,
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            type = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                        controller: titleTextEditingController,
                        decoration: InputDecoration(
                          hintText: 'Title'.tr(),
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                          border: InputBorder.none,
                          fillColor: Color(0xfff3f3f4),
                          filled: true,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                        controller: descriptionTextEditingController,
                        decoration: InputDecoration(
                          hintText: 'Description'.tr(),
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                          border: InputBorder.none,
                          fillColor: Color(0xfff3f3f4),
                          filled: true,
                        ),
                      )
                    ],
                  ),
                ),
                (type == 'Youtube Video' || type == 'PDF')
                    ? Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextField(
                              controller: linkTextEditingController,
                              decoration: InputDecoration(
                                hintText: type == 'Youtube Video'
                                    ? 'Youtube Video Link'.tr()
                                    : 'Google Drive Link'.tr(),
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                                border: InputBorder.none,
                                fillColor: Color(0xfff3f3f4),
                                filled: true,
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      (widget.keyC == null)
                          ? Container()
                          : FlatButton(
                              onPressed: () async {
                                String res = await showDialog(
                                    context: context,
                                    builder: (context) => AreYouSure());
                                if (res != 'Yes') {
                                  return;
                                }
                                widget.reference
                                    .child('content/${widget.keyC}')
                                    .remove();
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Remove'.tr(),
                              ),
                            ),
                      FlatButton(
                        onPressed: () async {
                          Content content = Content()
                            ..kind = type
                            ..title = titleTextEditingController.text
                            ..description =
                                descriptionTextEditingController.text;
                          Navigator.of(context).pop();
                          if (type == 'Youtube Video') {
                            content.ylink = linkTextEditingController.text;
                          } else if (type == 'PDF') {
                            content.link = linkTextEditingController.text;
                          } else {
                            var cal = await Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => FormGenerator(
                                  title: titleTextEditingController.text,
                                  description:
                                      descriptionTextEditingController.text,
                                  quizModel: widget.quizModel,
                                ),
                              ),
                            );
                            if (cal == null) {
                              content.quizModel = widget.quizModel;
                            } else {
                              content.quizModel = cal;
                            }
                          }
                          if (widget.keyC == null) {
                            widget.reference
                                .child('content/')
                                .push()
                                .set(content.toJson());
                          } else {
                            widget.reference
                                .child('content/${widget.keyC}')
                                .set(content.toJson());
                          }
                        },
                        color: Colors.white,
                        child: Text(
                          'Add Content'.tr(),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
