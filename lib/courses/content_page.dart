import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/YT_player/pdf_player.dart';
import 'package:coach_app/YT_player/quiz_player.dart';
import 'package:coach_app/YT_player/yt_player.dart';
import 'package:coach_app/courses/FormGeneration/form_generator.dart';
import 'package:coach_app/noInternet/noInternet.dart';
import 'package:cross_connectivity/cross_connectivity.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:google_fonts/google_fonts.dart';
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
            return NoInternet();
          }
          return Scaffold(
            drawer: getDrawer(context),
            appBar: AppBar(
              title: Text(
                widget.title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.portLligatSans(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              elevation: 0.0,
              iconTheme: IconThemeData.fallback().copyWith(color: Colors.white),
            ),
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
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.orange, Colors.deepOrange])),
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
                                    backgroundColor: Colors.orange,
                                  ),
                                  title: Text(
                                    '${chapter.content[index].title}',
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                  trailing: Icon(
                                    Icons.chevron_right,
                                    color: Colors.orange,
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
                                  onLongPress: () => addContent(
                                      context, widget.reference, index,
                                      title: chapter.content[index].title,
                                      link: chapter.content[index].kind ==
                                              'Youtube Video'
                                          ? chapter.content[index].ylink
                                          : chapter.content[index].kind == 'PDF'
                                              ? chapter.content[index].link
                                              : '',
                                      quizModel:
                                          chapter.content[index].quizModel,
                                      description:
                                          chapter.content[index].description,
                                      type: chapter.content[index].kind),
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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.orange, Colors.deepOrange])),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
              onPressed: () => addContent(context, widget.reference, length),
            ),
          );
        } else {
          return NoInternet();
        }
      },
    );
  }

  addContent(BuildContext context, DatabaseReference reference, int length,
      {String title = '',
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
        length: length,
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
  final int length;
  final String type;
  final QuizModel quizModel;
  ContentUploadDialog({
    @required this.title,
    @required this.description,
    @required this.reference,
    @required this.link,
    @required this.length,
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
                      Text(
                        'Title'.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: titleTextEditingController,
                        decoration: InputDecoration(
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
                      Text(
                        'Description'.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: descriptionTextEditingController,
                        decoration: InputDecoration(
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
                            Text(
                              type == 'Youtube Video'
                                  ? 'Youtube Video Link'.tr()
                                  : 'Google Drive Link'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: linkTextEditingController,
                              decoration: InputDecoration(
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
                      (widget.title == '')
                          ? Container()
                          : FlatButton(
                              onPressed: () {
                                widget.reference
                                    .child('content/${widget.length}')
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
                            }else{
                              content.quizModel = cal;
                            }
                          }

                          widget.reference
                              .child('content/${widget.length}')
                              .set(content.toJson());
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
