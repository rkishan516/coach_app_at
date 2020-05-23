import 'package:coach_app/Models/model.dart';
import 'package:coach_app/YT_player/pdf_player.dart';
import 'package:coach_app/YT_player/quiz_player.dart';
import 'package:coach_app/YT_player/yt_player.dart';
import 'package:coach_app/courses/FormGeneration/form_generator.dart';
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
    return Scaffold(
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
                colors: [Color(0xff519ddb), Color(0xff54d179)])),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: Text(
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
            ),
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
                                chapter.content[index].kind == 'Youtube Video'
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
                                        id: chapter.content[index].yid),
                                  ),
                                );
                              } else if (chapter.content[index].kind == 'PDF') {
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
                                      reference: widget.reference.child('content/$index'),
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
                                    ? chapter.content[index].yid
                                    : chapter.content[index].kind == 'PDF'
                                        ? chapter.content[index].link
                                        : '',
                                description: chapter.content[index].description,
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
      floatingActionButton: FloatingActionButton(
        child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff519ddb), Color(0xff54d179)])),
            child: Icon(Icons.add)),
        onPressed: () => addContent(context, widget.reference, length),
      ),
    );
  }

  addContent(BuildContext context, DatabaseReference reference, int length,
      {String title = '',
      String description = '',
      String link = '',
      String type = 'Youtube Video'}) async {
    await showDialog(
      context: context,
      builder: (context) => ContentUploadDialog(
        type: type,
        link: link,
        title: title,
        description: description,
        reference: reference,
        length: length,
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
  ContentUploadDialog(
      {@required this.title,
      @required this.description,
      @required this.reference,
      @required this.link,
      @required this.length,
      @required this.type});
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
                        'Type',
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
                                child: Text(e),
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
                        'Title',
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
                        'Description',
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
                                  ? 'Youtube Video Id'
                                  : 'Google Drive Link',
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
                  child: FlatButton(
                    onPressed: () async {
                      Content content = Content()
                        ..kind = type
                        ..title = titleTextEditingController.text
                        ..description = descriptionTextEditingController.text;
                      Navigator.of(context).pop();
                      type == 'Youtube Video'
                          ? content.yid = linkTextEditingController.text
                          : type == 'PDF'
                              ? content.link = linkTextEditingController.text
                              : content.quizModel =
                                  await Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => FormGenerator(
                                      title: titleTextEditingController.text,
                                      description:
                                          descriptionTextEditingController.text,
                                    ),
                                  ),
                                );

                      widget.reference
                          .child('content/${widget.length}')
                          .set(content.toJson());
                    },
                    color: Colors.white,
                    child: Text(
                      'Add Content',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
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
