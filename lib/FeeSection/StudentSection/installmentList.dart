import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/FeeSection/StudentReport/StuInstallment.dart';
import 'package:coach_app/Student/WaitScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class InstallMentList extends StatefulWidget {
  final DatabaseReference ref;
  final String courseID;
  InstallMentList({
    this.ref,
    this.courseID,
  });
  @override
  _InstallMentListState createState() => _InstallMentListState();
}

class _InstallMentListState extends State<InstallMentList> {
  registerStudent() {
    widget.ref
        .parent()
        .parent()
        .child('/students/${FireBaseAuth.instance.user.uid}/class')
        .set(widget.courseID);
    widget.ref
        .parent()
        .parent()
        .child('/students/${FireBaseAuth.instance.user.uid}/status')
        .set('Existing Student');
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) {
          return WaitScreen();
        },
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Installments',
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<Event>(
            stream: widget.ref.child("fees").onValue,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              if (snapshot.data.snapshot.value == null) {
                return Center(child: Text('No Payment Option Available'));
              }
              return Column(
                children: [
                  Container(),
                  Container()
                ],
              );
              return Center(
                child: Text('${snapshot.data.snapshot.value}'),
              );
            }),
      ),
    );
  }
}
