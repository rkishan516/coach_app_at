import 'package:cloud_firestore/cloud_firestore.dart';

class GroupMessage {
  String senderUid;
  String type;
  String message;
  FieldValue timestamp;
  String mediaUrl;
  String gid;
  String senderName;

  GroupMessage(
      {this.senderUid,
      this.type,
      this.message,
      this.timestamp,
      this.gid,
      this.senderName});
  GroupMessage.withoutMessage({
    this.senderUid,
    this.type,
    this.message,
    this.timestamp,
    this.gid,
    this.senderName,
    this.mediaUrl,
  });

  Map toMap() {
    var map = Map<String, dynamic>();
    map['senderUid'] = this.senderUid;
    map['type'] = this.type;
    map['message'] = this.message;
    map['timestamp'] = this.timestamp;
    map['gid'] = this.gid;
    map['senderName'] = this.senderName;
    return map;
  }

  GroupMessage fromMap(Map<String, dynamic> map) {
    GroupMessage _message = GroupMessage();
    _message.senderUid = map['senderUid'];
    _message.type = map['type'];
    _message.message = map['message'];
    _message.timestamp = map['timestamp'];
    _message.gid = map['gid'];
    _message.senderName = map['senderName'];
    return _message;
  }
}
