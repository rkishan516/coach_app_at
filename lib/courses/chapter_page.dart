import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/Events/Calender.dart';
import 'package:coach_app/GlobalFunction/SlideButton.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/courses/content_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_placeholder_textlines/flutter_placeholder_textlines.dart';
import 'package:easy_localization/easy_localization.dart';

class ChapterPage extends StatefulWidget {
  final DatabaseReference reference;
  final String title;
  final String courseId;
  ChapterPage({
    @required this.title,
    @required this.reference,
    @required this.courseId,
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
                                '${subjects.chapters[index].name}',
                                style: TextStyle(color: Colors.orange),
                              ),
                              trailing: Icon(
                                Icons.chevron_right,
                                color: Colors.orange,
                              ),
                              onTap: () => Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => ContentPage(
                                    title: subjects.chapters[index].name,
                                    reference:
                                        widget.reference.child('chapters/$index'),
                                  ),
                                ),
                              ),
                              onLongPress: () => addChapter(
                                  context, widget.reference, index,
                                  name: subjects.chapters[index].name,
                                  description:
                                      subjects.chapters[index].description,
                                  content: subjects.chapters[index].content),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SlideButton(
              text: 'Live Session',
              onTap: () => Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => Calender(
                    courseId: widget.courseId,
                    subjectName: widget.title,
                  ),
                ),
              ),
              width: 150,
              height: 50,
              icon: Icon(Icons.add_to_queue),
            ),
            SlideButtonR(
                text: 'Add Chapter',
                onTap: () => addChapter(context, widget.reference, length),
                width: 150,
                height: 50),
          ],
        ),
      ),
    );
  }
}

addChapter(BuildContext context, DatabaseReference reference, int length,
    {String name = '', String description = '', List<Content> content}) {
  TextEditingController nameTextEditingController = TextEditingController()
    ..text = name;
  TextEditingController descriptionTextEditingController =
      TextEditingController()..text = description;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width / 2.5,
          padding: EdgeInsets.only(
            top: 16.0,
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
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
                    TextField(
                      controller: nameTextEditingController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        hintText: 'Chapter Name'.tr(),
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
                        hintText: 'Chapter Description'.tr(),
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
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    (name == '')
                        ? Container()
                        : FlatButton(
                            onPressed: () async {
                              String res = await showDialog(
                                  context: context,
                                  builder: (context) => AreYouSure());
                              if (res != 'Yes') {
                                return;
                              }
                              reference.child('chapters/$length').remove();
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Remove'.tr(),
                            ),
                          ),
                    FlatButton(
                      onPressed: () {
                        if (nameTextEditingController.text != '' &&
                            descriptionTextEditingController.text != '') {
                          Chapters chapter = Chapters(
                              name: nameTextEditingController.text,
                              description:
                                  descriptionTextEditingController.text,
                              content: content);
                          reference
                              .child('chapters/$length')
                              .set(chapter.toJson());
                        }
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Add Chapter'.tr(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
