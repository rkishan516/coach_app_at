//for mid admin based

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:coach_app/Chat/group_description.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_app/Chat/models/item_class.dart';
import 'package:coach_app/Chat/participants.dart';

class midAdminBased extends StatefulWidget {
  final curUser currentUser;
  midAdminBased({this.currentUser});
  @override
  _midAdminBasedState createState() => _midAdminBasedState(currentUser);
}

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

class _midAdminBasedState extends State<midAdminBased> {
  final curUser currentUser;
  _midAdminBasedState(this.currentUser);

  List<Item> itemList = [], tempList = [];
  List<Item> selectedList = [];
  List<DocumentSnapshot> ulist;
  StreamSubscription<QuerySnapshot> subscription;
  CollectionReference collectionReference =
      Firestore.instance.collection("Mid Admin");

  @override
  void initState() {
    //loadList();
    super.initState();
    subscription = collectionReference.snapshots().listen((snapshot) {
      setState(() {
        ulist = snapshot.documents;

        for (int i = 0; i < ulist.length; i++) {
          String name, photo, uid, deg, code;
          int rank = 0;
          name = ulist[i].data['name'];
          photo = ulist[i].data['photoUrl'];
          uid = ulist[i].data['uid'];
          deg = ulist[i].data['role'];
          rank = i + 1;
          code = ulist[i].data['code'];

          if (uid == currentUser.uid) {
            continue;
          }
          Item temp = Item(photo, rank, name, uid, deg, code);
          itemList.add(temp);
          //});
        }
      });
    });
  }

  loadList() {
    //itemList = List();
    List<Item> itemList;
    selectedList = List();

    String name, deg, photourl, uid;
    name = ulist[1].data['name'].toString();
    print("$name");
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: getAppBar(),
        floatingActionButton: selectedList.length < -1
            ? Container()
            : FloatingActionButton(
                backgroundColor: Color.fromARGB(255, 242, 108, 37),
                child: Icon(
                  Icons.group_add,
                  size: SizeConfig.b * 7,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(new MaterialPageRoute(builder: (context) {
                    return new groupDes(
                      currentUser: currentUser,
                      //sList: selectedList,
                      ch: choose(true, false, false, false, false, false),
                      catg: "Mid Admin",
                    );
                  }));
                }),
        body: Container(
            color: Color.fromARGB(255, 230, 230, 230),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                alignment: Alignment.center,
                height: SizeConfig.v * 6.78,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Text("Mid-Admin Based",
                    style: TextStyle(
                        fontSize: SizeConfig.b * 5,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 242, 108, 37))),
              ),
              SizedBox(height: SizeConfig.v * 2.71),
              Text("    Select participants For Group",
                  style: TextStyle(fontSize: SizeConfig.b * 4.4)),
              SizedBox(height: SizeConfig.v * 2.71),
              Flexible(
                  child: itemList.length < 1
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.red,
                        )
                      : ListView(children: [
                          ConstrainedBox(
                            constraints:
                                BoxConstraints(maxHeight: SizeConfig.v * 74.53),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: itemList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          itemList[index].imageUrl),
                                    ),
                                    title: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          new Text(
                                            itemList[index].name,
                                            style: new TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromARGB(
                                                    255, 242, 108, 37),
                                                fontSize: SizeConfig.b * 4.5),
                                          ),
                                        ],
                                      ),
                                    ),
                                    subtitle: Container(
                                      padding: EdgeInsets.only(
                                          top: SizeConfig.v * 0.67),
                                      child: new Text(
                                          'Inst. Code: ${itemList[index].code}',
                                          style: new TextStyle(
                                              color: Colors.grey,
                                              fontSize: SizeConfig.b * 3.31)),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          new MaterialPageRoute(
                                              builder: (context) {
                                        return new groupDes(
                                          currentUser: currentUser,
                                        );
                                      }));
                                    },
                                  );
                                }),
                          )
                        ]))
            ])));
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
      title: Text(selectedList.length < 1
          ? "Chat Section"
          : "${selectedList.length} selected"),
      actions: <Widget>[
        selectedList.length < 1
            ? Container()
            : Container(
                child: Row(
                children: [
                  InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.all(SizeConfig.b * 2.25),
                        child: Icon(Icons.group_add),
                      )),
                  InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.all(SizeConfig.b * 2.25),
                        child: Icon(Icons.cancel),
                      ))
                ],
              ))
      ],
    );
  }
}
