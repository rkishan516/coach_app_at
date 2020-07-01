import 'dart:async';

import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:coach_app/GlobalFunction/SlideButton.dart';
import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/adminCorner/publicContentPage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class NoticeBoard extends StatefulWidget {
  @override
  _NoticeBoardState createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  TextEditingController _textController = TextEditingController();
  List<Messages> _allMessages = [];
  String _selfId = FireBaseAuth.instance.user.uid;
  final dbRef = FirebaseDatabase.instance;
  Query _query;
  int previlagelevel = FireBaseAuth.instance.previlagelevel;
  StreamSubscription<Event> _onDataAddedSubscription;
  StreamSubscription<Event> _onDataRemovedSubscription;
  TabController _controller;
  int items = 2;

  _buildMessage(Messages message, bool isMe) {
    final GestureDetector msg = GestureDetector(
        onLongPress: () async {
          if (previlagelevel == 4) {
            String res = await showDialog(
                context: context,
                builder: (context) => AreYouSure(
                      text: 'Are you sure, You want to delete ?'.tr(),
                    ));
            if (res == 'Yes') {
              _delFromDatabase(message.key);
              return;
            }
          }
        },
        child: Container(
          margin: isMe
              ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
              : EdgeInsets.only(top: 8.0, bottom: 8.0),
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: BoxDecoration(
            color: isMe ? Color.fromRGBO(237, 220, 173, 1) : Color(0xFFFFEFEE),
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0))
                : BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(message.textMsg,
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 5.0),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  message.time.split(' ')[0],
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 8.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ));
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
      ],
    );
  }

  _saveintoDatabase() async {
    String time = DateTime.now().toString().split(' ')[0] +
        " " +
        DateFormat('jms').format(new DateTime.now());
    print(time);
    await dbRef
        .reference()
        .child('institute/${FireBaseAuth.instance.instituteid}/notices')
        .push()
        .update(
            {'textMsg': _textController.text, 'time': time, 'selfId': _selfId});
  }

  _delFromDatabase(String key) async {
    await dbRef
        .reference()
        .child('institute/${FireBaseAuth.instance.instituteid}/notices/$key')
        .remove();
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...'.tr(),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              _saveintoDatabase();
              setState(() {
                _textController.text = "";
              });
            },
          ),
        ],
      ),
    );
  }

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  onEventAdded(Event event) {
    setState(() {
      _allMessages.add(Messages.fromSnapshot(event.snapshot));
    });
  }

  onEventRemoved(Event event) {
    print(_allMessages);
    var index;
    _allMessages.forEach((element) {
      if (element.key == event.snapshot.key) {
        index = _allMessages.indexOf(element);
        print(_allMessages[index]);
      }
    });
    setState(() {
      _allMessages.removeAt(index);
    });
  }

  @override
  void initState() {
    _controller = new TabController(length: items, vsync: this);
    super.initState();
    _query = dbRef
        .reference()
        .child('institute/${FireBaseAuth.instance.instituteid}/notices');
    _onDataAddedSubscription = _query.onChildAdded.listen(onEventAdded);
    _onDataRemovedSubscription = _query.onChildRemoved.listen(onEventRemoved);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin Corner".tr(),
        ),
        bottom: TabBar(
          controller: _controller,
          tabs: [
            Tab(child: Text("Notices")),
            Tab(child: Text('Public Content'))
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          GestureDetector(
            onTap: () => {FocusScope.of(context).unfocus()},
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          30.0,
                        ),
                        topRight: Radius.circular(
                          30.0,
                        ),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          30.0,
                        ),
                        topRight: Radius.circular(
                          30.0,
                        ),
                      ),
                      child: ListView.builder(
                        reverse: false,
                        controller: _scrollController,
                        padding: EdgeInsets.only(
                          top: 15.0,
                        ),
                        itemCount: _allMessages.length,
                        itemBuilder: (BuildContext context, int index) {
                          final message = _allMessages[index];
                          final bool isMe = message.uid == _selfId;
                          return _buildMessage(message, isMe);
                        },
                      ),
                    ),
                  ),
                ),
                previlagelevel < 4 || previlagelevel == 34
                    ? SizedBox(
                        height: 4.0,
                      )
                    : _buildMessageComposer()
              ],
            ),
          ),
          Container(
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
                if (FireBaseAuth.instance.previlagelevel == 4)
                  SlideButtonR(
                      text: 'Add Section',
                      onTap: () => addSection(),
                      width: 150,
                      height: 50),
                Expanded(
                  flex: 12,
                  child: StreamBuilder<Event>(
                    stream: FirebaseDatabase.instance
                        .reference()
                        .child(
                            'institute/${FireBaseAuth.instance.instituteid}/publicContent')
                        .onValue,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.snapshot.value == null) {
                          return Center(
                            child: Text('No content shared yet'),
                          );
                        }
                        Map<String, Section> sections = Map<String, Section>();
                        snapshot.data.snapshot.value.forEach((k, v) {
                          sections[k] = Section.fromJson(v);
                        });
                        return ListView.builder(
                          itemCount: sections?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  title: Text(
                                    '${sections[sections.keys.toList()[index]].name}',
                                    style: TextStyle(color: Color(0xffF36C24)),
                                  ),
                                  trailing: Icon(
                                    Icons.chevron_right,
                                    color: Color(0xffF36C24),
                                  ),
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                      return PublicContentPage(title: sections[sections.keys.toList()[index]].name, reference: FirebaseDatabase.instance
                        .reference()
                        .child(
                            'institute/${FireBaseAuth.instance.instituteid}/publicContent/${sections.keys.toList()[index]}'));
                                    }));
                                  },
                                  onLongPress: () => addSection(
                                    name:
                                        sections[sections.keys.toList()[index]]
                                            .name,
                                    id: sections.keys.toList()[index],
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
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  addSection({String id = '', String name = ''}) {
    TextEditingController nameTextEditingController = TextEditingController()
      ..text = name;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Container(
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
                      TextField(
                        controller: nameTextEditingController,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                          hintText: 'Section Name',
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
                      (id == '')
                          ? Container()
                          : FlatButton(
                              onPressed: () async {
                                String res = await showDialog(
                                    context: context,
                                    builder: (context) => AreYouSure());
                                if (res != 'Yes') {
                                  return;
                                }
                                FirebaseDatabase.instance
                                    .reference()
                                    .child(
                                        'institute/${FireBaseAuth.instance.instituteid}/publicContent/$id')
                                    .remove();
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Remove'.tr(),
                              ),
                            ),
                      FlatButton(
                        onPressed: () {
                          if (nameTextEditingController.text == '') {
                            Alert.instance
                                .alert(context, 'Please Enter the Name');
                            return;
                          }

                          if (id == '') {
                            FirebaseDatabase.instance
                                .reference()
                                .child(
                                    'institute/${FireBaseAuth.instance.instituteid}/publicContent')
                                .push()
                                .update(Section(
                                        name: nameTextEditingController.text)
                                    .toJson());
                          } else {
                            FirebaseDatabase.instance
                                .reference()
                                .child(
                                    'institute/${FireBaseAuth.instance.instituteid}/publicContent/$id')
                                .update(Section(
                                        name: nameTextEditingController.text)
                                    .toJson());
                          }

                          Navigator.of(context).pop();
                        },
                        child: Text('Add Section'),
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
}