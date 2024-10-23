import 'dart:async';
import 'dart:io';

import 'package:appwrite/models.dart' show User;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Chat/full_screen_image.dart';
import 'package:coach_app/Chat/models/message.dart';
import 'package:coach_app/Chat/models/message_ui.dart';
import 'package:coach_app/Chat/models/video_player.dart';
import 'package:coach_app/Profile/TeacherProfile.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String photoUrl;
  final String receiverUid;
  final String role;
  ChatScreen({
    required this.name,
    required this.photoUrl,
    required this.receiverUid,
    required this.role,
  });

  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Message? _message;
  ScrollController _scrollController = new ScrollController();
  var _formKey = GlobalKey<FormState>();
  var map = Map<String, dynamic>();
  String? _senderuid;
  String? receiverPhotoUrl, senderPhotoUrl, receiverName, senderName;
  late TextEditingController _messageController;

  void tolast() //to call list the other way
  {
    _scrollController.animateTo(
      0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 1),
    );
  }

  @override
  void initState() {
    super.initState();

    _messageController = TextEditingController();
    getUID().then((user) {
      setState(() {
        _senderuid = user!.$id;
        print("sender uid : $_senderuid");
        getSenderPhotoUrl(_senderuid!).then((snapshot) {
          setState(() {
            senderPhotoUrl = snapshot['photoUrl'];
            senderName = snapshot['name'];
          });
        });
        getReceiverPhotoUrl(widget.receiverUid).then((snapshot) {
          setState(() {
            receiverPhotoUrl = snapshot['photoUrl'];
            receiverName = snapshot['name'];
          });
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void addMessageToDb(Message message) async {
    print("Message : ${message.message}");
    map = message.toMap();

    print("Map : ${map}");
    var _collectionReference = FirebaseFirestore.instance
        .collection("messages")
        .doc(message.senderUid)
        .collection(widget.receiverUid);

    _collectionReference.add(map).whenComplete(() {
      print("Messages added to db");
    });

    _collectionReference = FirebaseFirestore.instance
        .collection("messages")
        .doc(widget.receiverUid)
        .collection(message.senderUid);

    _collectionReference.add(map).whenComplete(() {
      print("Messages added to db");
    });

    _messageController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: new AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Chat Section', style: TextStyle(color: Colors.white)),
          backgroundColor: Color.fromARGB(255, 242, 108, 37),
        ),
        body: Form(
          key: _formKey,
          child: _senderuid == null
              ? Container(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  color: Color.fromARGB(255, 230, 230, 230),
                  child: Column(
                    ///////Correct this///////
                    /////////////////////////
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        color: Colors.grey[200],
                        child: Row(
                          children: [
                            SizedBox(width: SizeConfig.b * 2.54),
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/f.jpg'),
                            ),
                            SizedBox(width: SizeConfig.b * 2.54),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.name,
                                    style: new TextStyle(
                                        color:
                                            Color.fromARGB(255, 242, 108, 37),
                                        fontSize: SizeConfig.b * 4.7,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    widget.role,
                                    style: new TextStyle(
                                        color: Colors.black,
                                        fontSize: SizeConfig.b * 3.05),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.v * 1.3,
                                  )
                                ]),
                          ],
                        ),
                      ),
                      //new Flexible(child: new Container()),
                      ChatMessagesListWidget(),
                      SizedBox(
                        height: SizeConfig.v * 2.035,
                      ),
                      ChatInputWidget(),
                    ],
                  ),
                ),
        ));
  }

  Widget ChatInputWidget() {
    return Container(
      alignment: Alignment.bottomRight,
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.b * 1.27, vertical: SizeConfig.v * 1.08),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Container(
              child: TextFormField(
                validator: (String? input) {
                  if (input == null || input.isEmpty) {
                    return "Please enter message";
                  }
                  return null;
                },
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  errorStyle: TextStyle(color: Colors.transparent),
                  contentPadding: EdgeInsets.all(SizeConfig.b * 2.54),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 230, 230, 230)),
                    borderRadius: BorderRadius.circular(SizeConfig.b * 6.36),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.grey[300],
                    ),
                    onPressed: () {
                      tolast();
                      if (_formKey.currentState!.validate()) {
                        sendMessage();
                      }
                    },
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                onFieldSubmitted: (value) {
                  _messageController.text = value;
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.b * 1.27),
            child: new IconButton(
                icon: new Icon(
                  Icons.photo,
                  color: Color.fromARGB(220, 255, 255, 255),
                ),
                onPressed: () {
                  pickImage();
                }),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.b * 1.27),
            child: new IconButton(
                icon: new Icon(
                  Icons.description,
                  color: Color.fromARGB(220, 255, 255, 255),
                ),
                onPressed: () {
                  pickVideo();
                }),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }

  Future<String> pickImage() async {
    var selectedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (selectedImage == null) {
      return "";
    }

    var compressedFile = await FlutterImageCompress.compressAndGetFile(
        selectedImage.path, selectedImage.path,
        quality: 50, minWidth: 720, minHeight: 1280);

    final _storageReference = FirebaseStorage.instance
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch}');
    final storageUploadTask =
        _storageReference.putFile(File(compressedFile!.path));
    var url = await (await storageUploadTask).ref.getDownloadURL();

    print("URL: $url");
    uploadImageToDb(url);
    return url;
  }

  Future<String> pickVideo() async {
    final videoFile = await FilePicker.platform.pickFiles(type: FileType.video);
    if (videoFile == null || videoFile.count == 0) return '';

    final _storageReference = FirebaseStorage.instance
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch}');

    final storageUploadTask =
        _storageReference.putFile(File(videoFile.files.first.path!));
    var url = await (await storageUploadTask).ref.getDownloadURL();

    print("Video URL : $url");
    uploadVideoToDB(url);
    return url;
  }

  Future<String> pickDoc() async {
    final docFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
          'doc',
          'docx',
          'xlsx',
          'pptx',
          'ppt',
          'txt'
        ]);
    if (docFile == null || docFile.count == 0) return '';

    final _storageReference = FirebaseStorage.instance
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch}');

    final storageUploadTask = _storageReference.putFile(
      File(docFile.files.first.path!),
    );
    var url = await (await storageUploadTask).ref.getDownloadURL();

    print("Document URl : $url");
    uploadDoctoDb(url);
    return url;
  }

  void uploadDoctoDb(String downloadUrl) {
    print("Inside Upload Doc");

    _message = Message.withoutMessage(
        message: "Doc Title",
        receiverUid: widget.receiverUid,
        senderUid: _senderuid!,
        mediaUrl: downloadUrl,
        timestamp: FieldValue.serverTimestamp(),
        type: 'doc');

    var map = _message!.toMap();

    var _collectionReference = FirebaseFirestore.instance
        .collection("messages")
        .doc(_message!.senderUid)
        .collection(widget.receiverUid);

    _collectionReference.add(map).whenComplete(() {
      print("Messages added to db");
    });

    _collectionReference = FirebaseFirestore.instance
        .collection("messages")
        .doc(widget.receiverUid)
        .collection(_message!.senderUid);

    _collectionReference.add(map).whenComplete(() {
      print("Messages added to db");
    });
  }

  void uploadVideoToDB(String downloadUrl) {
    print("Inside Upload Video");

    _message = Message.withoutMessage(
        message: "Dummy Video Title",
        receiverUid: widget.receiverUid,
        senderUid: _senderuid!,
        mediaUrl: downloadUrl,
        timestamp: FieldValue.serverTimestamp(),
        type: 'video');

    var map = _message!.toMap();

    print("Map : ${map}");
    var _collectionReference = FirebaseFirestore.instance
        .collection("messages")
        .doc(_message!.senderUid)
        .collection(widget.receiverUid);

    _collectionReference.add(map).whenComplete(() {
      print("Messages added to db");
    });

    _collectionReference = FirebaseFirestore.instance
        .collection("messages")
        .doc(widget.receiverUid)
        .collection(_message!.senderUid);

    _collectionReference.add(map).whenComplete(() {
      print("Messages added to db");
    });
  }

  void uploadImageToDb(String downloadUrl) {
    _message = Message.withoutMessage(
        receiverUid: widget.receiverUid,
        senderUid: _senderuid!,
        mediaUrl: downloadUrl,
        timestamp: FieldValue.serverTimestamp(),
        type: 'image');
    var map = _message!.toMap();

    print("Map : ${map}");
    var _collectionReference = FirebaseFirestore.instance
        .collection("messages")
        .doc(_message!.senderUid)
        .collection(widget.receiverUid);

    _collectionReference.add(map).whenComplete(() {
      print("Messages added to db");
    });

    _collectionReference = FirebaseFirestore.instance
        .collection("messages")
        .doc(widget.receiverUid)
        .collection(_message!.senderUid);

    _collectionReference.add(map).whenComplete(() {
      print("Messages added to db");
    });
  }

  void sendMessage() async {
    print("Inside send message");
    var text = _messageController.text;
    print(text);
    _message = Message(
        receiverUid: widget.receiverUid,
        senderUid: _senderuid!,
        message: text,
        timestamp: FieldValue.serverTimestamp(),
        type: 'text');
    print(
        "receiverUid: ${widget.receiverUid} , senderUid : ${_senderuid} , message: ${text}");
    print("timestamp: ${DateTime.now().millisecond}, type: text");
    addMessageToDb(_message!);
  }

  Future<User?> getUID() async {
    return AppwriteAuth.instance.user;
  }

  Future<DocumentSnapshot> getSenderPhotoUrl(String uid) {
    var senderDocumentSnapshot =
        FirebaseFirestore.instance.collection('users').doc(uid).get();
    return senderDocumentSnapshot;
  }

  Future<DocumentSnapshot> getReceiverPhotoUrl(String uid) {
    var receiverDocumentSnapshot =
        FirebaseFirestore.instance.collection('users').doc(uid).get();
    return receiverDocumentSnapshot;
  }

  Widget ChatMessagesListWidget() {
    print("SENDERUID : $_senderuid");
    return Flexible(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .doc(_senderuid)
            .collection(widget.receiverUid)
            .orderBy('timestamp', descending: false) //to be reviewed
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            int rev = snapshot.data!.docs.length - 1;
            return ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(SizeConfig.b * 2.54),
              reverse: true, //reviewed
              itemBuilder: (context, index) =>
                  chatMessageItem(snapshot.data!.docs[rev - index]),
              itemCount: snapshot.data!.docs.length,
            );
          }
        },
      ),
    );
  }

  Widget chatMessageItem(DocumentSnapshot documentSnapshot) {
    return buildChatLayout(documentSnapshot);
  }

  Widget buildChatLayout(DocumentSnapshot snapshot) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(SizeConfig.b * 1.05),
          child: Row(
            mainAxisAlignment: snapshot['senderUid'] == _senderuid
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: <Widget>[
              snapshot['senderUid'] == _senderuid
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        snapshot['type'] == 'text'
                            ? new Align(
                                alignment: Alignment.topRight,
                                child: CustomPaint(
                                    painter: ChatBubble(
                                        color:
                                            Color.fromARGB(255, 242, 108, 37),
                                        alignment: Alignment.topRight),
                                    child: Container(
                                        margin: EdgeInsets.fromLTRB(
                                            SizeConfig.b * 3.82,
                                            SizeConfig.v * 1.36,
                                            SizeConfig.b * 5.09,
                                            SizeConfig.v * 1.36),
                                        constraints: BoxConstraints(
                                            minWidth: 0,
                                            maxWidth: SizeConfig.b * 55),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                snapshot['message'],
                                                maxLines: null,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: SizeConfig.b * 3.82,
                                                ),
                                              ),
                                              Text(
                                                giveTime(snapshot['timestamp']),
                                                style: TextStyle(
                                                    fontSize:
                                                        SizeConfig.b * 2.7,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ]))))
                            : SizedBox(),
                        snapshot['type'] == 'image'
                            ? InkWell(
                                onTap: (() {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => FullScreenImage(
                                                photoUrl: snapshot['mediaUrl'],
                                              )));
                                }),
                                child: Hero(
                                  tag: snapshot['mediaUrl'],
                                  child: FadeInImage(
                                    image: NetworkImage(snapshot['mediaUrl']),
                                    placeholder:
                                        AssetImage('assets/blankimage.png'),
                                    width: SizeConfig.b * 50.9,
                                    height: SizeConfig.v * 27.1,
                                  ),
                                ),
                              )
                            : SizedBox(),
                        snapshot['type'] == 'video'
                            ? InkWell(
                                onTap: () {
                                  print("Video Opened");

                                  Navigator.of(context).push(
                                      new MaterialPageRoute(builder: (context) {
                                    return new ChewieDemo(
                                      dataSource: snapshot['mediaUrl'],
                                      title: snapshot['message'],
                                    );
                                  }));
                                },
                                child: new Align(
                                    alignment: Alignment.topLeft,
                                    child: CustomPaint(
                                        painter: ChatBubble(
                                            color: Color.fromARGB(
                                                255, 242, 108, 37),
                                            alignment: Alignment.topRight),
                                        child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                SizeConfig.b * 3.82,
                                                SizeConfig.v * 1.36,
                                                SizeConfig.b * 5.09,
                                                SizeConfig.v * 1.36),
                                            constraints: BoxConstraints(
                                                minWidth: 0,
                                                maxWidth: SizeConfig.b * 55),
                                            child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Image(
                                                    image: AssetImage(
                                                        'assets/film.png'),
                                                    width: SizeConfig.b * 20,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(snapshot['message']),
                                                      Text(
                                                        giveTime(snapshot[
                                                            'timestamp']),
                                                        style: TextStyle(
                                                            fontSize:
                                                                SizeConfig.b *
                                                                    2.7,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  )
                                                ])))),
                              )
                            : SizedBox(),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.b * 0.764),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        snapshot['type'] == 'text'
                            ? new Align(
                                alignment: Alignment.topRight,
                                child: CustomPaint(
                                    painter: ChatBubble(
                                        color: Colors.white,
                                        alignment: Alignment.topLeft),
                                    child: Container(
                                        margin: EdgeInsets.fromLTRB(
                                            SizeConfig.b * 3.82,
                                            SizeConfig.v * 1.36,
                                            SizeConfig.b * 5.09,
                                            SizeConfig.v * 1.36),
                                        constraints: BoxConstraints(
                                            minWidth: 0,
                                            maxWidth: SizeConfig.b * 55),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                snapshot['message'],
                                                maxLines: null,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: SizeConfig.b * 3.82,
                                                ),
                                              ),
                                              Text(
                                                giveTime(snapshot['timestamp']),
                                                style: TextStyle(
                                                    fontSize:
                                                        SizeConfig.b * 2.7,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ]))))
                            : SizedBox(),
                        snapshot['type'] == 'image'
                            ? InkWell(
                                onTap: (() {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => FullScreenImage(
                                                photoUrl: snapshot['mediaUrl'],
                                              )));
                                }),
                                child: Hero(
                                  tag: snapshot['mediaUrl'],
                                  child: FadeInImage(
                                    image: NetworkImage(snapshot['mediaUrl']),
                                    placeholder:
                                        AssetImage('assets/blankimage.png'),
                                    width: SizeConfig.b * 50.9,
                                    height: SizeConfig.b * 27.1,
                                  ),
                                ),
                              )
                            : SizedBox(),
                        snapshot['type'] == 'video'
                            ? InkWell(
                                onTap: () {
                                  print("Video Opened");
                                  Navigator.of(context).push(
                                      new MaterialPageRoute(builder: (context) {
                                    return new ChewieDemo(
                                      title: '',
                                      dataSource: snapshot['mediaUrl'],
                                    );
                                  }));
                                },
                                child: new Align(
                                    alignment: Alignment.topRight,
                                    child: CustomPaint(
                                        painter: ChatBubble(
                                            color: Color.fromARGB(
                                                255, 242, 108, 37),
                                            alignment: Alignment.topLeft),
                                        child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                SizeConfig.b * 3.82,
                                                SizeConfig.v * 1.36,
                                                SizeConfig.b * 5.09,
                                                SizeConfig.v * 1.36),
                                            constraints: BoxConstraints(
                                                minWidth: 0,
                                                maxWidth: SizeConfig.b * 55),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Image(
                                                    image: AssetImage(
                                                        'assets/film.png'),
                                                  ),
                                                  Text(
                                                    giveTime(
                                                        snapshot['timestamp']),
                                                    style: TextStyle(
                                                        fontSize:
                                                            SizeConfig.b * 2.7,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )
                                                ])))),
                              )
                            : SizedBox(),
                        Padding(
                          padding: EdgeInsets.all(SizeConfig.b * 0.764),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ],
    );
  }

  String giveTime(Timestamp timestamp) {
    DateTime d = timestamp.toDate();
    String time = d.toString().substring(11, 16);
    return time;
  }
}
