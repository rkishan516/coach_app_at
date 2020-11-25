import 'package:flutter/services.dart';
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

class Months {
  int index;
  String month;

  Months(this.index, this.month);

  static List<Months> getMonths() {
    return <Months>[
      Months(0, 'Jan'),
      Months(1, 'Feb'),
      Months(2, 'Mar'),
      Months(3, 'Apr'),
      Months(4, 'May'),
      Months(5, 'Jun'),
      Months(6, 'Jul'),
      Months(7, 'Aug'),
      Months(8, 'Sep'),
      Months(9, 'Oct'),
      Months(10, 'Nov'),
      Months(11, 'Dec'),
    ];
  }
}

class Time {
  int index;
  String time;
  Time(this.index, this.time);
  static List<Time> getTime() {
    return <Time>[Time(0, 'AM'), Time(1, 'PM')];
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Months> _months = Months.getMonths();

  List<DropdownMenuItem<Months>> _dropdownMenuItems;
  List<Time> _time = Time.getTime();
  List<DropdownMenuItem<Time>> _dropdownMenuItemsTime;

  Months _selectedMonth;
  Time _selectedTime;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_months);
    _selectedMonth = _dropdownMenuItems[0].value;

    _dropdownMenuItemsTime = buildDropdownMenuItemsTime(_time);
    _selectedTime = _dropdownMenuItemsTime[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Months>> buildDropdownMenuItems(List months) {
    List<DropdownMenuItem<Months>> items = List();

    for (Months month in months) {
      items.add(DropdownMenuItem(value: month, child: Text(month.month)));
    }
    return items;
  }

  List<DropdownMenuItem<Time>> buildDropdownMenuItemsTime(List times) {
    List<DropdownMenuItem<Time>> items = List();

    for (Time time in times) {
      items.add(DropdownMenuItem(value: time, child: Text(time.time)));
    }
    return items;
  }

  onchangeDropdownItem(Months selectedMonth) {
    setState(() {
      _selectedMonth = selectedMonth;
    });
  }

  onchangeDropdownItemTime(Time selectedTime) {
    setState(() {
      _selectedTime = selectedTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        elevation: 10,
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
          'Add Sessions',
          style: TextStyle(
              color: Color(0xffF36C24),
              fontWeight: FontWeight.w400,
              fontSize: SizeConfig.b * 4.5),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                  top: SizeConfig.v * 3, bottom: SizeConfig.v * 1.5),
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.v * 3.12, horizontal: SizeConfig.b * 4),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Color(0xff2C2C2C),
                            width: SizeConfig.b * 0.121)),
                    child: TextField(
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.only(
                            left: SizeConfig.b * 2.6,
                            top: SizeConfig.v * 0.7816,
                            bottom: SizeConfig.v * 0.93,
                          ),
                          border: InputBorder.none,
                          hintText: 'Title',
                          hintStyle: TextStyle(
                              color: Color(0xff848484),
                              fontSize: SizeConfig.b * 3.95,
                              fontWeight: FontWeight.w400,
                              letterSpacing: SizeConfig.b * 0.037)),
                      maxLines: null,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.v * 3,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Color(0xff2C2C2C),
                            width: SizeConfig.b * 0.121)),
                    child: TextField(
                      decoration: new InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.only(
                            left: SizeConfig.b * 2.6,
                            top: SizeConfig.v * 0.7816,
                            bottom: SizeConfig.v * 0.93,
                          ),
                          border: InputBorder.none,
                          hintText: 'Description',
                          hintStyle: TextStyle(
                              color: Color(0xff848484),
                              fontSize: SizeConfig.b * 3.95,
                              fontWeight: FontWeight.w400,
                              letterSpacing: SizeConfig.b * 0.037)),
                      maxLines: null,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.b * 10,
                  vertical: SizeConfig.v * 3,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Select Date',
                          style: TextStyle(
                            color: Color(0xff2C2C2C),
                            fontSize: SizeConfig.b * 3.95,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: SizeConfig.b * 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: SizeConfig.screenWidth * 0.12,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(SizeConfig.b * 1.2),
                                  border: Border.all(
                                      color: Color(0xff2C2C2C),
                                      width: SizeConfig.b * 0.121)),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(2)
                                ],
                                decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.only(
                                      left: SizeConfig.b * 1,
                                      top: SizeConfig.v * 0.4,
                                      bottom: SizeConfig.v * 0.4,
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Day',
                                    hintStyle: TextStyle(
                                        color: Color(0xff848484),
                                        fontSize: SizeConfig.b * 3.95,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: SizeConfig.b * 0.037)),
                              ),
                            ),
                            SizedBox(width: SizeConfig.b * 4),
                            Container(
                              padding:
                                  EdgeInsets.only(left: SizeConfig.b * 1.2),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(SizeConfig.b * 1.2),
                                  border: Border.all(
                                      color: Color(0xff2C2C2C),
                                      width: SizeConfig.b * 0.121)),
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  child: DropdownButton(
                                      isDense: true,
                                      value: _selectedMonth,
                                      items: _dropdownMenuItems,
                                      onChanged: onchangeDropdownItem),
                                ),
                              ),
                            ),
                            SizedBox(width: SizeConfig.b * 4),
                            Container(
                              width: SizeConfig.screenWidth * 0.14,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(SizeConfig.b * 1.2),
                                  border: Border.all(
                                      color: Color(0xff2C2C2C),
                                      width: SizeConfig.b * 0.121)),
                              child: TextField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(4)
                                ],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.only(
                                      left: SizeConfig.b * 1.6,
                                      top: SizeConfig.v * 0.4,
                                      bottom: SizeConfig.v * 0.4,
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Year',
                                    hintStyle: TextStyle(
                                        color: Color(0xff848484),
                                        fontSize: SizeConfig.b * 3.95,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: SizeConfig.b * 0.037)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: SizeConfig.v * 3),
                    Row(
                      children: [
                        Text(
                          'Select Time',
                          style: TextStyle(
                            color: Color(0xff2C2C2C),
                            fontSize: SizeConfig.b * 3.95,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: SizeConfig.b * 3.5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: SizeConfig.screenWidth * 0.12,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(SizeConfig.b * 1.2),
                                  border: Border.all(
                                      color: Color(0xff2C2C2C),
                                      width: SizeConfig.b * 0.121)),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(2)
                                ],
                                decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.only(
                                      left: SizeConfig.b * 1,
                                      top: SizeConfig.v * 0.4,
                                      bottom: SizeConfig.v * 0.4,
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Hour',
                                    hintStyle: TextStyle(
                                        color: Color(0xff848484),
                                        fontSize: SizeConfig.b * 3.95,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: SizeConfig.b * 0.037)),
                              ),
                            ),
                            SizedBox(width: SizeConfig.b * 4),
                            Container(
                              width: SizeConfig.screenWidth * 0.15,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(SizeConfig.b * 1.2),
                                  border: Border.all(
                                      color: Color(0xff2C2C2C),
                                      width: SizeConfig.b * 0.121)),
                              child: TextField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(2)
                                ],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.only(
                                      left: SizeConfig.b * 2.5,
                                      top: SizeConfig.v * 0.4,
                                      bottom: SizeConfig.v * 0.4,
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Minutes',
                                    hintStyle: TextStyle(
                                        color: Color(0xff848484),
                                        fontSize: SizeConfig.b * 3.95,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: SizeConfig.b * 0.037)),
                              ),
                            ),
                            SizedBox(width: SizeConfig.b * 4),
                            Container(
                              padding:
                                  EdgeInsets.only(left: SizeConfig.b * 1.2),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(SizeConfig.b * 1.2),
                                  border: Border.all(
                                      color: Color(0xff2C2C2C),
                                      width: SizeConfig.b * 0.121)),
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  padding: EdgeInsets.zero,
                                  child: DropdownButton(
                                      isDense: true,
                                      value: _selectedTime,
                                      items: _dropdownMenuItemsTime,
                                      onChanged: onchangeDropdownItemTime),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              margin: EdgeInsets.only(
                top: SizeConfig.v * 1.5,
              ),
              child: Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.screenHeight * 0.029,
                  bottom: SizeConfig.screenHeight * 0.02656,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                            onPressed: () {
                              print('Add Session');
                            },
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Color(0xffF36C24)),
                                borderRadius:
                                    BorderRadius.circular(SizeConfig.b * 1.5)),
                            elevation: 5,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Select Candidates',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xffF36C24),
                                      letterSpacing: SizeConfig.b * 0.0364,
                                      fontSize: SizeConfig.b * 3.6),
                                ),
                                Icon(
                                  MdiIcons.menuRight,
                                  color: Color(0xffF36C24),
                                  size: SizeConfig.b * 6.5,
                                )
                              ],
                            )),
                      ],
                    ),
                    SizedBox(height: SizeConfig.v * 1.2),
                    Text(
                      'None Slected',
                      style: TextStyle(
                          color: Color(0xff848484),
                          fontWeight: FontWeight.w400,
                          letterSpacing: SizeConfig.b * 0.0364,
                          fontSize: SizeConfig.b * 3.2),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.2),
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
                'Done',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    letterSpacing: SizeConfig.b * 0.0364,
                    fontSize: SizeConfig.b * 3.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
