import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SizeConfig {
  MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double b;
  static double v;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData.size.height;
    screenWidth = _mediaQueryData.size.width;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;

    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

    b = (screenWidth - _safeAreaHorizontal) / 100;
    v = (screenHeight - _safeAreaVertical) / 100;
  }
}

const Color gc = Color(0xffF36C24);

class Home extends StatelessWidget {
  TextEditingController _searchInputController = new TextEditingController();
  List<Item> itemList;
  List<Item> selectedList;

  @override
  void initState() {
    loadList();
  }

  loadList() {
    itemList = List();
    selectedList = List();
    itemList.add(Item("images/d.png", 1, "Suraj Sisodia"));
    itemList.add(Item("images/d.png", 2, "Ritesh Shukla"));
    itemList.add(Item("images/d.png", 3, "C.V Raman"));
    itemList.add(Item("images/d.png", 4, "C.V Raman"));
    itemList.add(Item("images/d.png", 5, "C.V Raman"));
    itemList.add(Item("images/d.png", 6, "C.V Raman"));
    itemList.add(Item("images/d.png", 7, "C.V Raman"));
    itemList.add(Item("images/d.png", 8, "C.V Raman"));
    itemList.add(Item("images/d.png", 9, "C.V Raman"));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Color(0xffF36C24),
                ),
                onPressed: () {
                  print('Show menu');
                }),
            title: Text(
              'Central Public Delhi',
              style: TextStyle(
                  color: Color(0xffF36C24), fontWeight: FontWeight.w400),
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.notifications_none,
                    color: Color(0xffF36C24),
                  ),
                  onPressed: () {
                    print('Notification');
                  })
            ],
            bottom: TabBar(
                indicatorColor: Color(0xffF36C24),
                labelPadding: EdgeInsets.zero,
                labelColor: Color(0xffF36C24),
                unselectedLabelColor: Color(0xff858A8F),
                tabs: [
                  Tab(
                    child: Text(
                      'Subject',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: SizeConfig.b * 3.8,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Student',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: SizeConfig.b * 3.8),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Time-Table',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: SizeConfig.b * 3.8),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Library',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: SizeConfig.b * 3.8),
                    ),
                  ),
                ]),
          ),
          bottomNavigationBar: BottomNavigationBar(
              selectedFontSize: SizeConfig.b * 1.75,
              unselectedFontSize: SizeConfig.b * 1.75,
              selectedItemColor: Color(0xffF36C24),
              iconSize: SizeConfig.b * 7,
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
              ]),
          floatingActionButton: FloatingActionButton(
            onPressed: () => showDialogueBox(context),
            child: Icon(
              Icons.add,
              size: SizeConfig.b * 8.9,
              color: Colors.white,
            ),
            backgroundColor: Color(0xff2E3842),
          ),
          body: TabBarView(children: [
            Container(
              color: Color(0xffE5E5E5),
              child: Center(
                child: Text('Subject'),
              ),
            ),
            Container(
              color: Color(0xffE5E5E5),
              child: Center(
                child: Text('Student'),
              ),
            ),
            Container(
              color: Color(0xffE5E5E5),
              child: Center(
                child: Text('Time-Table'),
              ),
            ),
            Container(
                color: Color(0xffE5E5E5),
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.v * 4),
                    Container(
                      width: SizeConfig.screenWidth * 0.85,
                      height: SizeConfig.screenHeight * 0.06,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: SizeConfig.b * 0.8,
                              blurRadius: SizeConfig.b * 1.5,
                            )
                          ],
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(SizeConfig.b * 7)),
                      child: Row(
                        children: [
                          SizedBox(width: SizeConfig.b * 2.2),
                          Icon(Icons.search, color: gc),
                          SizedBox(
                            width: SizeConfig.b * 2,
                          ),
                          Container(
                            color: Colors.white,
                            width: SizeConfig.b * 68,
                            child: TextField(
                              controller: _searchInputController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search books by their name',
                                  hintStyle: TextStyle(
                                      fontSize: SizeConfig.b * 3.5,
                                      color:
                                          Color.fromRGBO(140, 140, 140, 0.71),
                                      fontWeight: FontWeight.w400)),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.b * 6.5),
                    Expanded(
                        child: SingleChildScrollView(
                            physics: ScrollPhysics(),
                            child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemCount: 10,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return Card(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: SizeConfig.b * 4,
                                        vertical: SizeConfig.v * 2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            SizeConfig.b * 2.5)),
                                    elevation: 7,
                                    child: Stack(
                                      children: [
                                        CustomPaint(
                                          size: Size(SizeConfig.b * 200,
                                              SizeConfig.b * 100),
                                          painter: RPSCustomPainter(),
                                        ),
                                        Positioned(
                                          top: SizeConfig.b * 2.5,
                                          left: SizeConfig.b * 2.5,
                                          child: Text(
                                            'Title',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: SizeConfig.b * 4.2),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                IconButton(
                                                    icon: Icon(Icons
                                                        .star_border_outlined),
                                                    color: Color(0xff999999),
                                                    onPressed: () =>
                                                        print('Star')),
                                                IconButton(
                                                    icon: Icon(
                                                        Icons.arrow_forward),
                                                    color: Color(0xff3F586E),
                                                    iconSize:
                                                        SizeConfig.b * 6.2,
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
                )),
          ])),
    );
  }

  void showDialogueBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: EdgeInsets.all(SizeConfig.b * 3.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SizeConfig.b * 4),
            ),
            child: Container(
              padding: EdgeInsets.all(SizeConfig.b * 2.5),
              height: SizeConfig.screenHeight * 0.235,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.b * 3.8),
                    padding: EdgeInsets.only(left: SizeConfig.b * 2.5),
                    width: SizeConfig.screenWidth * 1.2,
                    height: SizeConfig.screenHeight * 0.05,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff999999)),
                        borderRadius:
                            BorderRadius.circular(SizeConfig.b * 1.2)),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Add Link',
                          hintStyle: TextStyle(
                              color: Color(0xff717171),
                              fontSize: SizeConfig.b * 3.8,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.b * 4),
                    padding: EdgeInsets.only(left: SizeConfig.b * 2.5),
                    width: SizeConfig.screenWidth * 1.2,
                    height: SizeConfig.screenHeight * 0.05,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff999999)),
                        borderRadius:
                            BorderRadius.circular(SizeConfig.b * 1.2)),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Add Title',
                          hintStyle: TextStyle(
                              color: Color(0xff717171),
                              fontSize: SizeConfig.b * 3.8,
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
                            borderRadius:
                                BorderRadius.circular(SizeConfig.b * 1.2)),
                        child: Text(
                          'Add Book',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: SizeConfig.b * 3.85),
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

class Item {
  String imageUrl;
  int rank;
  String name;
  Item(this.imageUrl, this.rank, this.name);
}

// class RPSCustomPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint_0 = new Paint()
//       ..color = Color.fromARGB(255, 33, 150, 243)
//       ..style = PaintingStyle.fill
//       ..strokeWidth = 1;

//     Path path_0 = Path();
//     path_0.moveTo(0, size.height * 0.68);
//     path_0.quadraticBezierTo(0, size.height * 0.17, 0, 0);
//     path_0.quadraticBezierTo(size.width * 0.75, 0, size.width, 0);
//     path_0.cubicTo(size.width * 0.90, size.height * 0.59, size.width * 0.29,
//         size.height * 0.18, 0, size.height * 0.68);
//     path_0.close();

//     canvas.drawPath(path_0, paint_0);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

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
