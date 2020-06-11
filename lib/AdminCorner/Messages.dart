import 'package:firebase_database/firebase_database.dart';

class Messages{
 
  String key;
  String textMsg;
  String uid;
  String time;
  Messages(this.key,this.textMsg, this.uid, this.time);

   Messages.fromSnapshot(DataSnapshot snapshot):
    key= snapshot.key,
    textMsg=snapshot.value["textMsg"],
    uid=snapshot.value["selfId"],
    time=snapshot.value["time"];
}