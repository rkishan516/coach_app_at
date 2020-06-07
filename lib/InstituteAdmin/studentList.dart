import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Profile/Studentprofileactivity.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class StudentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
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
            Expanded(
              flex: 12,
              child: StreamBuilder<Event>(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child(
                        'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students')
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, Student> students = Map<String, Student>();
                    snapshot.data.snapshot.value?.forEach((k, student) {
                      students[k] = Student.fromJson(student);
                    });
                    return ListView.builder(
                      itemCount: students?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            title: Text(
                              '${students[students.keys.toList()[index]].name}',
                              style: TextStyle(color: Colors.orange),
                            ),
                            subtitle: Text(
                              '${students[students.keys.toList()[index]].email}',
                              style: TextStyle(color: Colors.orange),
                            ),
                            trailing: Icon(
                              Icons.chevron_right,
                              color: Colors.orange,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Studentprofileactivity(
                                      student: students[
                                          students.keys.toList()[index]],
                                      keyS: students.keys.toList()[index]),
                                ),
                              );
                            },
                            onLongPress: () => editStudent(
                                students[students.keys.toList()[index]],
                                students.keys.toList()[index]),
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
    );
  }

  editStudent(Student student, String keyS) {
    TextEditingController nameTextEditingController = TextEditingController()
      ..text = student?.name ?? '';
    TextEditingController addressTextEditingController = TextEditingController()
      ..text = student?.address ?? '';
    TextEditingController phoneTextEditingController = TextEditingController()
      ..text = student?.phoneNo ?? '';
    Courses course;
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
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
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      controller: nameTextEditingController,
                      decoration: InputDecoration(
                        hintText: 'Name'.tr(),
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      controller: addressTextEditingController,
                      decoration: InputDecoration(
                        hintText: 'Address'.tr(),
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Phone No'.tr(),
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                      ),
                    )
                  ],
                ),
              ),
              StreamBuilder<Event>(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child(
                        'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses')
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Courses> courses = List<Courses>();
                    snapshot.data.snapshot.value?.forEach((k, v) {
                      courses.add(Courses.fromJson(v));
                    });
                    return DropdownButton(
                        value: course,
                        hint: Text('Select Course'.tr()),
                        items: courses
                            .map(
                              (k) => DropdownMenuItem(
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Text(
                                    k.name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                value: k,
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            course = value;
                          });
                        });
                  } else {
                    return Container();
                  }
                },
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        String res = await showDialog(
                            context: context,
                            builder: (context) => AreYouSure());
                        if (res != 'Yes') {
                          return;
                        }
                        FirebaseDatabase.instance
                            .reference()
                            .child(
                                'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/$keyS')
                            .remove();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Remove'.tr(),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        if (nameTextEditingController.text == '' ||
                            addressTextEditingController.text == '' ||
                            phoneTextEditingController.text == '') {
                          Alert.instance
                              .alert(context, 'Must Fill every detail');
                          return;
                        }
                        bool flag = false;
                        if (course != null) {
                          student.course?.forEach((element) {
                            if (course.id == element.courseID) {
                              flag = true;
                            }
                          });
                          if (flag == false) {
                            Course(
                                academicYear: DateTime.now().year.toString() +
                                    '-' +
                                    (DateTime.now().year + 1).toString(),
                                courseID: course.id,
                                courseName: course.name,
                                paymentToken:
                                    'Registered By ${FireBaseAuth.instance.user.displayName}');
                          }
                        }
                        student.name = nameTextEditingController.text;
                        student.address = addressTextEditingController.text;
                        student.phoneNo = phoneTextEditingController.text;
                        FirebaseDatabase.instance
                            .reference()
                            .child(
                                'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/${keyS}')
                            .set(student.toJson());
                        Navigator.of(context).pop();
                      },
                      child: Text('Update Student'),
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
