import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Profile/next.dart';
import 'package:coach_app/adminSection/teacherRegister.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class TeachersList extends StatefulWidget {
  @override
  _TeachersListState createState() => _TeachersListState();
}

class _TeachersListState extends State<TeachersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getDrawer(context),
      appBar: AppBar(
        title: Text(
          'Teacher'.tr(),
          style: GoogleFonts.portLligatSans(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData.fallback().copyWith(color: Colors.white),
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
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 12,
              child: StreamBuilder<Event>(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child(
                        'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/teachers')
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, Teacher> teachers = Map<String, Teacher>();
                    snapshot.data.snapshot.value?.forEach((k, teacher) {
                      teachers[k] = Teacher.fromJson(teacher);
                    });
                    return ListView.builder(
                      itemCount: teachers?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            title: Text(
                              '${teachers[teachers.keys.toList()[index]].name}',
                              style: TextStyle(color: Colors.orange),
                            ),
                            subtitle: Text(
                              '${teachers[teachers.keys.toList()[index]].email}',
                              style: TextStyle(color: Colors.orange),
                            ),
                            trailing: Icon(
                              Icons.chevron_right,
                              color: Colors.orange,
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => TeacherProfilePage(
                                    reference: FirebaseDatabase.instance
                                        .reference()
                                        .child(
                                            'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/teachers/${teachers.keys.toList()[index]}'),
                                  ),
                                ),
                              );
                            },
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => TeacherRegister(isEdit: true,keyT: teachers.keys.toList()[index],teacher: teachers[teachers.keys.toList()[index]],));
                            },
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            title: PlaceholderLines(
                              count: 1,
                              animate: true,
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.orange, Colors.deepOrange])),
            child: Icon(
              Icons.add,
              color: Colors.white,
            )),
        onPressed: () => showDialog(
            context: context, builder: (context) => TeacherRegister()),
      ),
    );
  }
}
