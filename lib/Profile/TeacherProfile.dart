import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Utils/Colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double b;
  static double v;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    b = (screenWidth - _safeAreaHorizontal) / 100;
    v = (screenHeight - _safeAreaVertical) / 100;
  }
}

class TeacherProfilePage extends StatelessWidget {
  final DatabaseReference reference;
  TeacherProfilePage({@required this.reference});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: getAppBar(context),
      body: StreamBuilder<Event>(
          stream: reference.onValue,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return UploadDialog(warning: 'Fetching'.tr());
            }
            Teacher teacher = Teacher.fromJson(snapshot.data.snapshot.value);
            return SafeArea(
              child: Column(
                children: <Widget>[
                  Container(
                    height: SizeConfig.v * 22, //10 for example
                    width: SizeConfig.b * 100,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 125, 72),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(SizeConfig.b * 11.31),
                          bottomLeft: Radius.circular(SizeConfig.b * 11.31)),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "${teacher.name}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: GuruCoolLightColor.whiteColor,
                                      fontSize: SizeConfig.b * 7.5),
                                  maxLines: 3,
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.v * 0.98,
                              ),
                              Container(
                                child: Text(
                                  "${teacher.email}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: GuruCoolLightColor.whiteColor,
                                      fontSize: SizeConfig.b * 4.8),
                                  maxLines: 3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                SizeConfig.b * 3.77,
                                SizeConfig.v * 4.25,
                                SizeConfig.b * 3.77,
                                SizeConfig.v * 4.25),
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: CircleAvatar(
                              radius: SizeConfig.b * 20.1,
                              backgroundColor: Color(0xffe6783e),
                              backgroundImage: teacher.photoURL == null
                                  ? null
                                  : NetworkImage(teacher.photoURL),
                              child: teacher.photoURL == null
                                  ? Text(
                                      '${teacher?.name[0].toUpperCase()}',
                                      style: TextStyle(
                                        color: GuruCoolLightColor.whiteColor,
                                        fontSize: 22,
                                      ),
                                    )
                                  : null,
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.v * 4.1),
                  if (teacher.courses != null)
                    Container(
                      height: SizeConfig.screenHeight / 2.9,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: teacher.courses.length,
                          itemBuilder: (context, courseIndex) {
                            return StreamBuilder<Event>(
                                stream: reference
                                    .parent()
                                    .parent()
                                    .child(
                                        "courses/${teacher.courses[courseIndex].id}")
                                    .onValue,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Container();
                                  }
                                  if (snapshot.data.snapshot.value == null) {
                                    return Container();
                                  }
                                  Courses course = Courses.fromJson(
                                      snapshot.data.snapshot.value);
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: SizeConfig.b * 58,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 243, 106, 38),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(
                                          SizeConfig.b * 7,
                                        )),
                                      ),
                                      child: ListView(
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          SizedBox(height: SizeConfig.v * 0.95),
                                          Text(course?.name ?? '',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: GuruCoolLightColor
                                                      .whiteColor,
                                                  fontSize:
                                                      SizeConfig.b * 5.5)),
                                          SizedBox(
                                              height: SizeConfig.v * 0.271),
                                          Divider(
                                            color:
                                                GuruCoolLightColor.whiteColor,
                                            thickness: SizeConfig.v * 0.475,
                                          ),
                                          SizedBox(
                                            height: SizeConfig.v * 0.136,
                                          ),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            controller: ScrollController(),
                                            itemCount: teacher
                                                    .courses[courseIndex]
                                                    .subjects
                                                    ?.length ??
                                                0,
                                            itemBuilder: (context, index) {
                                              return Row(
                                                children: <Widget>[
                                                  SizedBox(
                                                    width: SizeConfig.b * 6.8,
                                                  ),
                                                  Text(
                                                    " ${index + 1}",
                                                    style: TextStyle(
                                                      fontSize:
                                                          SizeConfig.b * 9,
                                                      color: GuruCoolLightColor
                                                          .whiteColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: SizeConfig.b * 4.8,
                                                  ),
                                                  Text(
                                                    course
                                                            .subjects[teacher
                                                                .courses[
                                                                    courseIndex]
                                                                .subjects[index]]
                                                            ?.name ??
                                                        'Subject deleted',
                                                    style: TextStyle(
                                                      fontSize:
                                                          SizeConfig.b * 5,
                                                      color: GuruCoolLightColor
                                                          .whiteColor,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                          SizedBox(
                                              height: SizeConfig.v * 4.271),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }),
                    ),
                  SizedBox(height: SizeConfig.v * 4.42),
                  Container(
                    height: SizeConfig.v * 12, //10 for example
                    width: SizeConfig.b * 100,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(width: SizeConfig.b * 5.42),
                            Icon(Icons.school, size: SizeConfig.v * 4.4),
                            SizedBox(width: SizeConfig.b * 3.3),
                            Text(
                              "Qualification: ",
                              style: TextStyle(fontSize: SizeConfig.b * 4.53),
                            ),
                            Container(
                              width: SizeConfig.b * 51,
                              alignment: AlignmentDirectional.centerStart,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  " ${teacher.qualification}",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(width: SizeConfig.b * 8.42),
                            Icon(
                              Icons.business_center,
                              size: SizeConfig.v * 4.4,
                            ),
                            SizedBox(width: SizeConfig.b * 3.27),
                            Text(
                              "Experience:",
                              style: TextStyle(fontSize: SizeConfig.b * 4.53),
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  " ${teacher.experience} years",
                                  style: TextStyle(
                                    fontSize: SizeConfig.b * 4.93,
                                    color: Color.fromARGB(255, 243, 106, 38),
                                  ),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.v * 0.4),
                  if (FireBaseAuth.instance.previlagelevel != 2)
                    Container(
                        //width:275,
                        height: SizeConfig.v * 8.5, //10 for example
                        width: SizeConfig.b * 70,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Contact no. : ${teacher?.phoneNo ?? "Not Given"}",
                                  style:
                                      TextStyle(fontSize: SizeConfig.b * 4.55),
                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.v * 1.21),
                            if (teacher.phoneNo != null)
                              Container(
                                  width: SizeConfig.b * 37.7,
                                  alignment: AlignmentDirectional.center,
                                  height: SizeConfig.v * 4.25,
                                  child: RaisedButton(
                                    child: Icon(
                                      Icons.call,
                                      color: GuruCoolLightColor.whiteColor,
                                      size: SizeConfig.v * 4.2,
                                    ),
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          SizeConfig.v * 2.04),
                                    ),
                                    color: Color.fromARGB(255, 243, 106, 38),
                                    onPressed: () async {
                                      String url = 'tel:${teacher.phoneNo}';
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                  ))
                          ],
                        ))
                ],
              ),
            );
          }),
    );
  }
}
