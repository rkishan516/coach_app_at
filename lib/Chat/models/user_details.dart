class UserDetails {
  late String name;
  late String emailId;
  late String photoUrl;
  late String uid;

  UserDetails({
    required this.name,
    required this.emailId,
    required this.photoUrl,
    required this.uid,
  });

  Map toMap(UserDetails userDetails) {
    var data = Map<String, String>();
    data['name'] = userDetails.name;
    data['emailId'] = userDetails.emailId;
    data['photoUrl'] = userDetails.photoUrl;
    data['uid'] = userDetails.uid;
    return data;
  }

  UserDetails.fromMap(Map<String, String> mapData) {
    this.name = mapData['name']!;
    this.emailId = mapData['emailId']!;
    this.photoUrl = mapData['photoUrl']!;
    this.uid = mapData['uid']!;
  }
}
