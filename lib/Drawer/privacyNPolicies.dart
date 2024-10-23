import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final dbRef = FirebaseDatabase.instance;
  Map<dynamic, dynamic> _hashMap = Map<dynamic, dynamic>();
  List<PrivacyModal> _list = [];
  _loadFromDatabase() {
    dbRef.ref().child('privacyPolicy').orderByKey().once().then((value) {
      _hashMap = value.snapshot.value! as Map;
      _hashMap.forEach((key, value) {
        _list.add(PrivacyModal(key, value['heading'], value['subTitle']));
      });
      setState(() {
        _list.sort((a, b) => int.parse(a.key.substring(4, a.key.length))
            .compareTo(int.parse(b.key.substring(4, b.key.length))));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy & Policy'.tr()),
      ),
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              _list[index].heading,
              style: TextStyle(fontSize: 14.0),
            ),
            subtitle: Text(
              _list[index].subtitile,
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
          );
        },
      ),
    );
  }
}
