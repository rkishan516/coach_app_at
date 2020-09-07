import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Drawer/CountDot.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Student/content_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ChapterPage extends StatefulWidget {
  final DatabaseReference reference;
  final String title;
  final String passKey;
  ChapterPage(
      {@required this.title, @required this.reference, @required this.passKey});
  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  int length;
  List _list;

  @override
  void initState() {
    super.initState();
  }

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
              flex: 1,
              child: Center(
                child: Text(
                  'Chapters'.tr(),
                  style: TextStyle(color: Color(0xffF36C24)),
                ),
              ),
            ),
            Expanded(
              flex: 12,
              child: StreamBuilder<Event>(
                  stream: widget.reference.onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Subjects subjects =
                          Subjects.fromJson(snapshot.data.snapshot.value);
                      var keys;
                      if (subjects.chapters != null) {
                        keys = subjects.chapters.keys.toList()
                          ..sort((a, b) => subjects.chapters[a].name
                              .compareTo(subjects.chapters[b].name));
                      }
                      length = subjects.chapters?.length ?? 0;
                      List<bool> _showCountDot = List(length);
                      for (int i = 0; i < _showCountDot.length; i++) {
                        _showCountDot[i] = false;
                      }

                      return ListView.builder(
                        itemCount: length,
                        itemBuilder: (BuildContext context, int index) {
                          String searchkey = widget.passKey +
                              "__" +
                              '${subjects.chapters[keys.toList()[index]].name}';
                          _list = FireBaseAuth.instance.prefs
                              .getKeys()
                              .where((element) => element.startsWith(searchkey))
                              .toList();

                          int _totalContent = subjects
                                  .chapters[keys.toList()[index]]
                                  .content
                                  ?.length ??
                              0;
                          int _prevtotalContent = _list.length ?? _totalContent;
                          if (_prevtotalContent <= _totalContent) {
                            _showCountDot[index] = true;
                          }

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                  title: Text(
                                    '${subjects.chapters[keys.toList()[index]].name}',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  trailing: Container(
                                    height: 40,
                                    width: 80,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CountDot(
                                            count: _totalContent -
                                                        _prevtotalContent <=
                                                    0
                                                ? 0
                                                : _totalContent -
                                                    _prevtotalContent),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Icon(
                                          Icons.chevron_right,
                                          color: Color(0xffF36C24),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    return Navigator.of(context)
                                        .push(
                                      CupertinoPageRoute(
                                        builder: (context) => ContentPage(
                                            title: subjects
                                                .chapters[keys.toList()[index]]
                                                .name,
                                            reference: widget.reference.child(
                                              'chapters/${keys.toList()[index]}',
                                            ),
                                            passKey: searchkey),
                                      ),
                                    )
                                        .then((value) {
                                      setState(() {});
                                    });
                                  }),
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
