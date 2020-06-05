import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TeacherProfilePage extends StatelessWidget {
  DatabaseReference reference;
  TeacherProfilePage({@required this.reference});
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          centerTitle: false,
          elevation: 0.0,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.orange, Colors.deepOrange])),
          child: StreamBuilder<Event>(
              stream: reference.onValue,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return UploadDialog(warning: 'Fetching');
                }
                Teacher teacher =
                    Teacher.fromJson(snapshot.data.snapshot.value);
                return Center(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: CircleAvatar(
                          radius: _width / 5,
                          backgroundColor: Colors.orange,
                          backgroundImage: NetworkImage(teacher.photoURL ?? ''),
                          child: Text(
                            '${teacher?.name[0].toUpperCase()}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              '${teacher.name}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: _width / 15,
                                  color: Colors.white),
                            ),
                            Text(
                              '${teacher.email}',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: _width / 25,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Qualification: ${teacher?.qualification}',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: _width / 25,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: _width / 8, right: _width / 8),
                              child: FlatButton(
                                onPressed: () {},
                                child: Container(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.assignment_turned_in),
                                    SizedBox(
                                      width: _width / 30,
                                    ),
                                    Text(
                                      '${teacher?.experience} Years of Experience',
                                    )
                                  ],
                                )),
                                color: Colors.blue[50],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      )
                    ], //
                  ),
                );
              }),
        ));
  }
}
