import 'package:coach_app/InstituteAdmin/studentList.dart';
import 'package:coach_app/InstituteAdmin/teachersPage.dart';
import 'package:coach_app/adminSection/adminCoursePage.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:coach_app/Utils/Colors.dart';
import 'package:easy_localization/easy_localization.dart';

class BranchPage extends StatefulWidget {
  @override
  _BranchPageState createState() => _BranchPageState();
}

class _BranchPageState extends State<BranchPage>
    with SingleTickerProviderStateMixin {
  int _bottomNavIndex = 0;
  final List<IconData> iconList = <IconData>[
    Icons.library_books,
    Icons.school,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_bottomNavIndex == 0)
          ? AdminCoursePage()
          : (_bottomNavIndex == 1)
              ? StudentList()
              : TeachersList(),
      bottomNavigationBar: FancyBottomNavigation(
        barBackgroundColor: GuruCoolLightColor.primaryColor,
        circleColor: GuruCoolLightColor.whiteColor,
        activeIconColor: GuruCoolLightColor.primaryColor,
        textColor: GuruCoolLightColor.whiteColor,
        inactiveIconColor: GuruCoolLightColor.whiteColor,
        tabs: [
          TabData(iconData: Icons.library_books, title: "Courses".tr()),
          TabData(iconData: Icons.school, title: "Student".tr()),
          TabData(iconData: Icons.person, title: "Teachers".tr())
        ],
        onTabChangedListener: (pos) {
          setState(() {
            _bottomNavIndex = pos;
          });
        },
      ),
    );
  }
}
