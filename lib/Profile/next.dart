import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class TeacherProfilePage extends StatelessWidget {
  final DatabaseReference reference;
  TeacherProfilePage({@required this.reference});
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF36C24),
        title: Text('Profile'.tr()),
        centerTitle: false,
        elevation: 0.0,
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
        child: StreamBuilder<Event>(
          stream: reference.onValue,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return UploadDialog(warning: 'Fetching'.tr());
            }
            Teacher teacher = Teacher.fromJson(snapshot.data.snapshot.value);
            print(teacher.phoneNo);
            return Center(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: CircleAvatar(
                      radius: _width / 5,
                      backgroundColor: Color(0xffe6783e),
                      backgroundImage: teacher.photoURL == null
                          ? null
                          : NetworkImage(teacher.photoURL),
                      child: teacher.photoURL == null
                          ? Text(
                              '${teacher?.name[0].toUpperCase()}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            )
                          : null,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          '${teacher.name}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: _width / 15,
                          ),
                        ),
                        Text(
                          '${teacher.email}',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: _width / 25,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        FlatButton.icon(
                          icon: Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.only(left: 50, right: 50),
                          color: Color(0xffe6783e),
                          onPressed: () async {
                            String url = 'tel:${teacher.phoneNo}';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          label: Text(
                            teacher.phoneNo,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Text(
                          'Qualification'.tr() + ': ${teacher?.qualification}',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: _width / 25,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          color: Color(0xffe6783e),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 8, bottom: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.assignment_turned_in,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: _width / 30,
                                ),
                                Text(
                                  '${teacher?.experience} ' +
                                      'Years of Experience'.tr(),
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  )
                ], //
              ),
            );
          },
        ),
      ),
    );
  }
}
