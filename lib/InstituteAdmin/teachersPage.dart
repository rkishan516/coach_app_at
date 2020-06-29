import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/GlobalFunction/SlideButton.dart';
import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Profile/next.dart';
import 'package:coach_app/adminSection/teacherRegister.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TeachersList extends StatefulWidget {
  @override
  _TeachersListState createState() => _TeachersListState();
}

class _TeachersListState extends State<TeachersList> {
  TextEditingController searchTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getDrawer(context),
      appBar: getAppBar(context),
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
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchTextEditingController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Color(0xfff3f3f4),
                    ),
                  ),
                  contentPadding: EdgeInsets.only(left: 10),
                  hintStyle: TextStyle(fontSize: 15),
                  hintText: 'Search by teacher name'.tr(),
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                ),
              ),
            ),
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
                      if (searchTextEditingController.text == '') {
                        teachers[k] = Teacher.fromJson(teacher);
                      } else {
                        Teacher sTeacher = Teacher.fromJson(teacher);
                        if (sTeacher.name
                            .contains(searchTextEditingController.text)) {
                          teachers[k] = sTeacher;
                        }
                      }
                    });
                    return Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(searchTextEditingController.text =='' ? 'Total Teachers : ${teachers.length}' : 'Found Teachers : ${teachers.length}'),
                          ),
                        ),
                        Expanded(
                          flex: 12,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount: teachers?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                    title: Text(
                                      '${teachers[teachers.keys.toList()[index]].name}',
                                      style:
                                          TextStyle(color: Color(0xffF36C24)),
                                    ),
                                    subtitle: Text(
                                      '${teachers[teachers.keys.toList()[index]].email}',
                                      style:
                                          TextStyle(color: Color(0xffF36C24)),
                                    ),
                                    trailing: Icon(
                                      Icons.chevron_right,
                                      color: Color(0xffF36C24),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TeacherProfilePage(
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
                                          builder: (context) => TeacherRegister(
                                                isEdit: true,
                                                keyT: teachers.keys
                                                    .toList()[index],
                                                teacher: teachers[teachers.keys
                                                    .toList()[index]],
                                              ));
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SlideButton(
        text: 'Add Teacher'.tr(),
        onTap: () => showDialog(
            context: context, builder: (context) => TeacherRegister()),
        width: 150,
        height: 50,
      ),
    );
  }
}
