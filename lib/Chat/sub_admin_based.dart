import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coach_app/Chat/models/item_class.dart';
import 'package:coach_app/Profile/TeacherProfile.dart';
import 'package:flutter/material.dart';

class SubAdminBased extends StatefulWidget {
  final CurrUser currentUser;
  SubAdminBased({required this.currentUser});
  @override
  _SubAdminBasedState createState() => new _SubAdminBasedState(currentUser);
}

List<String> litems = [
  "1",
  "2",
  "Third",
  "4",
  "1",
  "2",
  "Third",
  "4",
  "1",
  "2",
  "25",
  "25",
  "25"
];

class _SubAdminBasedState extends State<SubAdminBased>
    with TickerProviderStateMixin {
  final CurrUser currentUser;
  _SubAdminBasedState(this.currentUser);

  List<DocumentSnapshot> userlist = [];
  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('Sub Admin');

  @override
  void initState() {
    super.initState();
    _collectionReference
        .where('code', isEqualTo: currentUser.code)
        .snapshots()
        .listen((datasnapshot) {
      setState(() {
        userlist = datasnapshot.docs;

        for (int i = 0; i < userlist.length; i++) {
          if ((userlist[i].data as Map)['uid'] == currentUser.uid) {
            userlist.removeAt(i);
          }
        }
        print("Users List ${userlist.length}");
      });
    });
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
              child: Text("Sub-Admin Based",
                  style: TextStyle(
                      fontSize: SizeConfig.b * 4.58,
                      color: Color.fromARGB(255, 242, 108, 37))),
            ),
            SizedBox(height: SizeConfig.v * 2.71),
            Text("    Select participants For Group",
                style: TextStyle(fontSize: SizeConfig.b * 4.4)),
            SizedBox(height: SizeConfig.v * 2.71),
            Flexible(
              child: ListView(
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: SizeConfig.v *
                            74.53), // **THIS is the important part**
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
                                  radius: 25,
                                  backgroundImage: NetworkImage((userlist[index]
                                      .data as Map)['photoUrl']),
                                ),
                                SizedBox(width: SizeConfig.b * 4.07),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: SizeConfig.v * 1.08),
                                    Text((userlist[index].data as Map)['name'],
                                        style: TextStyle(
                                            fontSize: SizeConfig.b * 4.58,
                                            color: Color.fromARGB(
                                                255, 242, 108, 37))),
                                    SizedBox(height: SizeConfig.v * 0.68),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: SizeConfig.v * 1.5),
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
          child: new Icon(Icons.check, size: SizeConfig.b * 7.63),
          backgroundColor: Color.fromARGB(255, 242, 108, 37),
          onPressed: () {}),
    );
  }
}
