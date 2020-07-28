import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

class MidAdminProfile extends StatelessWidget {
  final DatabaseReference databaseReference;
  MidAdminProfile({this.databaseReference});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<Event>(
          stream: databaseReference.onValue,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return UploadDialog(warning: 'Fetching'.tr());
            }
            MidAdmin midAdmin = MidAdmin.fromJson(snapshot.data.snapshot.value);
            return Column(
              children: <Widget>[
                Container(
                  height: SizeConfig.v * 23, //10 for example
                  width: SizeConfig.b * 100, //10 for example
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 243, 107, 40),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(SizeConfig.b * 11.31),
                        bottomLeft: Radius.circular(SizeConfig.b * 11.31)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: SizeConfig.v * 0.331),
                      Center(
                        child: Text("MID ADMIN PROFILE",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.b * 5.5,
                            )),
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: SizeConfig.v * 0.475,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    midAdmin.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: SizeConfig.b * 6),
                                    maxLines: 3,
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.v * 0.98,
                                ),
                                Container(
                                  child: Text(
                                    midAdmin.email,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: SizeConfig.b * 4.3),
                                    maxLines: 3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.fromLTRB(
                                  SizeConfig.b * 3.77,
                                  SizeConfig.v * 1.25,
                                  SizeConfig.b * 7.77,
                                  SizeConfig.v * 1.25),
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: CircleAvatar(
                                radius: SizeConfig.b * 11.1,
                                backgroundImage: midAdmin.photoUrl == null
                                    ? null
                                    : NetworkImage(midAdmin.photoUrl),
                                child: midAdmin.photoUrl == null
                                    ? Text(
                                        '${midAdmin?.name[0].toUpperCase()}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: SizeConfig.b * 5.53,
                                        ),
                                      )
                                    : null,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.v * 4.1),
                SizedBox(height: SizeConfig.v * 4.42),
                Container(
                  width: SizeConfig.b * 53,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 243, 106, 38),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        SizeConfig.b * 7,
                      ),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: SizeConfig.v * 0.95),
                      Text("Branches",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.b * 5.5)),
                      SizedBox(height: SizeConfig.v * 0.271),
                      Divider(
                        color: Colors.white,
                        thickness: SizeConfig.v * 0.475,
                      ),
                      SizedBox(
                        height: SizeConfig.v * 0.136,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: midAdmin.branches
                            .replaceAll('[', '')
                            .replaceAll(']', '')
                            .split(',')
                            .length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: <Widget>[
                              SizedBox(
                                width: SizeConfig.b * 6.8,
                              ),
                              Text(
                                " ${index + 1}",
                                style: TextStyle(
                                  fontSize: SizeConfig.b * 9,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.b * 4.8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    " ${midAdmin.branches.replaceAll('[', '').replaceAll(']', '').split(',')[index]}",
                                    style: TextStyle(
                                      fontSize: SizeConfig.b * 3.5,
                                      color: Colors.black,
                                    ),
                                  ),
                                  StreamBuilder<Event>(
                                    stream: databaseReference
                                        .parent()
                                        .parent()
                                        .child(
                                            "branches/${midAdmin.branches.replaceAll('[', '').replaceAll(']', '').split(',')[index]}/name")
                                        .onValue,
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      }
                                      return Text(
                                        " ${snapshot.data.snapshot.value}",
                                        style: TextStyle(
                                          fontSize: SizeConfig.b * 3.5,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.v * 4.136,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.v * 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: SizeConfig.b * 5.42),
                    Icon(Icons.location_on, size: SizeConfig.v * 3.8),
                    SizedBox(width: SizeConfig.b * 3.3),
                    Text(
                      "District : ",
                      style: TextStyle(fontSize: SizeConfig.b * 4.53),
                    ),
                    Container(
                      width: SizeConfig.b * 51,
                      alignment: AlignmentDirectional.centerStart,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          midAdmin.district,
                          style: TextStyle(
                            fontSize: SizeConfig.b * 4.93,
                            color: Color.fromARGB(255, 243, 106, 38),
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.v * 0.98,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
