import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/GlobalFunction/SlideButton.dart';
import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/YT_player/pdf_player.dart';
import 'package:coach_app/YT_player/yt_player.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PublicContentPage extends StatefulWidget {
  final DatabaseReference reference;
  final String title;
  PublicContentPage({required this.title, required this.reference});
  @override
  _PublicContentPageState createState() => _PublicContentPageState();
}

class _PublicContentPageState extends State<PublicContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: StreamBuilder<DatabaseEvent>(
                stream: widget.reference.onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Section section =
                        Section.fromJson(snapshot.data?.snapshot.value as Map);
                    final length = section.content?.length ?? 0;
                    if (length == 0) {
                      return Center(
                        child: Text('No Content Yet'),
                      );
                    }
                    return ListView.builder(
                      itemCount: length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          '${section.content![section.content!.keys.toList()[index]]?.title}',
                                          style: TextStyle(
                                              color: Color(0xffF36C24)),
                                        ),
                                      ),
                                    ),
                                    if (section
                                            .content![section.content!.keys
                                                .toList()[index]]!
                                            .kind ==
                                        'Youtube Video')
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          YoutubePlayer.getThumbnail(
                                            videoId:
                                                YoutubePlayer.convertUrlToId(
                                              section
                                                  .content![section
                                                      .content!.keys
                                                      .toList()[index]]!
                                                  .ylink,
                                            )!,
                                          ),
                                          height: 120,
                                        ),
                                      )
                                    else
                                      CircleAvatar(
                                          child: Icon(
                                            Icons.library_books,
                                            color: Colors.white,
                                          ),
                                          backgroundColor: Color(0xffF36C24)),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${section.content![section.content!.keys.toList()[index]]!.description}',
                                        style:
                                            TextStyle(color: Color(0xffF36C24)),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      child: Text(
                                          '${section.content![section.content!.keys.toList()[index]]!.time.split(" ")[0].split("-").reversed.join("-")}'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            if (section
                                    .content![
                                        section.content!.keys.toList()[index]]!
                                    .kind ==
                                'Youtube Video') {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => YTPlayer(
                                      reference: widget.reference.child(
                                          'content/${section.content!.keys.toList()[index]}'),
                                      link: section
                                          .content![section.content!.keys
                                              .toList()[index]]!
                                          .ylink),
                                ),
                              );
                            } else if (section
                                    .content![
                                        section.content!.keys.toList()[index]]!
                                    .kind ==
                                'PDF') {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (context) => PDFPlayer(
                                    link: section
                                        .content![section.content!.keys
                                            .toList()[index]]!
                                        .link,
                                  ),
                                ),
                              );
                            }
                          },
                          onLongPress: () => addContent(
                            context,
                            widget.reference,
                            key: section.content!.keys.toList()[index],
                            title: section
                                .content![
                                    section.content!.keys.toList()[index]]!
                                .title,
                            link: section
                                        .content![section.content!.keys
                                            .toList()[index]]!
                                        .kind ==
                                    'Youtube Video'
                                ? section
                                    .content![
                                        section.content!.keys.toList()[index]]!
                                    .ylink
                                : section
                                            .content![section.content!.keys
                                                .toList()[index]]!
                                            .kind ==
                                        'PDF'
                                    ? section
                                        .content![section.content!.keys
                                            .toList()[index]]!
                                        .link
                                    : '',
                            description: section
                                .content![
                                    section.content!.keys.toList()[index]]!
                                .description,
                            type: section
                                .content![
                                    section.content!.keys.toList()[index]]!
                                .kind,
                            time: section
                                .content![
                                    section.content!.keys.toList()[index]]!
                                .time,
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
      floatingActionButton: (AppwriteAuth.instance.previlagelevel == 4)
          ? SlideButtonR(
              text: 'Add Content'.tr(),
              onTap: () => addContent(context, widget.reference),
              width: 150,
              height: 50,
            )
          : null,
    );
  }

  addContent(BuildContext context, DatabaseReference reference,
      {String? key,
      String title = '',
      String description = '',
      String link = '',
      String time = '',
      String type = 'Youtube Video'}) async {
    await showDialog(
      context: context,
      builder: (context) => ContentUploadDialog(
        type: type,
        link: link,
        title: title,
        description: description,
        reference: reference,
        keyC: key,
        time: time,
      ),
    );
  }
}

class ContentUploadDialog extends StatefulWidget {
  final String title;
  final String description;
  final String link;
  final String time;
  final DatabaseReference reference;
  final String? keyC;
  final String type;
  ContentUploadDialog({
    required this.title,
    required this.description,
    required this.reference,
    required this.time,
    required this.link,
    required this.keyC,
    required this.type,
  });
  @override
  _ContentUploadDialogState createState() => _ContentUploadDialogState();
}

class _ContentUploadDialogState extends State<ContentUploadDialog> {
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  TextEditingController linkTextEditingController = TextEditingController();
  late String type;
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
                        items: ['Youtube Video', 'PDF']
                            .map(
                              (e) => DropdownMenuItem(
                                child: Text(e.tr()),
                                value: e,
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
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
                          : MaterialButton(
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
                      MaterialButton(
                        onPressed: () async {
                          Content content = Content(
                            kind: type,
                            title: titleTextEditingController.text,
                            time: ((widget.time == '')
                                ? DateTime.now().toString()
                                : widget.time),
                            description: descriptionTextEditingController.text,
                            ylink: type == 'Youtube Video'
                                ? linkTextEditingController.text
                                : '',
                            link: type == 'PDF'
                                ? linkTextEditingController.text
                                : '',
                            quizModel: null,
                          );

                          Navigator.of(context).pop();

                          if (widget.keyC == null) {
                            widget.reference
                                .child('content/')
                                .push()
                                .update(content.toJson());
                          } else {
                            widget.reference
                                .child('content/${widget.keyC}')
                                .update(content.toJson());
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
