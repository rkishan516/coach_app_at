import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/QuizResponse/ResponseCheck.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class QuizModalResponse extends StatefulWidget {
  final DatabaseReference databaseReference;
  QuizModalResponse({
    required this.databaseReference,
  });
  @override
  _QuizModalState createState() => _QuizModalState();
}

class _QuizModalState extends State<QuizModalResponse> {
  TextEditingController _scoretextValue = TextEditingController();
  final dbref = FirebaseDatabase.instance;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  late String key;
  bool isQuiz = false;
  _sharedprefinit() async {
    setState(() {
      _scoretextValue.text = AppwriteAuth.instance.prefs!.getString(key)!;
    });
  }

  @override
  void initState() {
    super.initState();
    key = widget.databaseReference.path;
    _sharedprefinit();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('Quizzes'.tr()),
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
                          labelText: "Enter Total Score".tr(),
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
                          AppwriteAuth.instance.prefs!
                              .setString(key, _scoretextValue.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResponseCheck(
                                  databaseReference: widget.databaseReference,
                                  totalMarks: AppwriteAuth.instance.prefs!
                                      .getString(key)!,
                                ),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Color(0xffF36C24)),
                          width: MediaQuery.of(context).size.width / 3.5,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text(
                            "Save Score".tr(),
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
