class Item {
  String imageUrl;
  int rank;
  String uid;
  String name;
  String des;
  String code;

  Item(this.imageUrl, this.rank, this.name, this.uid, this.des, this.code);
}

class CurUser {
  String name, uid, photourl, course, role, code, email;

  CurUser(this.uid, this.name, this.photourl, this.email, this.code,
      this.course, this.role);

  Map<String, String> toMap() {
    return {
      'name': name,
      'uid': uid,
      'photoUrl': photourl,
      'course': course,
      'role': role,
      'code': code,
      'email': email
    };
  }
}
