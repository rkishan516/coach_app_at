import 'package:coach_app/QuizResponse/ResponseCheck.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class QuizModalResponse extends StatefulWidget {
  final DatabaseReference databaseReference;
  QuizModalResponse({
    @required this.databaseReference,
  });
  @override
  _QuizModalState createState() => _QuizModalState();
}

class _QuizModalState extends State<QuizModalResponse> {
  TextEditingController _scoretextValue = TextEditingController();
  SharedPreferences _pref;
  final dbref = FirebaseDatabase.instance;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  String key;
  bool isQuiz = false;
  _sharedprefinit() async {
    _pref = await SharedPreferences.getInstance();
    setState(() {
      _scoretextValue.text = _pref.getString(key);
    });
  }

  void _showsnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    _sharedprefinit();
    key = widget.databaseReference.path;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('Quizes'),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(
                  16.0,
                ),
                margin: EdgeInsets.only(top: 66.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: const Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _scoretextValue,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Enter Total Score",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          _pref.setString(key, _scoretextValue.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResponseCheck(
                                      databaseReference:
                                          widget.databaseReference,
                                      totalMarks: _pref.getString(key))));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.orange),
                          width: MediaQuery.of(context).size.width / 3.5,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text(
                            "Save Score",
                            style: TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
