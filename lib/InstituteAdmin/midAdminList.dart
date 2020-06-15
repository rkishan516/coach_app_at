import 'dart:convert';

import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/GlobalFunction/SlideButton.dart';
import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/InstituteAdmin/addMidAdminPage.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class MidAdminList extends StatefulWidget {
  List<Map<String, String>> branches;
  MidAdminList({@required this.branches});
  @override
  _MidAdminListState createState() => _MidAdminListState();
}

class _MidAdminListState extends State<MidAdminList> {
  TextEditingController searchTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mid Admin List'.tr()),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchTextEditingController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Color(0xfff3f3f4),
                    ),
                  ),
                  contentPadding: EdgeInsets.only(left: 10),
                  hintStyle: TextStyle(fontSize: 15),
                  hintText: 'Search by MidAdmin name'.tr(),
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                ),
              ),
            ),
            Expanded(
              flex: 12,
              child: StreamBuilder<Event>(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child(
                        'institute/${FireBaseAuth.instance.instituteid}/midAdmin')
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, MidAdmin> midAdmins = Map<String, MidAdmin>();
                    snapshot.data.snapshot.value?.forEach((k, midAdmin) {
                      if (searchTextEditingController.text == '') {
                        midAdmins[k] = MidAdmin.fromJson(midAdmin);
                      } else {
                        MidAdmin sMidAdmin = MidAdmin.fromJson(midAdmin);
                        if (sMidAdmin.name
                            .contains(searchTextEditingController.text)) {
                          midAdmins[k] = sMidAdmin;
                        }
                      }
                    });
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: midAdmins?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              title: Text(
                                '${midAdmins[midAdmins.keys.toList()[index]].name}',
                                style: TextStyle(color: Color(0xffF36C24)),
                              ),
                              subtitle: Text(
                                '${midAdmins[midAdmins.keys.toList()[index]].email}',
                                style: TextStyle(color: Color(0xffF36C24)),
                              ),
                              onLongPress: () {
                                showCupertinoDialog(
                                  context: context,
                                  builder: (context) => MidAdminRegister(
                                    midAdmin: midAdmins[midAdmins.keys.toList()[index]],
                                    branches: widget.branches,
                                    keyM: midAdmins.keys.toList()[index],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            title: PlaceholderLines(
                              count: 1,
                              animate: true,
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SlideButtonR(
        text: 'Add Mid Admin'.tr(),
        onTap: () => showCupertinoDialog(
          context: context,
          builder: (context) => MidAdminRegister(branches: widget.branches),
        ),
        width: 180,
        height: 50,
      ),
    );
  }
}
