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
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: widget.title,
                    style: GoogleFonts.portLligatSans(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
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
                      print(snapshot.data.snapshot.value);
                      Subjects subjects =
                          Subjects.fromJson(snapshot.data.snapshot.value);
                      length = subjects.chapters?.length ?? 0;
                      return ListView.builder(
                        itemCount: length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                '${subjects.chapters[index].name}',
                                style: TextStyle(color: Colors.blue),
                              ),
                              trailing: Icon(
                                Icons.chevron_right,
                                color: Colors.blue,
                              ),
                              onTap: () => Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => ContentPage(
                                    title: subjects.chapters[index].name,
                                    reference: widget.reference
                                        .child('chapters/$index'),
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
        onPressed: () => addChapter(context, widget.reference, length),
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
                    Text(
                      'Chapter Name'.tr(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: nameTextEditingController,
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
                      'Chapter Description'.tr(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    (name == '')
                        ? Container()
                        : FlatButton(
                            onPressed: () {
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
