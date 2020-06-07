import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/courses/content_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:google_fonts/google_fonts.dart';

class ChapterPage extends StatefulWidget {
  final DatabaseReference reference;
  final String title;
  ChapterPage({
    @required this.title,
    @required this.reference,
  });
  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  int length;
  @override
  Widget build(BuildContext context) {
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
                      print(snapshot.data.snapshot.value);
                      Subjects subjects =
                          Subjects.fromJson(snapshot.data.snapshot.value);
                      length = subjects.chapters?.length ?? 0;
                      return ListView.builder(
                        itemCount: length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                title: Text(
                                  '${subjects.chapters[subjects.chapters.keys.toList()[index]].name}',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: Colors.blue,
                                ),
                                onTap: () => Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => ContentPage(
                                      title: subjects.chapters[subjects.chapters.keys.toList()[index]].name,
                                      reference: widget.reference
                                          .child('chapters/${subjects.chapters.keys.toList()[index]}'),
                                    ),
                                  ),
                                ),
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
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
