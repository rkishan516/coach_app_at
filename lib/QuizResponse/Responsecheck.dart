import 'dart:collection';

import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'ResponseModel.dart';


class ResponseCheck extends StatefulWidget {
  final String courseId, subjectId, chapterId, contentId;
  final String totalMarks;
  ResponseCheck({
    @required this.courseId,
    @required this.subjectId,
    @required this.chapterId,
    @required this.contentId,
    @required this.totalMarks,
  });
  @override
  _ResponseCheckState createState() => _ResponseCheckState();
}

class _ResponseCheckState extends State<ResponseCheck> {
  final dbref = FirebaseDatabase.instance;
  List<Response> _allStudentResponse = [];
  LinkedHashMap<dynamic, dynamic> _hashMap = new LinkedHashMap();
  LinkedHashMap<dynamic, dynamic> _lMap = new LinkedHashMap();
  Map<String, String> map = new Map();
  TextEditingController _scoreText= new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey= new GlobalKey<ScaffoldState>();
  PageController _pageController =PageController();
  SharedPreferences _pref;
  int pageNumber=0;
  bool saveScore=false;
  String key;
  _loadDataFromDatabase() async {
    dbref
        .reference()
        .child(
            'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseId}/subjects/${widget.subjectId}/chapters/${widget.chapterId}/content/${widget.contentId}/quizModel')
        .child('result')
        .once()
        .then((DataSnapshot snapshot) {
      _hashMap = snapshot.value;
      print(_hashMap);
      _hashMap.forEach((key, value) {
        print(key);
        print(value['response']);
        _lMap = value['response'];
        map = _lMap.map((a, b) => MapEntry(a as String, b as String));
        setState(() {
          _allStudentResponse.add(Response(key, value['name'], map,value['score']));
        
        });
      });
    });
  }

  _saveScore (uid) async{
    double score= double.parse(_scoreText.text)/double.parse(widget.totalMarks);
    await dbref
        .reference()
        .child(
            'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseId}/subjects/${widget.subjectId}/chapters/${widget.chapterId}/content/${widget.contentId}/quizModel')
        .child('result/$uid').update({
         'score': int.parse(_scoreText.text)
        });
    
    await  dbref
        .reference()
        .child(
            'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/bbqYNmA3UXgDBbJ40O3oET4DISI2/course/${widget.courseId}/subjects/${widget.subjectId}/chapters/${widget.chapterId}/content/${widget.contentId}')
        .update({
         'score': score
        });
    _showsnackbar(context, "Score is Saved"); 
  }

  _submitcheck() async{
    await dbref
        .reference()
        .child(
            'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseId}/subjects/${widget.subjectId}/chapters/${widget.chapterId}/content/${widget.contentId}/quizModel')
        .child('result').remove();
    _showsnackbar(context, "Submitted successfully");
  }
  void _showsnackbar(BuildContext context, String message){
 
  final snackBar= SnackBar(content: Text(message));
  _scaffoldkey.currentState.showSnackBar(snackBar);
 }

  
  
   _sharedprefinit () async{
     _pref = await SharedPreferences.getInstance();
  }
  @override
  void initState() {
    super.initState();
    _loadDataFromDatabase();
    _sharedprefinit();
    key = widget.courseId +
        widget.subjectId +
        widget.chapterId +
        widget.contentId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Response Check'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: (){

              _pageController.animateToPage(--pageNumber, duration: Duration(milliseconds: 250 ), curve: Curves.bounceInOut);
              
            },),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: (){
              saveScore||_allStudentResponse.elementAt(pageNumber).score!=-1?_pageController.animateToPage(++pageNumber, duration: Duration(milliseconds: 250 ), curve: Curves.bounceInOut)
              :_showsnackbar(context,"Save Score First");
            },)  
        ],
      ),
      key: _scaffoldkey,
      body: PageView.builder(
          onPageChanged: (number){
            setState(() {
              saveScore=false;
              pageNumber= number;
            });
          },
          physics:new NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemCount: _allStudentResponse.length,
          itemBuilder: (context, position) {
            String _name=_allStudentResponse.elementAt(position).name;
            int _score= _allStudentResponse.elementAt(position).score;
            return Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: ListTile(
                    title: Text(_name),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.builder(
                        itemCount: _allStudentResponse
                            .elementAt(position)
                            .responses
                            .length,
                        itemBuilder: (context, index) {
                          String key = _allStudentResponse

                              .elementAt(position)
                              .responses
                              .keys
                              .elementAt(index);
                          return Card(
                            child: ListTile(
                              title: Text((index + 1).toString() + ". " + key),
                              subtitle: Text(_allStudentResponse
                                  .elementAt(position)
                                  .responses[key]),
                            ),
                          );
                        }),
                  ),
                ),
                Divider(
                  height: 20.0,
                  thickness: 2.0,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                    controller: _scoreText,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: _score==-1?"Enter Score":_score.toString(),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  
                    RaisedButton(
                      color: Colors.orange,
                      child: Text('Save Score'),
                      onPressed:(){
                        saveScore=true;
                        _saveScore(_allStudentResponse.elementAt(position).uid);
                      }),

                    pageNumber+1==_allStudentResponse.length? RaisedButton(
                      color: Colors.orange,
                      child: Text('Submit'),
                      onPressed:(){
                        saveScore?_submitcheck(): _showsnackbar(context, "Save Score First");
                        _pref.remove(key);
                      }):
                      
                      Container()
                      ,  
                  ],
                )
              ],
            );
          }),
    );
  }
}
