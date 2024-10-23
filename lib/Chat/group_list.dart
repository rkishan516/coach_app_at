import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_app/Chat/models/item_class.dart';
import 'package:coach_app/Chat/pages/group_chat.dart';
import 'package:coach_app/Profile/TeacherProfile.dart';
import 'package:flutter/material.dart';

class GroupList extends StatefulWidget {
  final CurrUser currentUser;
  GroupList({required this.currentUser});
  @override
  _GroupListState createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  late CurrUser currentUser;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("Group");
  List<gList> _gList = [];

  @override
  void initState() {
    super.initState();
    currentUser = widget.currentUser;
    collectionReference
        .doc(currentUser.code)
        .collection('Custom Groups')
        .snapshots()
        .listen((snapshot) {
      setState(() {
        final tempList = snapshot.docs;

        for (int i = 0; i < tempList.length; i++) {
          bool flag = false;
          for (int j = 0;
              j < (tempList[i].data as Map)['memberList'].toList().length;
              j++) {
            String memberUid = (tempList[i].data as Map)['memberList'][j];
            if (memberUid == currentUser.uid) {
              flag = true;
              break;
            }
          }

          if (flag) {
            String gName = (tempList[i].data as Map)['name'];
            String gid = (tempList[i].data as Map)['gid'];
            String gPhoto = (tempList[i].data as Map)['groupImageUrl'];
            gList tempGlist = gList(gName, gid, gPhoto);

            _gList.add(tempGlist);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ListView.builder(
      itemCount: _gList.length, //groupList.length,
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
                            _gList[index].name, //groupList[index].data['name'],
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

class gList {
  String gid;
  String name;
  String photoUrl;

  gList(this.gid, this.name, this.photoUrl);
}
