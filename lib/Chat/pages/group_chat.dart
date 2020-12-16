import 'dart:io';
import 'package:coach_app/Chat/models/item_class.dart';
import 'package:coach_app/Chat/models/message_ui.dart';
import 'package:coach_app/Chat/full_screen_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:coach_app/Chat/models/video_player.dart';
import 'package:coach_app/Chat/models/group_message.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double b;
  static double v;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    b = screenWidth / 100;
    v = screenHeight / 100;
  }
}

class GroupChatScreen extends StatefulWidget {
  final String name;
  final String photoUrl;
  final String gid;
  final CurUser currentUser;
  GroupChatScreen({this.name, this.photoUrl, this.gid, this.currentUser});

  _GroupChatScreenState createState() =>
      _GroupChatScreenState(name, photoUrl, gid, currentUser);
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  String groupname, groupphotoUrl, gid;
  CurUser currentUser;
  _GroupChatScreenState(
      this.groupname, this.groupphotoUrl, this.gid, this.currentUser);

  GroupMessage _message;
  ScrollController _scrollController = new ScrollController();
  var _formKey = GlobalKey<FormState>();
  var map = Map<String, dynamic>();
  CollectionReference _collectionReference;
  // DocumentReference _receiverDocumentReference;
  // DocumentReference _senderDocumentReference;
  // DocumentReference _documentReference;
  DocumentSnapshot documentSnapshot;
  bool _autoValidate = false;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _senderuid;
  var listItem;
  String receiverPhotoUrl, senderPhotoUrl, receiverName, senderName;
  StreamSubscription<DocumentSnapshot> subscription;
  File imagefile;
  StorageReference _storageReference;
  TextEditingController _messageController;
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
        _senderuid = user.uid;
        print("sender uid : $_senderuid");
        /* getReceiverPhotoUrl(widget.receiverUid).then((snapshot) {
          setState(() {
            receiverPhotoUrl = snapshot['photoUrl'];
            receiverName = snapshot['name'];
          });
        }); */
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  void addMessageToDb(GroupMessage message) async {
    print("Message : ${message.message}");
    map = message.toMap();

    print("Map : $map");
    _collectionReference = Firestore.instance
        .collection("groupMessages")
        .document(currentUser.code)
        .collection(gid);

    _collectionReference.add(map).whenComplete(() {
      print("Messages added to db");
    });

    /* _collectionReference = Firestore.instance
        .collection("messages")
        .document(widget.receiverUid)
        .collection(message.senderUid); */

    /* _collectionReference.add(map).whenComplete(() {
      print("Messages added to db");
    }); */

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
                                    "Group",
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
                      chatMessagesListWidget(),
                      SizedBox(
                        height: SizeConfig.v * 2.035,
                      ),
                      chatInputWidget(),
                    ],
                  ),
                ),
        ));
  }

  Widget chatInputWidget() {
    return Container(
      alignment: Alignment.bottomRight,
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.b * 1.27, vertical: SizeConfig.v * 1.08),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Container(
              child: TextFormField(
                autovalidateMode: _autoValidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                validator: (String input) {
                  if (input.isEmpty) {
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
                      if (_formKey.currentState.validate()) {
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
                  pickDoc();
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
    // ignore: invalid_use_of_visible_for_testing_member
    PickedFile selectedFil = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
    );
    File selectedFile = File(selectedFil.path);
    //imagefile = selectedImage;
    print("Original Size: ${selectedFile.lengthSync()}");

    File compressedImageFile = await FlutterImageCompress.compressAndGetFile(
        selectedFile.path, imagefile.path,
        quality: 50, minWidth: 720, minHeight: 1280);

    imagefile = compressedImageFile;

    print("Comressed Size: ${imagefile.lengthSync()}");

    _storageReference = FirebaseStorage.instance
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch}');
    StorageUploadTask storageUploadTask = _storageReference.putFile(imagefile);
    var url = await (await storageUploadTask.onComplete).ref.getDownloadURL();

    print("URL: $url");
    uploadImageToDb(url);
    return url;
  }

  Future<String> pickVideo() async {
    File videoFile = await FilePicker.getFile(type: FileType.video);
    _storageReference = FirebaseStorage.instance
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch}');

    StorageUploadTask storageUploadTask = _storageReference.putFile(videoFile);
    var url = await (await storageUploadTask.onComplete).ref.getDownloadURL();

    print("Video URL : $url");
    uploadVideoToDB(url);
    return url;
  }

  Future<String> pickDoc() async {
    File docFile = await FilePicker.getFile(
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

    _storageReference = FirebaseStorage.instance
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch}');

    StorageUploadTask storageUploadTask = _storageReference.putFile(docFile);
    var url = await (await storageUploadTask.onComplete).ref.getDownloadURL();

    print("Document URl : $url");
    uploadDoctoDb(url);
    return url;
  }

  void uploadDoctoDb(String downloadUrl) {
    print("Inside Upload Doc");

    _message = GroupMessage.withoutMessage(
        message: 'Doc Title',
        gid: gid,
        senderUid: _senderuid,
        senderName: currentUser.name,
        mediaUrl: downloadUrl,
        timestamp: FieldValue.serverTimestamp(),
        type: 'doc');

    var map = Map<String, dynamic>();
    map['senderUid'] = _message.senderUid;
    map['gid'] = _message.gid;
    map['senderName'] = currentUser.name;
    map['type'] = _message.type;
    map['timestamp'] = _message.timestamp;
    map['mediaUrl'] = _message.mediaUrl;
    map['message'] = _message.message;

    print("Map : $map");
    _collectionReference = Firestore.instance
        .collection("groupMessages")
        .document(currentUser.code)
        .collection(gid);

    _collectionReference.add(map).whenComplete(() {
      print("Doc added to db");
    });

    /* _collectionReference = Firestore.instance
        .collection("messages")
        .document(widget.receiverUid)
        .collection(_message.senderUid);

    _collectionReference.add(map).whenComplete(() {
      print("Messages added to db");
    }); */
  }

  void uploadVideoToDB(String downloadUrl) {
    print("Inside Upload Video");

    _message = GroupMessage.withoutMessage(
        message: "Dummy Video Title",
        gid: gid,
        senderUid: _senderuid,
        senderName: currentUser.name,
        mediaUrl: downloadUrl,
        timestamp: FieldValue.serverTimestamp(),
        type: 'video');

    var map = Map<String, dynamic>();
    map['senderUid'] = _message.senderUid;
    map['gid'] = _message.gid;
    map['senderName'] = currentUser.name;
    map['type'] = _message.type;
    map['timestamp'] = _message.timestamp;
    map['mediaUrl'] = _message.mediaUrl;
    map['message'] = _message.message;

    print("Map : $map");
    _collectionReference = Firestore.instance
        .collection("groupMessages")
        .document(currentUser.code)
        .collection(gid);

    _collectionReference.add(map).whenComplete(() {
      print("Video added to db");
    });
  }

  void uploadImageToDb(String downloadUrl) {
    _message = GroupMessage.withoutMessage(
        gid: gid,
        senderUid: _senderuid,
        senderName: currentUser.name,
        mediaUrl: downloadUrl,
        timestamp: FieldValue.serverTimestamp(),
        type: 'image');

    var map = Map<String, dynamic>();
    map['senderUid'] = _message.senderUid;
    map['gid'] = _message.gid;
    map['senderName'] = currentUser.name;
    map['type'] = _message.type;
    map['timestamp'] = _message.timestamp;
    map['mediaUrl'] = _message.mediaUrl;

    print("Map : $map");
    _collectionReference = Firestore.instance
        .collection("groupMessages")
        .document(currentUser.code)
        .collection(gid);

    _collectionReference.add(map).whenComplete(() {
      print("Image added to db");
    });
  }

  void sendMessage() async {
    print("Inside send message");
    var text = _messageController.text;
    print(text);
    _message = GroupMessage(
        senderName: currentUser.name,
        senderUid: _senderuid,
        gid: gid,
        message: text,
        timestamp: FieldValue.serverTimestamp(),
        type: 'text');
    /* print(
        "receiverUid: ${widget.receiverUid} , senderUid : ${_senderuid} , message: ${text}"); */
    print(
        "timestamp: ${DateTime.now().millisecond}, type: ${text != null ? 'text' : 'image'}");
    addMessageToDb(_message);
  }

  Future<FirebaseUser> getUID() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Widget chatMessagesListWidget() {
    print("SENDERUID : $_senderuid");
    return Flexible(
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('groupMessages')
            .document(currentUser.code)
            .collection(gid)
            .orderBy('timestamp', descending: false) //to be reviewed
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            int rev = snapshot.data.documents.length - 1;
            listItem = snapshot.data.documents;
            return ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(SizeConfig.b * 2.54),
              reverse: true, //reviewed
              itemBuilder: (context, index) =>
                  chatMessageItem(snapshot.data.documents[rev - index]),
              itemCount: snapshot.data.documents.length,
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
                                                    width: SizeConfig.b * 10,
                                                  ),
                                                  SizedBox(
                                                    width: SizeConfig.b * 10,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        snapshot['message'],
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ), //snapshot['message']),
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
                        snapshot['type'] == 'doc'
                            ? InkWell(
                                onTap: () {
                                  print("Document Opened");
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
                                                        'assets/doc_icon.png'),
                                                    width: SizeConfig.b * 10,
                                                  ),
                                                  SizedBox(
                                                    width: SizeConfig.b * 10,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        snapshot['message'],
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ), //snapshot['message']),
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
                                                snapshot['senderName'],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
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
