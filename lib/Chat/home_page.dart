import 'dart:async';

import 'package:appwrite/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_app/Chat/all_users_screen.dart';
import 'package:coach_app/Chat/models/item_class.dart';
import 'package:coach_app/Chat/models/user_details.dart';
import 'package:coach_app/Profile/TeacherProfile.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var mapData = Map<String, String>();

  Future<User?> signIn() async {
    GoogleSignInAccount? _signInAccount = await _googleSignIn.signIn();
    if (_signInAccount == null) return null;
    // GoogleSignInAuthentication _signInAuthentication =
    //     await _signInAccount.authentication;

    // final authCredential = GoogleAuthProvider.credential(
    //     idToken: _signInAuthentication.idToken,
    //     accessToken: _signInAuthentication.accessToken);

    // final User? user =
    //     (await _firebaseAuth.signInWithCredential(authCredential)).user;
    // print("User Name : ${user?.name}");
    // return user;
    return null;
  }

  void addDataToDb(
      User? user, ListItem _selectedItem, ListItem _selectedSub, code) {
    final _userDetails = UserDetails(
      name: user!.name,
      emailId: user.email,
      photoUrl: '',
      uid: user.$id,
    );

    var mapD;
    String nAME = _userDetails.name,
        eMAIL = _userDetails.emailId,
        pHOTO = _userDetails.photoUrl,
        uID = _userDetails.uid;
    String selRole = _selectedItem.name, selCourse = _selectedSub.name;

    final udetail = CurrUser(uID, nAME, pHOTO, eMAIL, code, selCourse, selRole);

    final currentUser = udetail;

    mapD = udetail.toMap();

    String selSub = _selectedSub.name;
    String selItem = _selectedItem.name;
    String uid = user.$id;

    final _documentReference =
        FirebaseFirestore.instance.collection(selItem).doc(uid);

    final _documentReference2 = FirebaseFirestore.instance
        .collection("Group")
        .doc(code)
        .collection("Course Groups")
        .doc(selCourse);

    // Adding Member in Course Group
    FirebaseFirestore.instance
        .collection("Group")
        .doc(code)
        .collection("Course Group");

    Map<String, dynamic>? tempSnap;
    subGroup _subGroup;
    List<dynamic> tempMemberList;
    List<String> toAdd = [];
    //String str;

    _documentReference2.snapshots().listen((snapshot) {
      tempSnap = snapshot.data();
    });
    tempMemberList = tempSnap?['memberList'].toList();

    bool flag = true;
    for (int i = 0; i < tempMemberList.length; i++) {
      toAdd.add(tempMemberList[i].toString());
      if (tempMemberList[i].toString() == eMAIL) {
        flag = false;
        break;
      }
    }

    if (flag) {
      toAdd.add(eMAIL);
    }

    String groupID = code + "course" + selCourse;
    String photoLink =
        "https://cdn.iconscout.com/icon/premium/png-256-thumb/open-book-1831704-1554648.png";

    _subGroup = subGroup(
        name: selCourse,
        memberList: toAdd,
        photoUrl: photoLink,
        code: code,
        course: selCourse,
        gid: groupID);

    var map2 = Map<Object, Object>.from(_subGroup.toMap());

    //Yha tak

    _documentReference.get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
      } else {
        _documentReference.set(mapD).whenComplete(() {
          print("Users Colelction added to Database");
        }).catchError((e) {
          print("Error adding collection to Database $e");
        });
      }
    });

    _documentReference2.get().then((snapshot) {
      if (snapshot.exists) {
      } else {
        _documentReference2.update(map2).whenComplete(() {
          print("Users Colelction added to Group $selSub");
        }).catchError((e) {
          print("Error adding collection to Database $e");
        });
      }
    });

    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (context) => AllUsersScreen(
                  currentUser: currentUser,
                )));
  }

  List<ListItem> _dropdownItems = [
    ListItem(1, "Mid Admin"),
    ListItem(2, "Sub Admin"),
    ListItem(3, "Teacher"),
    ListItem(4, "Student"),
    ListItem(5, "Admin")
  ];

  List<ListItem> _dropdownsubs = [
    ListItem(1, "Mathematics"),
    ListItem(2, "Physics"),
    ListItem(3, "Chemistry"),
    ListItem(4, "English"),
    ListItem(4, "Biology")
  ];

  late List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  late ListItem _selectedItem;
  late List<DropdownMenuItem<ListItem>> _dropdownMenusubs;
  late ListItem _selectedItemsub;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value!;
    _dropdownMenusubs = buildDropDownMenuItems(_dropdownsubs);
    _selectedItemsub = _dropdownMenusubs[0].value!;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = [];
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Color.fromARGB(255, 242, 108, 37),
                  fontWeight: FontWeight.w400)),
          value: listItem,
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuSubs(List listItemssubs) {
    List<DropdownMenuItem<ListItem>> items1 = [];
    for (ListItem listItem1 in listItemssubs) {
      items1.add(
        DropdownMenuItem(
          child: Text(listItem1.name,
              style: TextStyle(
                  color: Color.fromARGB(255, 242, 108, 37),
                  fontWeight: FontWeight.w400)),
          value: listItem1,
        ),
      );
    }
    return items1;
  }

  String code = '';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ChatApp'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Chat App',
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            //SizedBox(height: SizeConfig.b*1.5),
            Container(
              alignment: Alignment.center,
              width: SizeConfig.b * 53.43,
              height: SizeConfig.v * 9.5,
              child: TextField(
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromARGB(255, 242, 108, 37),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    prefixIcon:
                        Icon(Icons.location_city, size: SizeConfig.b * 9.7),
                    border: InputBorder.none,
                    hintText: 'The Insitution Code',
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: SizeConfig.b * 4,
                        fontWeight: FontWeight.w400),
                  ),
                  onChanged: (String str) {
                    setState(() {
                      code = str;
                    });
                  }),
            ),
            DropdownButton<ListItem>(
                hint: Text("Sign In As"),
                value: _selectedItem,
                items: _dropdownMenuItems,
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedItem = value;
                  });
                }),
            SizedBox(
              width: SizeConfig.b * 15.3,
            ),
            _selectedItemsub != _dropdownMenuItems[4].value
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "For Course",
                        style: TextStyle(
                            fontSize: SizeConfig.b * 4.07,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600),
                      ),
                      DropdownButton<ListItem>(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          size: SizeConfig.b * 6.9,
                          color: Colors.grey,
                        ),
                        value: _selectedItemsub,
                        items: _dropdownMenusubs,
                        underline: SizedBox(),
                        dropdownColor: Colors.grey[200],
                        onChanged: (value) {
                          if (value == null) return;

                          setState(() {
                            _selectedItemsub = value;
                          });
                        },
                      )
                    ],
                  )
                : Text(""),
            MaterialButton(
              elevation: 8.0,
              padding: EdgeInsets.all(8.0),
              shape: StadiumBorder(),
              textColor: Colors.black,
              color: Colors.lime,
              child: Text('Sign In'),
              splashColor: Colors.red,
              onPressed: () {
                signIn().then((User? user) {
                  addDataToDb(user, _selectedItem, _selectedItemsub, code);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

class subGroup {
  String name;
  List<String> memberList;
  String photoUrl;
  String code;
  String course;
  String gid;

  subGroup({
    required this.name,
    required this.memberList,
    required this.photoUrl,
    required this.code,
    required this.course,
    required this.gid,
  });

  Map toMap() {
    var map = Map<String, dynamic>();
    map['name'] = this.name;
    map['memberList'] = this.memberList;
    map['photoUrl'] = this.photoUrl;
    map['code'] = this.code;
    map['course'] = this.course;
    map['gid'] = this.gid;
    return map;
  }

  subGroup fromMap(Map<String, dynamic> map) {
    subGroup _groupData = subGroup(
      name: map['name'],
      memberList: map['memberList'],
      photoUrl: map['photoUrl'],
      code: map['code'],
      course: map['course'],
      gid: map['gid'],
    );
    return _groupData;
  }
}
