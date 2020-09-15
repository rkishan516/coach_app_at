import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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

class branchBased extends StatefulWidget {
  final curUser currentUser;

  branchBased({this.currentUser});
  @override
  _branchBased createState() => new _branchBased(currentUser);
}

class _branchBased extends State<branchBased> with TickerProviderStateMixin {
  final curUser currentUser;
  _branchBased(this.currentUser);

  CollectionReference collectionSubAdmin =
      Firestore.instance.collection("Sub Admin");
  CollectionReference collectionTeacher =
      Firestore.instance.collection("Teacher");
  CollectionReference collectionStudent =
      Firestore.instance.collection("Student");

  StreamSubscription<QuerySnapshot> subscriptionSubAdmin,
      subscriptionTeacher,
      subscriptionStudent;

  List<String> litems = ["Delhi Public School (1)", "Surat Public School (2)"];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    /* subscriptionTeacher?.cancel();
    subscriptionStudent?.cancel();
    subscriptionSubAdmin?.cancel(); */
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: new Text("Chat Section"),
        backgroundColor: Color.fromARGB(255, 242, 108, 37),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, SizeConfig.v * 1.36),
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
              child: Text("Branch Based",
                  style: TextStyle(
                      fontSize: SizeConfig.b * 5.07,
                      color: Color.fromARGB(255, 242, 108, 37))),
            ),
            SizedBox(height: SizeConfig.v * 2.71),
            Text("    Select participants For Group",
                style: TextStyle(fontSize: SizeConfig.b * 4.33)),
            SizedBox(height: SizeConfig.v * 2.71),
            Flexible(
              child: ListView(
                children: <Widget>[
                  ConstrainedBox(
                    constraints:
                        BoxConstraints(maxHeight: SizeConfig.v * 74.53),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: litems.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Column(children: [
                            Row(
                              children: [
                                SizedBox(width: SizeConfig.b * 2.54),
                                CircleAvatar(
                                  foregroundColor:
                                      Theme.of(context).accentColor,
                                  backgroundColor: Colors.grey,
                                  radius: SizeConfig.b * 6.36,
                                  backgroundImage: AssetImage('images/f.jpg'),
                                ),
                                SizedBox(width: SizeConfig.b * 4.07),
                                SizedBox(height: SizeConfig.v * 0.68),
                                Text(litems[index],
                                    style: TextStyle(
                                        fontSize: SizeConfig.b * 4.78,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color.fromARGB(255, 242, 108, 37))),
                                SizedBox(width: SizeConfig.b * 1.27),
                              ],
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            SizedBox(height: SizeConfig.v * 1.2),
                          ]);
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.check, size: SizeConfig.b * 7.5),
          backgroundColor: Color.fromARGB(255, 242, 108, 37),
          onPressed: () {}),
    );
  }
}
