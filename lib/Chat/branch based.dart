import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_app/Chat/models/item_class.dart';
import 'package:coach_app/Profile/TeacherProfile.dart';
import 'package:flutter/material.dart';

class BranchBased extends StatefulWidget {
  final CurrUser currentUser;

  BranchBased({required this.currentUser});
  @override
  _BranchBased createState() => new _BranchBased(currentUser);
}

class _BranchBased extends State<BranchBased> with TickerProviderStateMixin {
  final CurrUser currentUser;
  _BranchBased(this.currentUser);

  CollectionReference collectionSubAdmin =
      FirebaseFirestore.instance.collection("Sub Admin");
  CollectionReference collectionTeacher =
      FirebaseFirestore.instance.collection("Teacher");
  CollectionReference collectionStudent =
      FirebaseFirestore.instance.collection("Student");

  late StreamSubscription<QuerySnapshot> subscriptionSubAdmin,
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
                                      Theme.of(context).colorScheme.secondary,
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
