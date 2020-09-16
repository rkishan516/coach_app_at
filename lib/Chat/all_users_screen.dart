import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Authentication/welcome_page.dart';
import 'package:coach_app/Chat/group_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:coach_app/Chat/models/item_class.dart';
import 'package:coach_app/Chat/pages/chats.dart';
import 'package:coach_app/Chat/participants.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double b;
  static double v;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    b = screenWidth / 100;
    v = screenHeight / 100;
  }
}

class AllUsersScreen extends StatefulWidget {
  final curUser currentUser;
  AllUsersScreen({this.currentUser});

  _AllUsersScreenState createState() => _AllUsersScreenState(currentUser);
}

class _AllUsersScreenState extends State<AllUsersScreen>
    with SingleTickerProviderStateMixin {
  final curUser currentUser;
  _AllUsersScreenState(this.currentUser);

  TabController _tabController;

  String des;
  int len = 0;
  List<Tab> _tabs = [];
  List<Widget> _chats = [];

  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    des = currentUser.role;
    if (des == "Admin") {
      len = 5;
    } else if (des == "Mid Admin") {
      len = 6;
    } else if (des == "Sub Admin") {
      len = 6;
    } else if (des == "Teacher") {
      len = 4;
    } else if (des == "Student") {
      len = 2;
    }
    _tabController =
        new TabController(length: len, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _chats.clear();
    _tabs.clear();
    super.dispose();
  }

  String cat, cd;

  @override
  Widget build(BuildContext context) {
    _tabs.clear();
    _chats.clear();
    SizeConfig().init(context);
    if (des == "Admin") {
      //_chats.clear();

      _chats.add(chats(
        cat: "Mid Admin",
        currentUser: currentUser,
      )); //to call different chat screens
      _chats.add(chats(
        cat: "Sub Admin",
        currentUser: currentUser,
      ));
      _chats.add(chats(
        cat: "Teacher",
        currentUser: currentUser,
      ));
      _chats.add(chats(
        cat: "Student",
        currentUser: currentUser,
      ));
      _chats.add(groupList(currentUser: currentUser));

      _tabs.clear();

      _tabs.add(Tab(
          child: Text('Mid-Admin',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 107, 37),
                  fontSize: SizeConfig.b * 3.25))));
      _tabs.add(Tab(
          child: Text('Sub-Admin',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 107, 37),
                  fontSize: SizeConfig.b * 3.25))));
      _tabs.add(Tab(
          child: Text('Teachers',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 107, 37),
                  fontSize: SizeConfig.b * 3.25))));
      _tabs.add(Tab(
          child: Text('Students',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 107, 37),
                  fontSize: SizeConfig.b * 3.25))));
      _tabs.add(Tab(
          child: Text('Groups',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 107, 37),
                  fontSize: SizeConfig.b * 3.25))));
    }
    if (des == "Mid Admin") {
      //_chats.clear();

      _chats.add(chats(
        cat: "Admin",
        currentUser: currentUser,
      ));
      _chats.add(chats(
        cat: "Mid Admin",
        currentUser: currentUser,
      ));
      _chats.add(chats(
        cat: "Sub Admin",
        currentUser: currentUser,
      ));
      _chats.add(chats(
        cat: "Teacher",
        currentUser: currentUser,
      ));
      _chats.add(chats(
        cat: "Student",
        currentUser: currentUser,
      ));
      _chats.add(groupList(currentUser: currentUser));

      _tabs.clear();

      _tabs.add(Tab(
          child: Text('Admin',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 107, 37),
                  fontSize: SizeConfig.b * 3.25))));
      _tabs.add(Tab(
          child: Text('Mid-Admin',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 107, 37),
                  fontSize: SizeConfig.b * 2.95))));
      _tabs.add(Tab(
          child: Text('Sub-Admin',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 107, 37),
                  fontSize: SizeConfig.b * 2.95))));
      _tabs.add(Tab(
          child: Text('Teachers',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 107, 37),
                  fontSize: SizeConfig.b * 3.25))));
      _tabs.add(Tab(
          child: Text('Students',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 107, 37),
                  fontSize: SizeConfig.b * 3.25))));
      _tabs.add(Tab(
          child: Text('Groups',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 107, 37),
                  fontSize: SizeConfig.b * 3.25))));
    }
    if (des == "Sub Admin") {
      //_chats.clear();

      _chats.add(chats(
        cat: "Admin",
        currentUser: currentUser,
      ));
      _chats.add(chats(
        cat: "Mid Admin",
        currentUser: currentUser,
      ));
      _chats.add(chats(
        cat: "Sub Admin",
        currentUser: currentUser,
      ));
      _chats.add(chats(
        cat: "Teacher",
        currentUser: currentUser,
      ));
      _chats.add(chats(
        cat: "Student",
        currentUser: currentUser,
      ));
      _chats.add(groupList(
        currentUser: currentUser,
      ));

      _tabs.clear();

      _tabs.add(Tab(
          child: Text('Admin',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 107, 37),
                  fontSize: SizeConfig.b * 3.25))));
      _tabs.add(Tab(
          child: Text('Mid-Admins',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 107, 37),
                  fontSize: SizeConfig.b * 2.7))));
      _tabs.add(Tab(
          child: Text('Sub-Admins',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 107, 37),
                  fontSize: SizeConfig.b * 2.7))));
      _tabs.add(Tab(
          child: Text('Teachers',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 107, 37),
                  fontSize: SizeConfig.b * 3.25))));
      _tabs.add(Tab(
          child: Text('Students',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 107, 37),
                  fontSize: SizeConfig.b * 3.25))));
      _tabs.add(Tab(
          child: Text('Groups',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 107, 37),
                  fontSize: SizeConfig.b * 3.25))));
    }
    if (des == "Teacher") {
      //_chats.clear();

      _chats.add(chats(
        cat: "Sub Admin",
        currentUser: currentUser,
      ));
      _chats.add(chats(
        cat: "Teacher",
        currentUser: currentUser,
      ));
      _chats.add(chats(
        cat: "Student",
        currentUser: currentUser,
      ));
      _chats.add(groupList(
        currentUser: currentUser,
      ));

      _tabs.clear();

      _tabs.add(Tab(
          child: Text('Sub-Admins',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 107, 37),
                  fontSize: SizeConfig.b * 3.7))));
      _tabs.add(Tab(
          child: Text('Teachers',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 107, 37),
                  fontSize: SizeConfig.b * 3.7))));
      _tabs.add(Tab(
          child: Text('Students',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 107, 37),
                  fontSize: SizeConfig.b * 3.7))));
      _tabs.add(Tab(
          child: Text('Groups',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 107, 37),
                  fontSize: SizeConfig.b * 3.7))));
    }
    if (des == "Student") {
      _chats.add(groupList(
        currentUser: currentUser,
      ));

      _tabs.clear();

      _tabs.add(Tab(
          child: Text('Groups',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 107, 37),
                  fontSize: SizeConfig.b * 3.9))));
    }

    return new Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 230, 230),

      appBar: new AppBar(
        leading: Icon(Icons.arrow_back),
        title: new Text("Chat Section",
            style: TextStyle(fontWeight: FontWeight.w500)),
        backgroundColor: Color.fromARGB(255, 242, 108, 37),
        elevation: 5,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () async {
              FireBaseAuth.instance.signoutWithGoogle();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => WelcomePage()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 242, 108, 37),
        child: Icon(
          Icons.group_add,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          print("Pressed Button");
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return new participants(
              currentUser: currentUser,
            );
          }));
        },
      ),

      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            height: SizeConfig.v * 6.14,
            child: TabBar(
              indicatorWeight: 5,
              indicatorColor: Color.fromARGB(255, 255, 107, 37),
              labelPadding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.b * 0.76, vertical: 0),
              controller: _tabController,
              tabs: _tabs,
              //calling the list for tabs
            ),
          ),
          Expanded(
            flex: len,
            child: new TabBarView(controller: _tabController, children: _chats),
          ),
        ],
      ),
      //floatingActionButton: buildFloatingActionButton(selectedfab),
    );
  }
}
