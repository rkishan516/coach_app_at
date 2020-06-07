import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class StudentPerformance extends StatelessWidget {
  final String uid;
  final String courseId;
  StudentPerformance({@required this.uid, @required this.courseId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Performance',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: StreamBuilder<Event>(
          stream: FirebaseDatabase.instance
              .reference()
              .child(
                  'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/')
              .onValue,
          builder: (context, snap) {
            if (snap.hasData) {
              Branch branch = Branch.fromJson(snap.data.snapshot.value);
              snap.data.snapshot.value['students']['$uid']['courses']['$courseId']['subjects'].forEach((k,v){

              });
              return Container();
            } else {
              return UploadDialog(warning: 'Fetching Student Data');
            }
          }),
    );
  }
}
