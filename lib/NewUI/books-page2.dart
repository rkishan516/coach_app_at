import 'package:coach_app/InstituteAdmin/studentList.dart';
import 'package:coach_app/TimeTableSection/TimeTablePage.dart';
import 'package:coach_app/Utils/Colors.dart';
import 'package:coach_app/Utils/SizeConfig.dart';
import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

SizeConfig size;

class AdminSubjectPage extends StatelessWidget {
  final String courseId;
  final passKey;
  AdminSubjectPage({@required this.courseId, @required this.passKey});

  @override
  Widget build(BuildContext context) {
    size = SizeConfig(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: GuruCoolLightColor.primaryColor,
            ),
            onPressed: () {
              print('Show menu');
            },
          ),
          title: Text(
            'Central Public Delhi',
            style: TextStyle(
              color: GuruCoolLightColor.primaryColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: GuruCoolLightColor.primaryColor,
              ),
              onPressed: () {
                print('Notification');
              },
            )
          ],
          bottom: TabBar(
            indicatorColor: GuruCoolLightColor.primaryColor,
            labelPadding: EdgeInsets.zero,
            labelColor: GuruCoolLightColor.primaryColor,
            unselectedLabelColor: Color(0xff858A8F),
            tabs: [
              Tab(
                child: Text(
                  'Subject',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: size.b * 3.8,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Student',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w400, fontSize: size.b * 3.8),
                ),
              ),
              Tab(
                child: Text(
                  'Time-Table',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w400, fontSize: size.b * 3.8),
                ),
              ),
              Tab(
                child: Text(
                  'Library',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w400, fontSize: size.b * 3.8),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: size.b * 1.75,
          unselectedFontSize: size.b * 1.75,
          selectedItemColor: GuruCoolLightColor.primaryColor,
          iconSize: size.b * 7,
          unselectedItemColor: Color(0xff999999),
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
            BottomNavigationBarItem(
                icon: Icon(Icons.view_week_rounded), label: 'COURSES'),
            BottomNavigationBarItem(
                icon: Icon(MdiIcons.viewGrid), label: 'MODULES'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance), label: 'MY INSTITUTE'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box), label: 'PROFILE'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialogueBox(context),
          child: Icon(
            Icons.add,
            size: size.b * 8.9,
            color: Colors.white,
          ),
          backgroundColor: Color(0xff2E3842),
        ),
        body: TabBarView(
          children: [
            Container(
              color: Color(0xffE5E5E5),
              child: Center(
                child: Text('Subject'),
              ),
            ),
            StudentList(
              courseId: courseId,
            ),
            TimeTablePage(
              courseId: courseId,
            ),
            Library(),
          ],
        ),
      ),
    );
  }

  void showDialogueBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: EdgeInsets.all(size.b * 3.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size.b * 4),
            ),
            child: Container(
              padding: EdgeInsets.all(size.b * 2.5),
              height: size.screenHeight * 0.235,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: size.b * 3.8),
                    padding: EdgeInsets.only(left: size.b * 2.5),
                    width: size.screenWidth * 1.2,
                    height: size.screenHeight * 0.05,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff999999)),
                        borderRadius: BorderRadius.circular(size.b * 1.2)),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Add Link',
                          hintStyle: TextStyle(
                              color: Color(0xff717171),
                              fontSize: size.b * 3.8,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: size.b * 4),
                    padding: EdgeInsets.only(left: size.b * 2.5),
                    width: size.screenWidth * 1.2,
                    height: size.screenHeight * 0.05,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff999999)),
                        borderRadius: BorderRadius.circular(size.b * 1.2)),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Add Title',
                          hintStyle: TextStyle(
                              color: Color(0xff717171),
                              fontSize: size.b * 3.8,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          print('Add book');
                        },
                        fillColor: Color(0xffEF7334),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(size.b * 1.2)),
                        child: Text(
                          'Add Book',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: size.b * 3.85),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

class Library extends StatelessWidget {
  final TextEditingController _searchInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xffE5E5E5),
        child: Column(
          children: [
            SizedBox(height: size.v * 4),
            Container(
              width: size.screenWidth * 0.85,
              height: size.screenHeight * 0.06,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: size.b * 0.8,
                      blurRadius: size.b * 1.5,
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(size.b * 7)),
              child: Row(
                children: [
                  SizedBox(width: size.b * 2.2),
                  Icon(Icons.search, color: GuruCoolLightColor.primaryColor),
                  SizedBox(
                    width: size.b * 2,
                  ),
                  Container(
                    color: Colors.white,
                    width: size.b * 68,
                    child: TextField(
                      controller: _searchInputController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search books by their name',
                          hintStyle: TextStyle(
                              fontSize: size.b * 3.5,
                              color: Color.fromRGBO(140, 140, 140, 0.71),
                              fontWeight: FontWeight.w400)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: size.b * 6.5),
            Expanded(
                child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: 10,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.b * 4, vertical: size.v * 2),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(size.b * 2.5)),
                            elevation: 7,
                            child: Stack(
                              children: [
                                CustomPaint(
                                  size: Size(size.b * 200, size.b * 100),
                                  painter: RPSCustomPainter(),
                                ),
                                Positioned(
                                  top: size.b * 2.5,
                                  left: size.b * 2.5,
                                  child: Text(
                                    'Title',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: size.b * 4.2),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            icon: Icon(
                                                Icons.star_border_outlined),
                                            color: Color(0xff999999),
                                            onPressed: () => print('Star')),
                                        IconButton(
                                            icon: Icon(Icons.arrow_forward),
                                            color: Color(0xff3F586E),
                                            iconSize: size.b * 6.2,
                                            onPressed: () {
                                              print('Forward');
                                            })
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        })))
          ],
        ));
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color(0xff2E3944)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.08);
    path_0.quadraticBezierTo(
        size.width * 0.00, size.height * -0.00, size.width * 0.08, 0);
    path_0.lineTo(size.width * 0.90, 0);
    path_0.quadraticBezierTo(
        size.width * 1.00, size.height * -0.00, size.width, size.height * 0.08);
    path_0.cubicTo(size.width * 0.94, size.height * 0.56, size.width * 0.36,
        size.height * 0.17, 0, size.height * 0.68);
    path_0.cubicTo(
        0, size.height * 0.53, 0, size.height * 0.53, 0, size.height * 0.08);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
