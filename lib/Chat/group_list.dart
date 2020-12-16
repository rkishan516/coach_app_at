import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:coach_app/Chat/models/item_class.dart';
import 'package:coach_app/Chat/pages/group_chat.dart';
import 'dart:async';

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

class GroupList extends StatefulWidget {
  final CurUser currentUser;
  GroupList({this.currentUser});
  @override
  _GroupListState createState() => _GroupListState(currentUser);
}

class _GroupListState extends State<GroupList> {
  final CurUser currentUser;
  _GroupListState(this.currentUser);
  StreamSubscription subscription;
  CollectionReference collectionReference =
      Firestore.instance.collection("Group");
  List<DocumentSnapshot> groupList, tempList;
  List<GList> _gList = [];

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    subscription = collectionReference
        .document(currentUser.code)
        .collection('Custom Groups')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        tempList = snapshot.documents;

        for (int i = 0; i < tempList.length; i++) {
          bool flag = false;
          for (int j = 0;
              j < tempList[i].data['memberList'].toList().length;
              j++) {
            String memberUid = tempList[i].data['memberList'][j];
            if (memberUid == currentUser.uid) {
              flag = true;
              break;
            }
          }

          if (flag) {
            String gName = tempList[i].data['name'];
            String gid = tempList[i].data['gid'];
            String gPhoto = tempList[i].data['groupImageUrl'];
            GList tempGlist = GList(gName, gid, gPhoto);

            _gList.add(tempGlist);
          }
        }
      });
    });
  }

  String role;
  @override
  Widget build(BuildContext context) {
    /* subscription = collectionReference
        .document(currentUser.code)
        .collection('Custom Groups')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        tempList = snapshot.documents;
      });
    });
 */
    SizeConfig().init(context);
    //getGroupList();
    return ListView.builder(
      itemCount: _gList.length, //GroupList.length,
      itemBuilder: (context, index) => new Column(
        children: <Widget>[
          Container(
            color: Color.fromARGB(255, 230, 230, 230),
            child: Column(
              children: [
                ListTile(
                    leading: new CircleAvatar(
                      backgroundImage: NetworkImage(_gList[index].photoUrl),
                    ),
                    title: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(
                            _gList[index].name, //GroupList[index].data['name'],
                            style: new TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 242, 108, 37),
                                fontSize: SizeConfig.b * 4.5),
                          ),
                          new Text(
                            'No Time',
                            style: new TextStyle(
                                color: Colors.grey,
                                fontSize: SizeConfig.b * 3.56),
                          ),
                        ],
                      ),
                    ),
                    subtitle: new Container(
                      padding: EdgeInsets.only(top: SizeConfig.v * 0.67),
                      child: new Text('No Subtitle',
                          style: new TextStyle(
                              color: Colors.grey,
                              fontSize: SizeConfig.b * 3.31)),
                    ),
                    onTap: () => Navigator.of(context)
                            .push(new MaterialPageRoute(builder: (context) {
                          return new GroupChatScreen(
                            name: _gList[index].name,
                            photoUrl: _gList[index].gid,
                            gid: _gList[index].gid,
                            currentUser: currentUser,
                          );
                        }))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GList {
  String gid;
  String name;
  String photoUrl;

  GList(this.gid, this.name, this.photoUrl);
}
