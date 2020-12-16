import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
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

class Home extends StatelessWidget {
  final CalendarController _calendarController = CalendarController();
  // Map<DateTime, List> _events;
  // List _selectedEvents;
  // List<MeetingDetails> listitems;
  final List<Item> itemList = List<Item>(); //managers
  loadList() {
    itemList.add(
        Item("UI discussion", "to discuss the possibilties of UI", "01:29"));
    itemList.add(
        Item("UI discussion", "to discuss the possibilties of UI", "01:29"));
    itemList.add(
        Item("UI discussion", "to discuss the possibilties of UI", "01:29"));
    itemList.add(
        Item("UI discussion", "to discuss the possibilties of UI", "01:29"));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        appBar: AppBar(
          elevation: SizeConfig.b * 2.5,
          titleSpacing: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color(0xff858A8F),
              ),
              onPressed: () {
                print('Back');
              }),
          backgroundColor: Colors.white,
          title: Text(
            'Arrange Meeting',
            style: TextStyle(
                color: Color(0xffF36C24),
                fontWeight: FontWeight.w400,
                fontSize: SizeConfig.b * 4.5),
          ),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(SizeConfig.b * 1.9),
                child: Column(
                  children: [
                    Card(
                      elevation: SizeConfig.b * 1.8,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(SizeConfig.b * 1.3)),
                      child: _buildTableCalender(),
                    ),
                    ConstrainedBox(
                        constraints: BoxConstraints(),
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: 1,
                            itemBuilder: (BuildContext ctxt, int index) {
                              return Card(
                                elevation: 7,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(SizeConfig.b * 1.3),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.b * 2.5,
                                      vertical: SizeConfig.v * 1.42),
                                  child: Row(
                                    children: [
                                      Row(children: [
                                        SizedBox(
                                          width: SizeConfig.b * 2.3,
                                        ),
                                        Icon(
                                          Icons.video_call,
                                          color: Color(0xffF36C24),
                                          size: SizeConfig.b * 7.2,
                                        ),
                                        SizedBox(
                                          width: SizeConfig.b * 3,
                                        ),
                                        Container(
                                          width: SizeConfig.screenWidth * 0.3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Meeting name',
                                                style: TextStyle(
                                                    fontSize:
                                                        SizeConfig.b * 3.89,
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing:
                                                        SizeConfig.b * 0.036,
                                                    color: Color(0xff1C1C1C)),
                                              ),
                                              SizedBox(
                                                  height: SizeConfig.v * 0.5),
                                              Text(
                                                'Description',
                                                style: TextStyle(
                                                    fontSize:
                                                        SizeConfig.b * 3.4,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff515151)),
                                              )
                                            ],
                                          ),
                                        )
                                      ]),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Text(
                                            '1:29',
                                            style: TextStyle(
                                                color: Color(0xff305275),
                                                fontWeight: FontWeight.w400,
                                                fontSize: SizeConfig.b * 4.9),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'PM',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: Color(0xff305275),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: SizeConfig.b * 2.8),
                                            ),
                                          ),
                                          SizedBox(width: SizeConfig.b * 2),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }))
                  ],
                ),
              ),
              Row(children: [
                Container(
                    color: Colors
                        .white, //to change color if the list is empty to grey
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.b * 5,
                        vertical: SizeConfig.v * 2),
                    width: SizeConfig.screenWidth,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: 4,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(children: [
                                        index ==
                                                3 //for those who are unattended
                                            ? CircleAvatar(
                                                radius: SizeConfig.b * 2.55,
                                                backgroundColor:
                                                    Color(0xff305275),
                                                child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    radius: SizeConfig.b * 2))
                                            : CircleAvatar(
                                                backgroundColor:
                                                    Color(0xff305275),
                                                radius: SizeConfig.b * 2.55),
                                        index == 3 //to remove last line
                                            ? Container()
                                            : Container(
                                                width: SizeConfig.b * .588,
                                                height:
                                                    SizeConfig.screenHeight *
                                                        0.063,
                                                color: Color(0xff305275)),
                                      ]),
                                      SizedBox(
                                        width: SizeConfig.b * 7,
                                      ),
                                      Container(
                                        width: SizeConfig.screenWidth * 0.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Meeting name',
                                              style: TextStyle(
                                                  fontSize: SizeConfig.b * 3.89,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing:
                                                      SizeConfig.b * 0.036,
                                                  color: Color(0xff1C1C1C)),
                                            ),
                                            Text(
                                              '5 Oct',
                                              style: TextStyle(
                                                  fontSize: SizeConfig.b * 3.4,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff515151)),
                                            ),
                                            SizedBox(height: SizeConfig.v * 2),
                                          ],
                                        ),
                                      )
                                    ]),
                                Spacer(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '1:54',
                                      style: TextStyle(
                                          color: Color(0xff305275),
                                          fontWeight: FontWeight.w400,
                                          fontSize: SizeConfig.b * 3.5),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'PM',
                                        style: TextStyle(
                                            color: Color(0xff305275),
                                            fontWeight: FontWeight.w400,
                                            fontSize: SizeConfig.b * 2.2),
                                      ),
                                    ),
                                    SizedBox(width: SizeConfig.b * 2),
                                  ],
                                )
                              ]);
                        }))
              ]),
              SizedBox(height: SizeConfig.v * 4),
              MaterialButton(
                onPressed: () {
                  print('Add Session');
                },
                color: Color(0xffF36C24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SizeConfig.b * 1.42),
                ),
                elevation: 7,
                minWidth: SizeConfig.screenWidth * 0.444,
                child: Text(
                  'Add Session',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: SizeConfig.b * 0.0364,
                      fontSize: SizeConfig.b * 3.6),
                ),
              ),
              SizedBox(height: SizeConfig.v * 4),
            ],
          ),
        ));
  }

  Widget _buildTableCalender() {
    return TableCalendar(
      initialCalendarFormat: CalendarFormat.month,
      calendarController: _calendarController,
      availableGestures: AvailableGestures.horizontalSwipe,
      formatAnimation: FormatAnimation.slide,
      headerStyle:
          HeaderStyle(centerHeaderTitle: true, formatButtonVisible: false),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.54),
            fontWeight: FontWeight.w400,
            fontSize: SizeConfig.b * 3.4),
        weekendStyle: TextStyle(
            color: Color(0xffF36C24),
            fontWeight: FontWeight.w400,
            fontSize: SizeConfig.b * 3.4),
      ),
      calendarStyle: CalendarStyle(
        selectedColor: Color(0xff305275),
        markersColor: Color(0XFFF36C24),
        outsideDaysVisible: false,
        weekdayStyle: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.87),
            fontWeight: FontWeight.w400,
            fontSize: SizeConfig.b * 3.4),
        weekendStyle: TextStyle(
            color: Color(0xffF36C24),
            fontWeight: FontWeight.w400,
            fontSize: SizeConfig.b * 3.4),
        todayStyle: TextStyle(
          color: Color(0xff305275),
          fontWeight: FontWeight.w700,
        ),
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (BuildContext context, date, _) {
          return Container(
            margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.b * 2, vertical: SizeConfig.v * 1.123),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xff305275),
            ),
            child: Text(
              '${date.day}',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: SizeConfig.b * 4),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.b * 2, vertical: SizeConfig.v * 1.123),
            decoration: BoxDecoration(
              color: Color(0x99305275),
            ),
            alignment: Alignment.center,
            child: Text(
              '${date.day}',
              style: TextStyle(
                  color: Color(0xff305275),
                  fontWeight: FontWeight.w700,
                  fontSize: SizeConfig.b * 3.8),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];
          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 0,
                left: 0,
                bottom: SizeConfig.b * 0.72,
                child: _buildEventsMarker(date, events),
              ),
            );
          }
          return children;
        },
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return Center(
        child: Container(
      height: SizeConfig.b * 1.45,
      width: SizeConfig.b * 1.45,
      decoration: BoxDecoration(
          color: Color(0xffF36C24),
          borderRadius: BorderRadius.circular(SizeConfig.b * 2.5)),
    ));
  }
}

class MeetingDetails {
  String meetingName;
  String dateTime;
  String time;
  String amPm;
  bool meetingStatus;

  MeetingDetails(this.meetingName, this.dateTime, this.time, this.amPm,
      this.meetingStatus);
}

class Item {
  String name;
  String des;
  String ti;
  Item(this.name, this.des, this.ti);
}
