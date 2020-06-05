import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/QuizResponse/Responsecheck.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';


class QuizModal extends StatefulWidget {
  final String courseId, subjectId, chapterId, contentId;
  QuizModal({
    @required this.courseId,
    @required this.subjectId,
    @required this.chapterId,
    @required this.contentId,
  });
  @override
  _QuizModalState createState() => _QuizModalState();
}

class _QuizModalState extends State<QuizModal> {
  TextEditingController _scoretextValue = TextEditingController();
  SharedPreferences _pref;
  final dbref= FirebaseDatabase.instance;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  String key;
  bool isQuiz=false;
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
  _checkQuiz() async {
    dbref
        .reference()
        .child(
            'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseId}/subjects/${widget.subjectId}/chapters/${widget.chapterId}/content/${widget.contentId}/kind')
        .once()
        .then((DataSnapshot snapshot) {
          if(snapshot.value=='Quiz')
          {
            setState(() {
              isQuiz=true;
            });
          }
        });
    
  }

  @override
  void initState() {
    super.initState();
    _sharedprefinit();
    key = widget.courseId +
        widget.subjectId +
        widget.chapterId +
        widget.contentId;
    _checkQuiz();    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('Quizes'),
      ),
      body: Container(
        child: isQuiz? Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              focusColor: Colors.orange,
              hoverColor: Colors.orange,
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text('Check Response'),
              onTap: () {
                if (_pref.getString(key) != null)
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResponseCheck(
                              courseId: "517067432",
                              subjectId: "0",
                              chapterId: "0",
                              contentId: "2",
                              totalMarks: _pref.getString(key))));
                else {
                  _showsnackbar(context, "Enter Total Marks");
                }
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.35,
            ),
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
                                courseId: "517067432",
                                subjectId: "0",
                                chapterId: "0",
                                contentId: "2",
                                totalMarks: _pref.getString(key))));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.orange),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    child: Text(
                      "Save Score",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ),
            
          ],
        ):
        Center(
          child: Text('No Quiz Going on'),
        )
        ,
      ),
    );
  }
}
