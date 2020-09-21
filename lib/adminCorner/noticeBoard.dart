import 'dart:async';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/Models/random_string.dart';
import 'package:coach_app/adminCorner/BeforeImageLoading.dart';
import 'package:coach_app/adminCorner/BeforeVideoLoading.dart';
import 'package:coach_app/adminCorner/ShowMedia.dart';
import 'package:video_player/video_player.dart';
import 'package:coach_app/Chat/models/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:coach_app/Drawer/CountDot.dart';
import 'package:coach_app/GlobalFunction/SlideButton.dart';
import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/adminCorner/publicContentPage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:linkwell/linkwell.dart';
import 'package:file_picker/file_picker.dart';

class NoticeBoard extends StatefulWidget {
  final int totalNotice;
  final totalPublicContent;
  NoticeBoard({@required this.totalNotice, this.totalPublicContent});
  @override
  _NoticeBoardState createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  TextEditingController _textController = TextEditingController();
  List<Messages> _allMessages = [];
  bool _scrolleffect = true;
  String _selfId, type = "Text";
  final dbRef = FirebaseDatabase.instance;
  Query _query;
  Map<String, bool> _isDeleting = {};
  int previlagelevel = FireBaseAuth.instance.previlagelevel;
  TabController _controller;
  File imageFile;
  StorageReference _storageReference;
  int items = 2;
  Map<String, String> _months = {
    "01": "Jan",
    "02": "Feb",
    "03": "Mar",
    "04": "Apr",
    "05": "May",
    "06": "Jun",
    "07": "Jul",
    "08": "Aug",
    "09": "Sep",
    "10": "Oct",
    "11": "Nov",
    "12": "Dec"
  };
  // Map<String, VideoPlayerController> _videoPlayerController = {};
  // ChewieController _chewieController;
  Timer timer;

  Widget _child1(Messages message, bool isMe) {
    String splitDate = message.time.split(' ')[0];
    String noticeDate = splitDate.split("-")[2] +
        " " +
        _months[splitDate.split("-")[1]] +
        " " +
        splitDate.split("-")[0];

    return Expanded(
      flex: 2,
      child: Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        constraints: BoxConstraints.expand(),
        width: 30.0,
        child: RotatedBox(
          quarterTurns: isMe ? 1 : 3,
          child: Center(
              child: Text(
            noticeDate,
            style: TextStyle(color: Colors.white),
          )),
        ),
        decoration: BoxDecoration(
          color: Color(0xffF36C24),
        ),
      ),
    );
  }

  Widget _child2(Messages message, bool isMe) {
    // if (message.type == "video") {
    //   if (_videoPlayerController[message.key] == null){
    //     _videoPlayerController[message.key] =
    //         VideoPlayerController.network(message.textMsg);
    //   _chewieController = ChewieController(
    //     videoPlayerController: _videoPlayerController[message.key],
    //     aspectRatio: 1,
    //     autoPlay: false,
    //     looping: false,
    //     cupertinoProgressColors: ChewieProgressColors(
    //       playedColor: Color.fromARGB(255, 242, 108, 37),
    //       handleColor: Color.fromARGB(255, 242, 108, 37),
    //       backgroundColor: Colors.grey,
    //       bufferedColor: Color.fromARGB(255, 242, 108, 37),
    //     ),
    //     materialProgressColors: ChewieProgressColors(
    //       playedColor: Color.fromARGB(255, 242, 108, 37),
    //       handleColor: Color.fromARGB(255, 242, 108, 37),
    //       backgroundColor: Colors.grey,
    //       bufferedColor: Color.fromARGB(255, 242, 108, 37),
    //     ),
    //     placeholder: Container(
    //       color: Colors.grey,
    //     ),
    //     autoInitialize: true,
    //   );
    //   }
    // }

    return Expanded(
      flex: 13,
      child: Container(
        padding: EdgeInsets.only(left: 8.0, right: 8.0),
        width: MediaQuery.of(context).size.width * 0.6,
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.center,
          children: <Widget>[
            if (!isMe && FireBaseAuth.instance.previlagelevel != 4)
              Positioned(
                left: 8.0,
                top: 3.0,
                child: Text(
                  message.type != null
                      ? message.uid.split(":_:_:")[3]
                      : "Admin",
                  style: TextStyle(color: Color(0xffF36C24)),
                ),
              ),
            message.type == "image"
                ? Container(
                    padding: EdgeInsets.only(top: 20.0, bottom: 16.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(new MaterialPageRoute(builder: (context) {
                          return ShowMedia(
                            url: message.textMsg.split(":_:_:")[0],
                            type: message.type,
                          );
                        })).then((value) {
                          _scrolleffect = false;
                        });
                      },
                      child: Column(
                        children: [
                          FadeInImage(
                            height: 180.0,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            image:
                                NetworkImage(message.textMsg.split(":_:_:")[0]),
                            placeholder: AssetImage('assets/blankimage.png'),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                message.textMsg.split(":_:_:")[1] == "EmpText"
                                    ? ""
                                    : message.textMsg.split(":_:_:")[1],
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600)),
                          ),
                          SizedBox(
                              height:
                                  message.textMsg.split(":_:_:")[1] == "EmpText"
                                      ? 0.0
                                      : 4.0)
                        ],
                      ),
                    ),
                  )
                : message.type == "video"
                    ? InkWell(
                        child: Container(
                          padding: EdgeInsets.only(top: 20.0, bottom: 16.0),
                          child: Column(
                            children: [
                              FadeInImage(
                                height: 180.0,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                                image: AssetImage("assets/video_black.jpg"),
                                placeholder:
                                    AssetImage('assets/blankimage.png'),
                              ),
                              SizedBox(
                                height: 6.0,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    message.textMsg.split(":_:_:")[1] ==
                                            "EmpText"
                                        ? ""
                                        : message.textMsg.split(":_:_:")[1],
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600)),
                              ),
                              SizedBox(
                                  height: message.textMsg.split(":_:_:")[1] ==
                                          "EmpText"
                                      ? 0.0
                                      : 4.0)
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .push(new MaterialPageRoute(builder: (context) {
                            return ShowMedia(
                              url: message.textMsg.split(":_:_:")[0],
                              type: message.type,
                            );
                          }));
                        },
                      )
                    : LinkWell(message.textMsg,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600)),
            _isDeleting[message.key]
                ? Align(
                    alignment: isMe ? Alignment.topLeft : Alignment.topRight,
                    child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Color(0xffF36C24),
                          size: 30.0,
                        ),
                        onPressed: () async {
                          String res = await showDialog(
                              context: context,
                              builder: (context) => AreYouSure(
                                    text: 'Are you sure, You want to delete ?'
                                        .tr(),
                                  ));
                          if (res == 'Yes') {
                            _deleteNotice(message.key);

                            return;
                          }
                          setState(() {
                            _isDeleting[message.key] = false;
                          });
                        }),
                  )
                : Container(
                    width: 0.0,
                    height: 0.0,
                  ),
            SizedBox(height: 10.0),
            Align(
              alignment: isMe ? Alignment.bottomLeft : Alignment.bottomRight,
              child: Text(
                message.time.split(' ')[1].split(':')[0] +
                    ":" +
                    message.time.split(' ')[1].split(':')[1] +
                    " " +
                    message.time.split(' ')[2],
                style: TextStyle(
                    color: Color(0xffF36C24),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildMessage(Messages message, bool isMe) {
    final GestureDetector msg = GestureDetector(
        onLongPress: () async {
          if ((isMe && FireBaseAuth.instance.previlagelevel >= 3) ||
              FireBaseAuth.instance.previlagelevel == 4) {
            setState(() {
              _scrolleffect = false;
              if (!_isDeleting[message.key])
                _isDeleting[message.key] = true;
              else
                _isDeleting[message.key] = false;
            });

            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          }
        },
        child: Container(
          margin:
              EdgeInsets.only(top: 15.0, bottom: 15.0, left: 20.0, right: 20.0),
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isMe ? _child2(message, isMe) : _child1(message, isMe),
                isMe ? _child1(message, isMe) : _child2(message, isMe)
              ],
            ),
          ),
        ));

    return msg;
  }

  _createNotice(String url, String randomKey) async {
    String msg = _textController.text;
    if (url.toString() != "none") {
      msg = url;
    }

    String time = DateTime.now().toString().split(" ")[0] +
        " " +
        DateFormat('jms').format(new DateTime.now());
    if (type == "Text")
      await dbRef
          .reference()
          .child('institute/${FireBaseAuth.instance.instituteid}/notices')
          .push()
          .update(
              {'textMsg': msg, 'time': time, 'selfId': _selfId, 'type': type});
    else
      await dbRef
          .reference()
          .child(
              'institute/${FireBaseAuth.instance.instituteid}/notices/$randomKey')
          .update(
              {'textMsg': msg, 'time': time, 'selfId': _selfId, 'type': type});
  }

  _deleteNotice(String key) async {
    await dbRef
        .reference()
        .child('institute/${FireBaseAuth.instance.instituteid}/notices/$key')
        .remove();
    if (key.length == 7)
      await FirebaseStorage.instance
          .ref()
          .child('notices/${FireBaseAuth.instance.instituteid}/$key')
          .delete();
  }

  Future<String> pickVideo() async {
    File videoFile = await FilePicker.getFile(type: FileType.video);
    if (videoFile != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (contex) => BeforeVideoLoading(
                    videourl: videoFile,
                  ))).then((value) async {
        if (value != null) {
          String randomkey = randomNumeric(7);
          _storageReference = FirebaseStorage.instance
              .ref()
              .child('notices/${FireBaseAuth.instance.instituteid}/$randomkey');

          StorageUploadTask storageUploadTask =
              _storageReference.putFile(videoFile);
          String uploadString = 'Uploading';

          timer = Timer.periodic(Duration(seconds: 1), (timer) {
            if (uploadString.contains('...')) {
              uploadString = 'Uploading';
            } else {
              uploadString += '.';
            }
          });
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => StatefulBuilder(
              builder: (context, setState) =>
                  UploadDialog(warning: uploadString),
            ),
          );
          StorageTaskSnapshot snapshot = await storageUploadTask.onComplete;
          var url = await snapshot.ref.getDownloadURL();
          Navigator.of(context).pop();

          _createNotice(url + ":_:_:" + value, randomkey);
          return url + ":_:_:" + value;
        }
      });
    }
  }

  Future<String> pickImage() async {
    PickedFile selectedImage = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

    final filePath = selectedImage.path;
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var compressedFile = await FlutterImageCompress.compressAndGetFile(
      selectedImage?.path,
      outPath,
      quality: 50,
      minWidth: 720,
      minHeight: 1280,
    );

    imageFile = compressedFile;
    if (selectedImage != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (contex) => BeforeImageLoading(
                    imageurl: imageFile,
                  ))).then((value) async {
        if (value != null) {
          String randomkey = randomNumeric(7);
          _storageReference = FirebaseStorage.instance
              .ref()
              .child('notices/${FireBaseAuth.instance.instituteid}/$randomkey');
          StorageUploadTask storageUploadTask =
              _storageReference.putFile(imageFile);
          var url =
              await (await storageUploadTask.onComplete).ref.getDownloadURL();

          _createNotice(url + ":_:_:" + value, randomkey);

          return url + ":_:_:" + value;
        }
      });
    }
  }

  @override
  void dispose() {
    // _videoPlayerController.forEach((key, value) {
    //   value.dispose();
    // });

    // _chewieController.dispose();
    timer?.cancel();
    super.dispose();
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey.shade200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: TextField(
              style: TextStyle(
                fontSize: 18.0,
              ),
              autofocus: true,
              autocorrect: true,
              controller: _textController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: InputDecoration(
                suffixIcon: Container(
                  width: 100.0,
                  height: 100.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.image,
                          color: Colors.grey[400],
                        ),
                        onPressed: () {
                          type = "image";
                          pickImage();
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.play_circle_filled,
                          color: Colors.grey[400],
                        ),
                        onPressed: () {
                          type = "video";
                          pickVideo();
                        },
                      ),
                    ],
                  ),
                ),
                hintText: 'Type a message...'.tr(),
                fillColor: Colors.white,
                filled: true,
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 6.0, horizontal: 15.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(22.0)),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 35.0,
            alignment: Alignment.topRight,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              _createNotice("none", null);
              setState(() {
                type = "Text";
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

  onEventRemoved(Event event) {
    _scrolleffect = true;
    var index;
    _allMessages.forEach((element) {
      if (element.key == event.snapshot.key) {
        index = _allMessages.indexOf(element);
      }
    });
    setState(() {
      _allMessages.removeAt(index);
    });
  }

  bool _isshowableMsg(Messages _messages) {
    int _previlagelevel = FireBaseAuth.instance.previlagelevel;
    String _branch = FireBaseAuth.instance.branchid.toString();
    String _branchlist = FireBaseAuth.instance.branchList.toString();
    int _senderprevilagelevel = int.parse(_messages.uid.split(":_:_:")[0]);
    String _senderbranch = _messages.uid.split(":_:_:")[1];
    if (_senderprevilagelevel == 4) {
      return true;
    } else if (_senderprevilagelevel == 3) {
      if (_previlagelevel <= 3 && _branch == _senderbranch)
        return true;
      else if (_previlagelevel >= 4) return false;
    } else if (_senderprevilagelevel == 34) {
      if ((_previlagelevel <= 3 && _senderbranch.contains(_branch)) ||
          (_previlagelevel == 34 && _branchlist == _senderbranch))
        return true;
      else if (_previlagelevel == 4) return false;
    }
  }

  @override
  void initState() {
    _controller = new TabController(length: items, vsync: this);
    super.initState();
    if (FireBaseAuth.instance.previlagelevel == 34)
      _selfId = FireBaseAuth.instance.previlagelevel.toString() +
          ":_:_:" +
          FireBaseAuth.instance.branchList.toString() +
          ":_:_:" +
          FireBaseAuth.instance.user.uid +
          ":_:_:" +
          FireBaseAuth.instance.user.displayName;
    else if (FireBaseAuth.instance.previlagelevel == 4 ||
        FireBaseAuth.instance.previlagelevel == 3)
      _selfId = FireBaseAuth.instance.previlagelevel.toString() +
          ":_:_:" +
          FireBaseAuth.instance.branchid.toString() +
          ":_:_:" +
          FireBaseAuth.instance.user.uid +
          ":_:_:" +
          FireBaseAuth.instance.user.displayName;
    _query = dbRef
        .reference()
        .child('institute/${FireBaseAuth.instance.instituteid}/notices');
    _query.onChildAdded.listen((Event event) {
      Messages _messages = Messages.fromSnapshot(event.snapshot);
      bool _isMsgshow = false;
      if (_messages.type != null) {
        _isMsgshow = _isshowableMsg(_messages);
        if (_isMsgshow) {
          _allMessages.add(_messages);
          _isDeleting[_messages.key] = false;
        }
      }

      return setState(() {
        if (_messages.type == null) {
          _isDeleting[_messages.key] = false;
          _allMessages.add(_messages);
          _allMessages.sort((a, b) => a.changetime.compareTo(b.changetime));
        } else {
          if (_isMsgshow) {
            _scrolleffect = true;
            _allMessages.sort((a, b) => a.changetime.compareTo(b.changetime));
          }
        }
      });
    });
    _query.onChildRemoved.listen(onEventRemoved);
  }

  @override
  Widget build(BuildContext context) {
    if (_scrolleffect)
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin Corner".tr(),
        ),
        bottom: TabBar(
          controller: _controller,
          tabs: [
            Tab(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Notices"),
                SizedBox(
                  width: 8.0,
                ),
                CountDot(count: widget.totalNotice)
              ],
            )),
            Tab(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Public Content'),
                SizedBox(
                  width: 8.0,
                ),
                CountDot(count: widget.totalPublicContent)
              ],
            ))
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
                      color: Colors.grey.shade200,
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
                          bool isMe;
                          if (message.type == null) {
                            isMe = false;
                          } else {
                            isMe = message.uid.split(":_:_:")[2] ==
                                FireBaseAuth.instance.user.uid;
                          }
                          if (FireBaseAuth.instance.previlagelevel <= 2 ||
                              FireBaseAuth.instance.previlagelevel == 4)
                            isMe = false;

                          return _buildMessage(message, isMe);
                        },
                      ),
                    ),
                  ),
                ),
                if (previlagelevel >= 3) _buildMessageComposer(),
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
                        List<bool> _showCountDot = List(sections?.length);
                        for (int i = 0; i < _showCountDot.length; i++) {
                          _showCountDot[i] = false;
                        }

                        return ListView.builder(
                          itemCount: sections?.length,
                          itemBuilder: (BuildContext context, int index) {
                            int _totalContent =
                                sections[sections.keys.toList()[index]]
                                        ?.content
                                        ?.length ??
                                    0;
                            int _duptotalContent = _totalContent;
                            int _prevtotalContent = FireBaseAuth.instance.prefs
                                    .getInt(
                                        "${sections[sections.keys.toList()[index]].name}") ??
                                0;
                            if (_prevtotalContent < _totalContent) {
                              _showCountDot[index] = true;

                              _totalContent = _totalContent - _prevtotalContent;
                            } else {
                              FireBaseAuth.instance.prefs.setInt(
                                  "${sections[sections.keys.toList()[index]].name}",
                                  _duptotalContent);
                            }
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
                                  trailing: Container(
                                    height: 40,
                                    width: 80,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (FireBaseAuth
                                                    .instance.previlagelevel !=
                                                4 &&
                                            _showCountDot[index])
                                          CountDot(count: _totalContent),
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
                                    FireBaseAuth.instance.prefs.setInt(
                                        "${sections[sections.keys.toList()[index]].name}",
                                        _duptotalContent);

                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return PublicContentPage(
                                          title: sections[
                                                  sections.keys.toList()[index]]
                                              .name,
                                          reference: FirebaseDatabase.instance
                                              .reference()
                                              .child(
                                                  'institute/${FireBaseAuth.instance.instituteid}/publicContent/${sections.keys.toList()[index]}'));
                                    })).then((value) {
                                      setState(() {
                                        _showCountDot[index] = false;
                                      });
                                    });
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
