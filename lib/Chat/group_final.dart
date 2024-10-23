//for the last of group description page where we get the info about the group

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_app/Chat/all_users_screen.dart';
import 'package:coach_app/Chat/group_final_grid.dart';
import 'package:coach_app/Chat/models/item_class.dart';
import 'package:coach_app/Profile/TeacherProfile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GroupFinal extends StatefulWidget {
  final List<Item> preSelectedItem;
  final String groupName;
  final CurrUser currentUser;
  GroupFinal({
    required this.preSelectedItem,
    required this.groupName,
    required this.currentUser,
  });
  @override
  _GroupFinalState createState() =>
      _GroupFinalState(preSelectedItem, groupName, currentUser);
}

class _GroupFinalState extends State<GroupFinal> {
  final List<Item> preSelectedItem;
  final String groupName;
  final CurrUser currentUser;
  _GroupFinalState(this.preSelectedItem, this.groupName, this.currentUser);

  List<Item> itemList = [];
  List<Item> selectedList = [];
  List<String> selectedName = [];

  @override
  void initState() {
    //loadList();
    super.initState();
  }

  void getList() {
    setState(() {
      itemList = preSelectedItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    getList();
    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    String da = dateFormat.format(DateTime.now());
    var grid = Flexible(
        child: ListView(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: SizeConfig.v * 74.53),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return GridItem(
                  item: itemList[index],
                );
              }),
        ),
      ],
    ));

    return Scaffold(
        appBar: getAppBar(),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 242, 108, 37),
            child: Icon(
              Icons.group_add,
              size: SizeConfig.b * 7,
            ),
            onPressed: () {
              addGroupToDb();
            }),
        body: Container(
            color: Color.fromARGB(255, 230, 230, 230),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: SizeConfig.v * 1.5),
                  Container(
                      height: SizeConfig.v * 20.33,
                      width: SizeConfig.b * 94.69,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(SizeConfig.b * 5.09),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: SizeConfig.b * 1.6,
                            blurRadius: SizeConfig.b * 1.78,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            foregroundColor:
                                Theme.of(context).colorScheme.secondary,
                            backgroundColor: Colors.grey,
                            radius: SizeConfig.b * 10,
                            backgroundImage:
                                AssetImage('images/f.jpg'), //instituion image
                          ),
                          SizedBox(height: SizeConfig.v * 0.68),
                          Text(groupName == '' ? "No Name" : groupName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 242, 108, 37),
                                  fontSize: SizeConfig.b * 4.5)),
                        ], //name whats given
                      )),
                  SizedBox(height: SizeConfig.v * 2.71),
                  Container(
                    height: SizeConfig.v * 5.42,
                    color: Color.fromARGB(255, 230, 230, 230),
                    child: Row(
                      children: [
                        SizedBox(width: SizeConfig.b * 2.09),
                        Text("Participants: ",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: SizeConfig.b * 4)),
                        Text(itemList.length.toString(),
                            style: TextStyle(
                                color: Color.fromARGB(255, 242, 108, 37)))
                      ],
                    ),
                  ),
                  Flexible(
                      child: ListView(children: [
                    ConstrainedBox(
                      constraints:
                          BoxConstraints(maxHeight: SizeConfig.v * 47.43),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: itemList.length,
                          itemBuilder: (context, index) {
                            return GridItem(
                              item: itemList[index],
                              /* isSelected: (bool value) {
                                  setState(() {
                                    if (value) {
                                      selectedList.add(itemList[index]);
                                    } else {
                                      selectedList.remove(itemList[index]);
                                    }
                                  });
                                  print("$index : $value");
                                  print(itemList[index].name);
                                },
                                key: Key(itemList[index].rank.toString()) */
                            );
                          }),
                    )
                  ])),
                  Row(
                    children: [
                      SizedBox(width: SizeConfig.b * 5.09),
                      Text("Group Created By: ",
                          style: TextStyle(fontSize: SizeConfig.b * 3.72)),
                      Text(currentUser.name,
                          style: TextStyle(
                              color: Color.fromARGB(255, 242, 108, 37),
                              fontSize: SizeConfig.b * 3.72))
                    ], // adding creator name by fetching from database
                  ),
                  Row(
                    children: [
                      SizedBox(width: SizeConfig.b * 5.09),
                      Text("Group Created On: ",
                          style: TextStyle(fontSize: SizeConfig.b * 3.72)),
                      Text(da,
                          style: TextStyle(
                              color: Color.fromARGB(255, 242, 108, 37),
                              fontSize: SizeConfig.b * 3.72)),
                    ],
                  ),
                  SizedBox(height: SizeConfig.v * 3.71),
                ])));
  }

  void listToName() {
    for (int i = 0; i < preSelectedItem.length; i++) {
      String uid = preSelectedItem[i].uid;
      selectedName.add(uid);
    }
  }

  void addGroupToDb() {
    String gid = currentUser.code + "custom" + groupName;

    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("Group")
        .doc("1")
        .collection("Custom Groups")
        .doc(gid);

    listToName();

    GroupData _groupData;

    _groupData = GroupData(
        name: groupName,
        memberList: selectedName,
        groupImageUrl:
            "https://www.trainforeverstrong.com/wp-content/uploads/2016/04/group-icon.png",
        groupMaker: "Test User",
        timestamp: FieldValue.serverTimestamp(),
        gid: gid);

    var map = _groupData.toMap();

    /* collectionReference
        .add(map)
        .whenComplete(() => print("Group Added to DB : $groupName")); */

    documentReference
        .set(map)
        .whenComplete(() => print("Group Added to DB with Doc Reference"));

    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new AllUsersScreen(currentUser: currentUser);
    }));
  }

  getAppBar() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 242, 108, 37),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text("Chat Section"),
    );
  }
}

class Item2 {
  String imageUrl;
  int rank;
  String uid;
  String name;
  String des;

  Item2(this.imageUrl, this.rank, this.name, this.uid, this.des);
}

class GroupData {
  late String name;
  late List<String> memberList;
  late String groupImageUrl;
  late String groupMaker;
  late FieldValue timestamp;
  late String gid;

  GroupData({
    required this.name,
    required this.memberList,
    required this.groupImageUrl,
    required this.groupMaker,
    required this.timestamp,
    required this.gid,
  });

  Map toMap() {
    var map = Map<String, dynamic>();
    map['name'] = this.name;
    map['memberList'] = this.memberList;
    map['groupImageUrl'] = this.groupImageUrl;
    map['groupMaker'] = this.groupMaker;
    map['timestamp'] = this.timestamp;
    map['gid'] = this.gid;
    return map;
  }

  GroupData fromMap(Map<String, dynamic> map) {
    GroupData _groupData = GroupData(
      name: map['name'],
      memberList: map['memberList'],
      groupImageUrl: map['groupImageUrl'],
      groupMaker: map['groupMaker'],
      timestamp: map['timestamp'],
      gid: map['gid'],
    );
    return _groupData;
  }
}
