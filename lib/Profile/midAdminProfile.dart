import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MidAdminProfile extends StatefulWidget {
  final DatabaseReference databaseReference;
  MidAdminProfile({this.databaseReference});
  @override
  _MidAdminProfileState createState() => _MidAdminProfileState();
}

class _MidAdminProfileState extends State<MidAdminProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mid Admin Profile'),
      ),
      body: StreamBuilder<Event>(
        stream: widget.databaseReference.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            MidAdmin midAdmin = MidAdmin.fromJson(snapshot.data.snapshot.value);
            return Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  if (snapshot.data.snapshot.value['photoUrl'] != null)
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        snapshot.data.snapshot.value['photoUrl'],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Name'.tr() + ' : ' + midAdmin.name),
                  ),
                  ListTile(
                    title: Text('Email'.tr() + ' : ' + midAdmin.email),
                  ),
                  ListTile(
                    title: Text('District'.tr() + ' : ' + midAdmin.district),
                  ),
                  ListTile(
                    title: Text('Branches'.tr() +
                        ' : ' +
                        midAdmin.branches
                            .replaceAll('[', '')
                            .replaceAll(']', '')),
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
