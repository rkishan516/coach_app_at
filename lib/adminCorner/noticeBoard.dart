import 'dart:async';

import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:coach_app/Models/model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class NoticeBoard extends StatefulWidget {
  @override
  _NoticeBoardState createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _textController = TextEditingController();
  List<Messages> _allMessages = [];
  String _selfId = FireBaseAuth.instance.user.uid;
  final dbRef = FirebaseDatabase.instance;
  Query _query;
  int previlagelevel = FireBaseAuth.instance.previlagelevel;
  StreamSubscription<Event> _onDataAddedSubscription;
  StreamSubscription<Event> _onDataRemovedSubscription;

  _buildMessage(Messages message, bool isMe) {
    final GestureDetector msg = GestureDetector(
        onLongPress: () async {
          if (previlagelevel == 4) {
            String res = await showDialog(
                context: context, builder: (context) => AreYouSure());
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
              Text(
                message.time,
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5.0),
              Text(message.textMsg,
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600)),
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
        title: Text("Admin's Corner".tr()),
      ),
      body: GestureDetector(
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
    );
  }
}
