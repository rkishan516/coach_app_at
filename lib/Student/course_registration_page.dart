import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/Utils/Colors.dart';
import 'package:coach_app/Utils/SizeConfig.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CourseDetails extends StatelessWidget {
  final String courseName;
  final String courseId;
  final DatabaseReference ref;

  CourseDetails(
      {@required this.courseName, @required this.courseId, @required this.ref});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: sizeConfig.screenHeight * 0.5125,
                  width: sizeConfig.screenWidth,
                  color: Colors.grey,
//child:Image.asset('images/pre.png',height:sizeConfig.screenHeight * 0.5125,width: sizeConfig.screenWidth,),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: sizeConfig.screenWidth * 0.036,
                      vertical: sizeConfig.screenHeight * 0.01),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: sizeConfig.screenHeight * 0.01,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: sizeConfig.screenWidth * 0.05,
                            ),
                          ),
                          SizedBox(
                            width: sizeConfig.screenWidth * 0.04,
                          ),
                          Text(
                            this.courseName,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: sizeConfig.screenWidth * 0.05),
                          ),
                        ],
                      ),
                      SizedBox(height: sizeConfig.screenHeight * 0.034),
                      Text(
                        courseName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: sizeConfig.screenWidth * 0.08333,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'New',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: sizeConfig.screenWidth * 0.027778,
                        ),
                      ),
                      SizedBox(
                        height: sizeConfig.screenHeight * 0.059375,
                      ),
                      Container(
                        width: sizeConfig.screenWidth * 0.8,
                        child: Column(
                          children: [
                            StreamBuilder<Event>(
                              stream: ref.child('description').onValue,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return PlaceholderLines(
                                    count: 1,
                                  );
                                }
                                return Text(
                                  snapshot.data.snapshot.value,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: sizeConfig.screenWidth * 0.03333,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              height: sizeConfig.screenHeight * 0.45,
              padding: EdgeInsets.symmetric(
                horizontal: sizeConfig.screenWidth * 0.05277778,
                vertical: sizeConfig.screenHeight * 0.0234375,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'This Course Includes : ',
                    style:
                        TextStyle(fontSize: sizeConfig.screenWidth * 0.038889),
                  ),
                  SizedBox(
                    height: sizeConfig.screenHeight * 0.0275,
                  ),
                  Row(
                    children: [
                      Icon(
                        MdiIcons.youtube,
                        size: sizeConfig.screenWidth * 0.05,
                        color: GuruCoolLightColor.primaryColor,
                      ),
                      SizedBox(
                        width: sizeConfig.screenWidth * 0.061111,
                      ),
                      Text(
                        '24 Hours On-Demand Video Lectures',
                        style: TextStyle(
                            fontSize: sizeConfig.screenWidth * 0.0389),
                      )
                    ],
                  ),
                  SizedBox(
                    height: sizeConfig.screenHeight * 0.02,
                  ),
                  Row(
                    children: [
                      Icon(
                        MdiIcons.clock,
                        size: sizeConfig.screenWidth * 0.05,
                        color: GuruCoolLightColor.primaryColor,
                      ),
                      SizedBox(
                        width: sizeConfig.screenWidth * 0.061111,
                      ),
                      Text(
                        'Quizzes and Pdf Notes',
                        style: TextStyle(
                            fontSize: sizeConfig.screenWidth * 0.0389),
                      )
                    ],
                  ),
                  SizedBox(
                    height: sizeConfig.screenHeight * 0.02,
                  ),
                  Row(
                    children: [
                      Icon(
                        MdiIcons.mapMarker,
                        size: sizeConfig.screenWidth * 0.05,
                        color: GuruCoolLightColor.primaryColor,
                      ),
                      SizedBox(
                        width: sizeConfig.screenWidth * 0.061111,
                      ),
                      Text(
                        'Access From Anywhere',
                        style: TextStyle(
                            fontSize: sizeConfig.screenWidth * 0.0389),
                      )
                    ],
                  ),
                  SizedBox(
                    height: sizeConfig.screenHeight * 0.02,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.book,
                        size: sizeConfig.screenWidth * 0.05,
                        color: GuruCoolLightColor.primaryColor,
                      ),
                      SizedBox(
                        width: sizeConfig.screenWidth * 0.061111,
                      ),
                      Text(
                        'Pre-available book libraries',
                        style: TextStyle(
                            fontSize: sizeConfig.screenWidth * 0.0389),
                      )
                    ],
                  ),
                  SizedBox(
                    height: sizeConfig.screenHeight * 0.02,
                  ),
                  Row(
                    children: [
                      Icon(
                        MdiIcons.youtube,
                        size: sizeConfig.screenWidth * 0.05,
                        color: GuruCoolLightColor.primaryColor,
                      ),
                      SizedBox(
                        width: sizeConfig.screenWidth * 0.061111,
                      ),
                      Text(
                        'Assignments',
                        style: TextStyle(
                            fontSize: sizeConfig.screenWidth * 0.0389),
                      )
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          print('Add Session');
                        },
                        color: GuruCoolLightColor.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              sizeConfig.screenWidth * 0.01389),
                        ),
                        elevation: 5,
                        minWidth: sizeConfig.screenWidth * 0.444,
                        child: Text(
                          'Enroll Now',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            letterSpacing: sizeConfig.b * 0.0364,
                            fontSize: sizeConfig.screenWidth * 0.0389,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
