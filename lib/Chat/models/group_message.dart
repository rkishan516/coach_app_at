import 'package:cloud_firestore/cloud_firestore.dart';

class GroupMessage {
  late String senderUid;
  late String type;
  late String? message;
  late FieldValue timestamp;
  late String mediaUrl;
  late String gid;
  late String senderName;

  GroupMessage({
    required this.senderUid,
    required this.type,
    required this.message,
    required this.timestamp,
    required this.gid,
    required this.senderName,
  });
  GroupMessage.withoutMessage({
    required this.senderUid,
    required this.type,
    this.message,
    required this.timestamp,
    required this.gid,
    required this.senderName,
    required this.mediaUrl,
  });

  Map<String, dynamic> toMap() {
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
    GroupMessage _message = GroupMessage(
      senderUid: map['senderUid'],
      type: map['type'],
      message: map['message'],
      timestamp: map['timestamp'],
      gid: map['gid'],
      senderName: map['senderName'],
    );
    return _message;
  }
}
