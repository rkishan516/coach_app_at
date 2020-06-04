import 'package:coach_app/InstituteAdmin/studentList.dart';
import 'package:coach_app/InstituteAdmin/teachersPage.dart';
import 'package:coach_app/adminSection/adminCoursePage.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';

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
          : (_bottomNavIndex == 1) ? StudentList() : TeachersList(),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(iconData: Icons.library_books, title: "Courses"),
          TabData(iconData: Icons.school, title: "Student"),
          TabData(iconData: Icons.person, title: "Teachers")
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
