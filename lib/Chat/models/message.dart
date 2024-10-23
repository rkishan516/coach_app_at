import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderUid;
  final String receiverUid;
  final String type;
  final String? message;
  final FieldValue timestamp;
  final String? mediaUrl;

  Message({
    required this.senderUid,
    required this.receiverUid,
    required this.type,
    required this.message,
    required this.timestamp,
    this.mediaUrl,
  });
  Message.withoutMessage({
    required this.senderUid,
    required this.receiverUid,
    required this.type,
    required this.timestamp,
    required this.mediaUrl,
    this.message,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['senderUid'] = this.senderUid;
    map['receiverUid'] = this.receiverUid;
    map['type'] = this.type;
    map['message'] = this.message;
    map['timestamp'] = this.timestamp;
    return map;
  }

  Message fromMap(Map<String, dynamic> map) {
    Message _message = Message(
      senderUid: map['senderUid'],
      receiverUid: map['receiverUid'],
      type: map['type'],
      message: map['message'],
      timestamp: map['timestamp'],
    );
    return _message;
  }
}
