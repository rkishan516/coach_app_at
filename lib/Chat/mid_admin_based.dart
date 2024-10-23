//for mid admin based

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_app/Chat/group_description.dart';
import 'package:coach_app/Chat/models/item_class.dart';
import 'package:coach_app/Chat/participants.dart';
import 'package:coach_app/Profile/TeacherProfile.dart';
import 'package:flutter/material.dart';

class MidAdminBased extends StatefulWidget {
  final CurrUser currentUser;
  MidAdminBased({required this.currentUser});
  @override
  _MidAdminBasedState createState() => _MidAdminBasedState(currentUser);
}

class _MidAdminBasedState extends State<MidAdminBased> {
  final CurrUser currentUser;
  _MidAdminBasedState(this.currentUser);

  List<Item> itemList = [], tempList = [];
  List<Item> selectedList = [];
  List<DocumentSnapshot> ulist = [];
  late StreamSubscription<QuerySnapshot> subscription;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("Mid Admin");

  @override
  void initState() {
    //loadList();
    super.initState();
    subscription = collectionReference.snapshots().listen((snapshot) {
      setState(() {
        ulist = snapshot.docs;

        for (int i = 0; i < ulist.length; i++) {
          String name, photo, uid, deg, code;
          int rank = 0;
          name = (ulist[i].data as Map)['name'];
          photo = (ulist[i].data as Map)['photoUrl'];
          uid = (ulist[i].data as Map)['uid'];
          deg = (ulist[i].data as Map)['role'];
          rank = i + 1;
          code = (ulist[i].data as Map)['code'];

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
    selectedList = [];
    final name = (ulist[1].data as Map)['name'].toString();
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
                    return new GroupDes(
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
                                        return new GroupDes(
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
