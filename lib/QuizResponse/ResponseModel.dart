import 'dart:collection';

class Response{
  String uid;
  String name;
  int score;
  Map<String,String> responses;

  Response(this.uid, this.name, this.responses, this.score);
}