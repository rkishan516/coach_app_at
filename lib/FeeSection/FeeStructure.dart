import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Utils/Colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'FeeReport.dart';

class FeeStructure extends StatefulWidget {
  @override
  _FeeStructureState createState() => _FeeStructureState();
}

class _FeeStructureState extends State<FeeStructure> {
  final dbRef = FirebaseDatabase.instance;
  List<Courses> _list = [];
  Map<String, String> map = new Map();
  @override
  void initState() {
    super.initState();
    _loadFromDatabase();
  }

  _loadFromDatabase() async {
    dbRef
        .reference()
        .child(
            "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}")
        .child("coursesList")
        .once()
        .then((snapshot) {
      snapshot.value.forEach((key, value) {
        setState(() {
          _list.add(Courses(key, value));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fee Management"),
        backgroundColor: GuruCoolLightColor.primaryColor,
      ),
      body: Container(
        color: GuruCoolLightColor.primaryColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(12.0),
        child: ListView.builder(
            itemCount: _list.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(_list[index].courseName),
                  trailing: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.book,
                            color: GuruCoolLightColor.primaryColor,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => FeesReport(
                                      courseId: _list[index].key,
                                    )));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class Courses {
  String key;
  String courseName;

  Courses(this.key, this.courseName);
}
