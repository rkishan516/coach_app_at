
import 'package:coach_app/InstituteAdmin/bottom_navigation_bar.dart';
import 'package:coach_app/InstituteAdmin/studentList.dart';
import 'package:coach_app/InstituteAdmin/teachersPage.dart';
import 'package:coach_app/adminSection/adminCoursePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  AnimationController _animationController;
  Animation<double> animation;
  CurvedAnimation curve;

  @override
  initState() {
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: HexColor('#373A36'),
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
      () => _animationController.forward(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_bottomNavIndex == 0) ? AdminCoursePage() : (_bottomNavIndex == 1) ? StudentList() : TeachersList(),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        backgroundColor: HexColor('#373A36'),
        activeIndex: _bottomNavIndex,
        activeColor: HexColor('#FFA400'),
        splashColor: HexColor('#FFA400'),
        inactiveColor: Colors.white,
        notchAndCornersAnimation: animation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.none,
        // leftCornerRadius: 32,
        // rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }
}
