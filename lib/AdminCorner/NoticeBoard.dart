import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'Messages.dart';


class NoticeBoard extends StatefulWidget {
  @override
  _NoticeBoardState createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _textController = TextEditingController();
  List<Messages> _allMessages = [];
  String _selfId = "uid";
  final dbRef = FirebaseDatabase.instance;
  Query _query;
  int previlagelevel=4;
  StreamSubscription<Event> _onDataAddedSubscription;
  StreamSubscription<Event> _onDataRemovedSubscription;
  
  Future showErrorDialog(BuildContext context) {
    
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(title: Text("Are You Sure ?"), actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop("Yes");
                },
                elevation: 5.0,
                child: Text("Yes"),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop("No");
                },
                elevation: 5.0,
                child: Text("No"),
              )
            ]);
          });
    }

    
  _buildMessage(Messages message, bool isMe) {
    final GestureDetector msg = GestureDetector(
      
      onLongPress: (){
        showErrorDialog(context).then((onValue) {
           if(onValue=='Yes'){
             _delFromDatabase(message.key);
           }
        });
        
      },
     child:Container(
      
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
        // IconButton(
        //     icon: Icon(Icons.favorite_border),
        //     color: Colors.black,
        //     iconSize: 30.0,
        //     onPressed: () {})
      ],
    );
  }

  _saveintoDatabase() async {
    String time= DateTime.now().toString().split(' ')[0]+" "+DateFormat('jms').format(new DateTime.now());
    print(time);
    await dbRef
        .reference()
        .child('institute/0/notices')
        .push()
        .update({
         'textMsg': _textController.text,
         'time': time,
         'selfId': _selfId});
  }

  _delFromDatabase(String key) async{
    await dbRef.reference().child('institute/0/notices/$key').remove();
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _textController,
               keyboardType: TextInputType.multiline,
               maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
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
                _textController.text="";
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
        index= _allMessages.indexOf(element);
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
    _query = dbRef.reference().child('institute/0/notices');
    _onDataAddedSubscription = _query.onChildAdded.listen(onEventAdded);
    _onDataRemovedSubscription = _query.onChildRemoved.listen(onEventRemoved);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    return Scaffold(
      appBar: AppBar(
        title: Text("Admin's Corner"),
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
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                    child: ListView.builder(
                        reverse: false,
                        controller: _scrollController,
                        padding: EdgeInsets.only(top: 15.0),
                        itemCount: _allMessages.length,
                        itemBuilder: (BuildContext context, int index) {
                          final message = _allMessages[index];
                          final bool isMe = message.uid == _selfId;
                          print('/////////////$isMe////////////////');
                          return _buildMessage(message, isMe);
                        }),
                  )),
            ),
            previlagelevel<4? SizedBox(height: 4.0,):_buildMessageComposer()
          ],
        ),
      ),
    );
  }
}
