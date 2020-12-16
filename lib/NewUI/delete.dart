import 'package:flutter/material.dart';

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

class Selection {
  String selection;
  int id;

  Selection(this.id, this.selection);

  static List<Selection> getSelectionList() {
    return <Selection>[
      Selection(1, 'All'),
    ];
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Selection> _selectionList = Selection.getSelectionList();
  List<DropdownMenuItem<Selection>> _dropdownMenuItems;
  Selection _selected;

  List<Admins> itemlist;
  bool cw = false;
  ScrollController _controller;
  ScrollController _controller1;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_selectionList);
    _selected = _dropdownMenuItems[0].value;
    super.initState();
    _controller = ScrollController();
    _controller1 = ScrollController();
    loadList();
  }

  loadList() {
    itemlist = List();
    itemlist.add(Admins('Name', 'Sub-admin', false));
    itemlist.add(Admins('Name', 'Mid-admin', true));
    itemlist.add(Admins('Name', 'Sub-admin', true));
    itemlist.add(Admins('Name', 'Mid-admin', false));
    itemlist.add(Admins('Name', 'Sub-admin', false));
    itemlist.add(Admins('Name', 'Mid-admin', true));
    itemlist.add(Admins('Name', 'Sub-admin', false));
    itemlist.add(Admins('Name', 'Mid-admin', false));
    itemlist.add(Admins('Name', 'Sub-admin', false));
    itemlist.add(Admins('Name', 'Mid-admin', false));
  }

  List<DropdownMenuItem<Selection>> buildDropdownMenuItems(List selections) {
    List<DropdownMenuItem<Selection>> items = List();
    for (Selection selection in selections) {
      items.add(
          DropdownMenuItem(value: selection, child: Text(selection.selection)));
    }
    return items;
  }

  onChangedDropdownMenuitem(Selection selected) {
    setState(() {
      _selected = selected;
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
                color: Color(0xffF36C24),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialogueBox(context);
          },
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: SizeConfig.b * 9,
          ),
          backgroundColor: Color(0xffF36C24),
        ),
        body: ListView(
            shrinkWrap: true,
            controller: _controller,
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                child: Column(children: [
                  Card(
                    elevation: SizeConfig.b * 1.95,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(SizeConfig.b * 1.5)),
                    margin: EdgeInsets.only(
                        top: SizeConfig.v * 1, bottom: SizeConfig.v * 1),
                    child: Container(
                      padding: EdgeInsets.all(SizeConfig.v * 2),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Stack(children: [
                                overlapped(),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        10.0 * SizeConfig.b * 6.36, 0, 0, 0),
                                    child: CircleAvatar(
                                        child: Text("+4"),
                                        backgroundColor: Colors.purple,
                                        radius: SizeConfig.b * 5)),
                              ]),
                              Spacer(),
                              Text(
                                '14 selected',
                                style: TextStyle(
                                  color: Color(0xff848484),
                                  fontSize: SizeConfig.b * 3.2,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          cw == false
                              ? IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                      !cw
                                          ? Icons.keyboard_arrow_down
                                          : Icons.keyboard_arrow_up,
                                      size: SizeConfig.b * 7.5,
                                      color: Color(0xff305275)),
                                  onPressed: () {
                                    setState(() {
                                      cw = !cw;
                                      print(cw);
                                    });
                                  })
                              : Container(),
                          cw == true
                              ? Container(
                                  padding:
                                      EdgeInsets.only(top: SizeConfig.v * 4),
                                  color: Colors.white,
                                  child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemCount: 9,
                                      itemBuilder:
                                          (BuildContext ctxt, int index) {
                                        return Column(children: [
                                          Row(children: [
                                            CircleAvatar(
                                              radius: SizeConfig.b * 6,
                                              backgroundColor: Colors.grey,
                                            ),
                                            SizedBox(width: SizeConfig.b * 2),
                                            Container(
                                                width: SizeConfig.screenWidth *
                                                    0.65,
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          "Shivansh Karnik Awasthi Shukla",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  SizeConfig.b *
                                                                      3.57)),
                                                      SizedBox(
                                                          height:
                                                              SizeConfig.v * 1),
                                                      Text("Sub-Admin",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  SizeConfig.b *
                                                                      3.054)),
                                                    ])),
                                            Spacer(),
                                            IconButton(
                                                padding: EdgeInsets.zero,
                                                icon: Icon(Icons.cancel,
                                                    color: Colors.red),
                                                onPressed: null),
                                          ]),
                                          SizedBox(
                                              height: index != 8
                                                  ? SizeConfig.v * 2
                                                  : 0), //for last index
                                        ]);
                                      }))
                              : Container(),
                          cw == true
                              ? IconButton(
                                  icon: Icon(Icons.keyboard_arrow_up),
                                  onPressed: () {
                                    setState(() {
                                      cw = !cw;
                                      print(cw);
                                    });
                                  })
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: SizeConfig.b * 5),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                child: DropdownButton(
                                  isDense: true,
                                  items: _dropdownMenuItems,
                                  value: _selected,
                                  onChanged: onChangedDropdownMenuitem,
                                ),
                              )),
                              SizedBox(
                                width: SizeConfig.b * 1.5,
                              ),
                              Text(
                                'View Lists',
                                style: TextStyle(
                                    color: Color(0xffF36C24),
                                    fontSize: SizeConfig.b * 3.5,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          IconButton(
                              icon: Icon(Icons.search),
                              color: Color(0xffF36C24),
                              iconSize: SizeConfig.b * 7,
                              onPressed: () {})
                        ],
                      )),
                  SingleChildScrollView(
                      controller: _controller1,
                      child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: SizeConfig.screenHeight * 0.65,
                              minHeight: SizeConfig.screenHeight * 0.65),
                          child: Container(
                              color: Colors.white,
                              child: ListView.builder(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemCount: itemlist.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return CheckboxListTile(
                                      value: true,
                                      title: Text(
                                        '${itemlist[index].name}',
                                      ),
                                      subtitle: Text(
                                        '${itemlist[index].adminType}',
                                      ),
                                      onChanged: (value) {
                                        // itemlist[index].value;
                                      },
                                      secondary: CircleAvatar(
                                        radius: SizeConfig.b * 5.3,
                                        backgroundColor: Colors.grey,
                                      ),
                                      activeColor: Color(0xff305275),
                                    );
                                  }))))
                ]),
              )
            ]));
  }
}

class Admins {
  String name;
  String adminType;
  bool value;
  Admins(this.name, this.adminType, this.value);
}

Widget buildCheckboxListTile(String name, String adminType, bool value) {
  return CheckboxListTile(
    value: true,
    title: Text(
      'Name',
    ),
    subtitle: Text(
      'Sub-admin',
    ),
    onChanged: null,
    secondary: CircleAvatar(
      radius: 21,
      backgroundColor: Colors.grey,
    ),
    activeColor: Color(0xff305275),
  );
}

//to pass the list of persons and items of persons
Widget overlapped() {
  final overlap = SizeConfig.b * 6.36;
  List<CircleAvatar> amit = List<CircleAvatar>();
  for (int i = 0; i < 10; i++) {
    amit.add(CircleAvatar(
      child: Text(i.toString()),
      backgroundColor: i % 2 == 0 ? Colors.red : Colors.blue,
      radius: SizeConfig.b * 5,
    ));
  }
  List<Widget> stackLayers = List<Widget>.generate(amit.length, (index) {
    return Padding(
      padding: EdgeInsets.fromLTRB(index.toDouble() * overlap, 0, 0, 0),
      child: amit[index],
    );
  });
  return Stack(children: stackLayers);
}

void showDialogueBox(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(
              horizontal: SizeConfig.b * 8, vertical: SizeConfig.v * 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeConfig.b * 2),
          ),
          child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: SizeConfig.screenHeight * 0.21,
                  maxHeight: SizeConfig.screenHeight * 0.23),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.b * 8, vertical: SizeConfig.v * 5),
                child: Column(
                  children: [
                    Text(
                      'Are you sure you want to delete List Standard 1?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff1C1C1C),
                          fontWeight: FontWeight.w400,
                          fontSize: SizeConfig.b * 3.8),
                    ),
                    SizedBox(
                      height: SizeConfig.v * 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton(
                            onPressed: () {},
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                  color: Color(0xffF36C24),
                                  fontSize: SizeConfig.b * 4.5,
                                  fontWeight: FontWeight.w400),
                            )),
                        FlatButton(
                            onPressed: () {},
                            child: Text(
                              'No',
                              style: TextStyle(
                                  color: Color(0xffF36C24),
                                  fontSize: SizeConfig.b * 4.5,
                                  fontWeight: FontWeight.w400),
                            )),
                      ],
                    )
                  ],
                ),
              )),
        );
      });
}
