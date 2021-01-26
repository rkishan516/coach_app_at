import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/Student/Old/course_registration_page.dart';
import 'package:coach_app/Utils/Colors.dart';
import 'package:coach_app/Utils/SizeConfig.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AllCoursePage extends StatelessWidget {
  final DatabaseReference ref;
  AllCoursePage({@required this.ref});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        backgroundColor: Colors.white,
        // leading: IconButton(
        //     icon: Icon(
        //       Icons.menu,
        //       color: GuruCoolLightColor.primaryColor,
        //     ),
        //     onPressed: () {}),
        title: Transform(
          transform:
              Matrix4.translationValues(-sizeConfig.screenWidth * 0.06, 0, 0),
          child: StreamBuilder<Event>(
              stream: ref.child('/name').onValue,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return PlaceholderLines(
                    count: 0,
                  );
                } else {
                  return Text(
                    snapshot.data.snapshot.value,
                    style: TextStyle(
                      color: GuruCoolLightColor.primaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: sizeConfig.screenWidth * 0.045,
                    ),
                  );
                }
              }),
        ),
        actions: [
          Row(children: [
            IconButton(
                icon: Icon(Icons.notifications_none,
                    color: GuruCoolLightColor.primaryColor),
                onPressed: () {}),
            CircleAvatar(
                backgroundColor: Color(0xffA4A4A4),
//backgroundImage: (),
                radius:
                    sizeConfig.screenWidth * 0.0862 / 2), //to pass the imageUrl
            SizedBox(width: sizeConfig.screenWidth * 0.025)
          ])
        ],
      ),
      body: Container(
        padding:
            EdgeInsets.symmetric(horizontal: sizeConfig.screenWidth * 0.08611),
        color: Color(0xffE5E5E5),
        child: Column(
          children: [
            SizedBox(height: sizeConfig.screenHeight * 0.05),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: StreamBuilder<Event>(
                  stream: ref.child('/coursesList').onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Map<String, String> courses = Map<String, String>();
                      snapshot.data.snapshot.value?.forEach((k, v) {
                        courses[k] = v;
                      });
                      return GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: sizeConfig.screenWidth * 0.07,
                          mainAxisSpacing: sizeConfig.screenHeight * 0.034375,
                          crossAxisCount: 2,
                        ),
                        itemCount: courses.length,
                        itemBuilder: (BuildContext ctxt, int ind) {
                          String index = courses.keys.toList()[ind];
                          return Container(
                            padding: EdgeInsets.only(left: sizeConfig.b * 3),
                            height: sizeConfig.screenHeight * 0.215625,
                            width: sizeConfig.screenWidth * 0.3833,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0.0, 2),
                                  spreadRadius: sizeConfig.b * 0.4,
                                  blurRadius: sizeConfig.b * 0.5,
                                ),
                              ],
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(sizeConfig.b * 5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
//Image.asset('images/buk.png'),
                                    ]),
                                Spacer(),
                                Text(
                                  courses[index],
                                  style: TextStyle(
                                    fontSize: sizeConfig.screenWidth * 0.056,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Transform(
                                      transform: Matrix4.translationValues(0,
                                          -sizeConfig.screenHeight * 0.025, 0),
                                      child: IconButton(
                                        icon: Icon(Icons.arrow_right,
                                            color: GuruCoolLightColor
                                                .primaryColor),
                                        padding: EdgeInsets.zero,
                                        iconSize: sizeConfig.b * 6,
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CourseRegistrationPage(
                                                courseID: index,
                                                name: courses[index],
                                                ref:
                                                    ref.child('courses/$index'),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: sizeConfig.screenWidth * 0.07,
                          mainAxisSpacing: sizeConfig.screenHeight * 0.034375,
                          crossAxisCount: 2,
                        ),
                        itemCount: 5,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Container(
                            padding: EdgeInsets.only(left: sizeConfig.b * 3),
                            height: sizeConfig.screenHeight * 0.215625,
                            width: sizeConfig.screenWidth * 0.3833,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0.0, 2),
                                  spreadRadius: sizeConfig.b * 0.4,
                                  blurRadius: sizeConfig.b * 0.5,
                                ),
                              ],
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(sizeConfig.b * 5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
//Image.asset('images/buk.png'),
                                    ]),
                                Spacer(),
                                PlaceholderLines(
                                  count: 2,
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
