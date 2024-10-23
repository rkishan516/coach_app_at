import 'package:coach_app/Chat/models/item_class.dart';
import 'package:coach_app/Profile/TeacherProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class independent extends StatefulWidget {
  final CurrUser currentUser;
  independent({required this.currentUser});
  @override
  _independentState createState() => new _independentState(currentUser);
}

List<String> litems = ["1", "2", "Third", "4"];

class _independentState extends State<independent>
    with TickerProviderStateMixin {
  final CurrUser currentUser;
  _independentState(this.currentUser);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var gridView = new GridView.builder(
        itemCount: 7,
        shrinkWrap: true,
        physics: new NeverScrollableScrollPhysics(),
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
            child: Container(
              color: Color.fromARGB(255, 230, 230, 230),
              child: Column(
                children: [
                  CircleAvatar(
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Colors.grey,
                    radius: 27,
                    backgroundImage: AssetImage('images/f.jpg'),
                  ),
                  SizedBox(height: 5),
                  Text("C.V Raman",
                      style: TextStyle(fontSize: SizeConfig.b * 3.56))
                ],
              ),
            ),
            onTap: () {
              showDialog(
                builder: (context) => new CupertinoAlertDialog(
                  title: new Column(
                    children: <Widget>[
                      new Text("GridView"),
                      new Icon(
                        Icons.favorite,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  content: new Text("Selected Item $index"),
                  actions: <Widget>[
                    new MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: new Text("OK"))
                  ],
                ),
                barrierDismissible: false,
                context: context,
              );
            },
          );
        });
    return Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: new Text("Chat Section"),
        backgroundColor: Color.fromARGB(255, 242, 108, 37),
      ),
      body: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            height: SizeConfig.v * 6.78,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Text("Independent",
                style: TextStyle(
                    fontSize: SizeConfig.b * 5.09,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 242, 108, 37))),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: SizeConfig.v * 6.78,
            color: Color.fromARGB(255, 230, 230, 230),
            child: Text("    Select participants For Group",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: SizeConfig.b * 4.3)),
          ),
          Container(
            color: Color.fromARGB(255, 230, 230, 230),
            child: Column(children: [
              Container(
                height: SizeConfig.v * 4.34,
                color: Color.fromARGB(255, 230, 230, 230),
                child: Row(
                  children: [
                    SizedBox(width: SizeConfig.b * 5.09),
                    Text("Mid-Admin :",
                        style: TextStyle(
                            color: Color.fromARGB(255, 242, 108, 37),
                            fontSize: SizeConfig.b * 4.4))
                  ],
                ),
              ),
              gridView,
              Container(
                height: SizeConfig.v * 4.34,
                color: Color.fromARGB(255, 230, 230, 230),
                child: Row(
                  children: [
                    SizedBox(width: SizeConfig.b * 5.09),
                    Text("Sub-Admin :",
                        style: TextStyle(
                            color: Color.fromARGB(255, 242, 108, 37),
                            fontSize: SizeConfig.b * 4.4))
                  ],
                ),
              ),
              gridView,
              Container(
                height: SizeConfig.v * 4.34,
                color: Color.fromARGB(255, 230, 230, 230),
                child: Row(
                  children: [
                    SizedBox(width: SizeConfig.b * 5.09),
                    Text("Teacher :",
                        style: TextStyle(
                            color: Color.fromARGB(255, 242, 108, 37),
                            fontSize: SizeConfig.b * 4.4))
                  ],
                ),
              ),
              gridView,
              Container(
                height: SizeConfig.v * 4.34,
                color: Color.fromARGB(255, 230, 230, 230),
                child: Row(
                  children: [
                    SizedBox(width: SizeConfig.b * 5.09),
                    Text("Student :",
                        style: TextStyle(
                            color: Color.fromARGB(255, 242, 108, 37),
                            fontSize: SizeConfig.b * 4.4))
                  ],
                ),
              ),
              gridView,
            ]),
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.check, size: SizeConfig.b * 7.63),
          backgroundColor: Color.fromARGB(255, 242, 108, 37),
          onPressed: () {}),
    );
  }
}
