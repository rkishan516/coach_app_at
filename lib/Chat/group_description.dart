//group removal page and nami g of group nd photo page
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:coach_app/Chat/group_description_grid.dart';
import 'package:coach_app/Chat/group_final.dart';
import 'package:coach_app/Chat/participants.dart';
import 'participants.dart';
import 'package:coach_app/Chat/models/item_class.dart';

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

class groupDes extends StatefulWidget {
  final List<Item> sList;
  final choose ch;
  final String catg;
  final curUser currentUser;

  groupDes({this.sList, this.catg, this.ch, this.currentUser});

  @override
  _groupDesState createState() {
    return new _groupDesState(sList, catg, ch, currentUser);
  }
}

class _groupDesState extends State<groupDes> {
  List<Item> selItem2 = [];
  String catg;
  choose ch;
  final curUser currentUser;
  int counter = 0;
  String groupName = '';
  _groupDesState(this.selItem2, this.catg, this.ch, this.currentUser);

  List<Item> itemList = [];
  List<Item> selectedList2 = [];
  List<DocumentSnapshot> tempList;
  CollectionReference collectionReference;
  StreamSubscription<QuerySnapshot> subscription;

  @override
  void initState() {
    super.initState();

    if (ch.mid) {
      preSelection("Mid Admin");
    }

    if (ch.subBased) {
      preSelection("Sub Admin");
    }

    if (ch.teacher) {
      preSelection("Teacher");
    }
  }

  void preSelection(String previ) {
    collectionReference = Firestore.instance.collection(previ);

    subscription =
        collectionReference.orderBy('name').snapshots().listen((snapshot) {
      tempList = snapshot.documents;

      for (int i = 0; i < tempList.length; i++) {
        String name, photo, role, uid, code;
        int rank;
        name = tempList[i].data['name'];
        photo = tempList[i].data['photoUrl'];
        role = tempList[i].data['role'];
        rank = i + 1;
        code = tempList[i].data['code'];
        uid = tempList[i].data['uid'];
        Item temp = Item(photo, rank, name, uid, role, code);
        setState(() {
          selectedList2.add(temp);
        });
      }
    });
  }

  void getData(AsyncSnapshot<dynamic> snapshot) async {
    setState(() {
      tempList = snapshot.data.documents;

      for (int i = 0; i < tempList.length; i++) {
        String name, photo, role, uid, code;
        int rank;
        name = tempList[i].data['name'];
        photo = tempList[i].data['photoUrl'];
        role = tempList[i].data['role'];
        rank = i + 1;
        code = tempList[i].data['code'];
        uid = tempList[i].data['uid'];
        Item temp = Item(photo, rank, name, uid, role, code);
        itemList.add(temp);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    //subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //getData();
    return Scaffold(
        appBar: getAppBar(),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 242, 108, 37),
            child: Icon(
              Icons.group_add,
              size: SizeConfig.b * 7,
            ),
            onPressed: () {
              if (selectedList2.length < 1) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("No participant is selected"),
                ));
              } else {
                Navigator.of(context)
                    .push(new MaterialPageRoute(builder: (context) {
                  return new groupFinal(
                    preSelectedItem: selectedList2,
                    groupName: groupName,
                    currentUser: currentUser,
                  );
                }));
              }
            }),
        body: ListView(children: [
          Container(
              color: Color.fromARGB(255, 230, 230, 230),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      child: Text("New Group",
                          style: TextStyle(
                              fontSize: SizeConfig.b * 5,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 242, 108, 37))),
                    ),
                    SizedBox(height: SizeConfig.v * 2.71),
                    new Row(children: <Widget>[
                      SizedBox(width: SizeConfig.b * 3),
                      CircleAvatar(
                        foregroundColor: Theme.of(context).accentColor,
                        backgroundColor: Colors.grey,
                        radius: SizeConfig.b * 7.63,
                        backgroundImage: AssetImage('images/f.jpg'),
                      ),
                      SizedBox(width: SizeConfig.b * 5),
                      new Flexible(
                        child: Container(
                          alignment: Alignment.bottomRight,
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.b * 1.27,
                              vertical: SizeConfig.v * 1.08),
                          child: new Theme(
                            data: Theme.of(context)
                                .copyWith(primaryColor: Colors.white),
                            child: new TextField(
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.insert_emoticon,
                                    color: Colors.grey),
                                hintText: "Type a message",
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 230, 230, 230)),
                                  borderRadius: BorderRadius.circular(
                                      SizeConfig.b * 6.36),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  groupName = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(height: SizeConfig.v * 2.71),
                    Container(
                      height: SizeConfig.v * 5.42,
                      color: Color.fromARGB(255, 230, 230, 230),
                      child: Row(
                        children: [
                          SizedBox(width: SizeConfig.b * 2.09),
                          Text("Participants: ",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: SizeConfig.b * 3.82)),
                          Text(counter.toString(),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 242, 108, 37)))
                        ],
                      ),
                    ),
                    ch.mid == true
                        ? Container(
                            height: SizeConfig.v * 4.34,
                            color: Color.fromARGB(255, 230, 230, 230),
                            child: Row(
                              children: [
                                SizedBox(width: SizeConfig.b * 2.0),
                                Text("Mid-Admin :",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 242, 108, 37),
                                        fontSize: SizeConfig.b * 4.4))
                              ],
                            ),
                          )
                        : SizedBox(),
                    ch.mid == true
                        ? StreamBuilder(
                            stream: Firestore.instance
                                .collection("Mid Admin")
                                .orderBy('name')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return getGridWidget(snapshot);
                              }
                            },
                          )
                        : SizedBox(),
                    ch.subBased == false
                        ? SizedBox()
                        : Container(
                            height: SizeConfig.v * 4.34,
                            color: Color.fromARGB(255, 230, 230, 230),
                            child: Row(
                              children: [
                                SizedBox(width: SizeConfig.b * 2.0),
                                Text("Sub-Admin :",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 242, 108, 37),
                                        fontSize: SizeConfig.b * 4.4))
                              ],
                            ),
                          ),
                    ch.subBased == true
                        ? StreamBuilder(
                            stream: Firestore.instance
                                .collection("Sub Admin")
                                .orderBy('name')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return getGridWidget(snapshot);
                              }
                            },
                          )
                        : SizedBox(),
                    ch.teacher == false
                        ? SizedBox()
                        : Container(
                            height: SizeConfig.v * 4.34,
                            color: Color.fromARGB(255, 230, 230, 230),
                            child: Row(
                              children: [
                                SizedBox(width: SizeConfig.b * 2.0),
                                Text("Teacher :",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 242, 108, 37),
                                        fontSize: SizeConfig.b * 4.4))
                              ],
                            ),
                          ),
                    ch.teacher == true
                        ? StreamBuilder(
                            stream: Firestore.instance
                                .collection("Teacher")
                                .orderBy('name')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return getGridWidget(snapshot);
                              }
                            },
                          )
                        : SizedBox(),
                    ch.ind == false
                        ? SizedBox()
                        : Container(
                            height: SizeConfig.v * 4.34,
                            color: Color.fromARGB(255, 230, 230, 230),
                            child: Row(
                              children: [
                                SizedBox(width: SizeConfig.b * 2.0),
                                Text("Student :",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 242, 108, 37),
                                        fontSize: SizeConfig.b * 4.4))
                              ],
                            ),
                          ),
                    ch.ind == true
                        ? StreamBuilder(
                            stream: Firestore.instance
                                .collection("Student")
                                .orderBy('name')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return getGridWidget(snapshot);
                              }
                            },
                          )
                        : SizedBox(),
                  ]))
        ]));
  }

  Widget getGridWidget(AsyncSnapshot<dynamic> snapshot) {
    getData(snapshot);
    //selectedList2 = selectedList2 + itemList;
    return GridView.builder(
        shrinkWrap: true,
        physics: new NeverScrollableScrollPhysics(),
        itemCount: snapshot.data.documents.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemBuilder: (context, index) {
          return GridItem(
              item: itemList[index],
              isSelected: (bool value) {
                setState(() {
                  if (value) {
                    selectedList2.remove(itemList[index]);
                    print("ADDED");
                  } else {
                    selectedList2.add(itemList[index]);
                    print("REMOVE");
                  }
                });
                print("$index : $value");
                int co = selectedList2.length;
                print("Selected list length: $co");
                print(itemList[index].name);
              },
              key: Key(itemList[index].rank.toString()));
        });
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
      title: Text(selectedList2.length < 1
          ? "Chat Section"
          : "${selectedList2.length} selected"),
      actions: <Widget>[
        selectedList2.length < 1
            ? Container()
            : Container(
                child: Row(
                children: [
                  /* Text("Remove"),
                  InkWell(
                      onTap: () {
                        setState(() {
                          selectedList2.clear();
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(SizeConfig.b * 2.25),
                        child: Icon(
                          Icons.cancel,
                        ), //to remove a guy from the group
                      )) */
                ],
              ))
      ],
    );
  }
}
