import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SubAdminProfile extends StatefulWidget {
  @override
  _SubAdminProfileState createState() => _SubAdminProfileState();
}

class _SubAdminProfileState extends State<SubAdminProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      drawer: getDrawer(context),
      body: StreamBuilder<Event>(
        stream: FirebaseDatabase.instance
            .reference()
            .child(
                '/institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/admin')
            .onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String key;
            snapshot.data.snapshot.value.forEach((k, v) {
              if (k.contains(RegExp(r'[A-Za-z]+'))) {
                key = k;
              }
            });
            if (key == null) {
              return Container(
                child: Center(
                  child: Text('Sub Admin Not logged in yet'),
                ),
              );
            }
            return Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  if (snapshot.data.snapshot.value[key]['photoUrl'] != null)
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        snapshot.data.snapshot.value[key]['photoUrl'],
                      ),
                    ),
                  ListTile(
                    title: Text('Name'.tr() +
                        ' : ' +
                        (snapshot.data.snapshot.value[key]['name'] ?? '')),
                  ),
                  ListTile(
                    title: Text('Email'.tr() +
                        ' : ' +
                        snapshot.data.snapshot.value[key]['email']),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Container(
              child: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          } else {
            return UploadDialog(warning: 'Fetching'.tr());
          }
        },
      ),
    );
  }
}
