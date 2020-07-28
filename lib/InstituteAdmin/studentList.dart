import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Profile/StudentProfile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class StudentList extends StatefulWidget {
  final String courseId;
  StudentList({this.courseId});
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  TextEditingController searchTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widget.courseId != null ? null : getDrawer(context),
      appBar: widget.courseId != null ? null : getAppBar(context),
      body: Container(
        padding: widget.courseId != null
            ? EdgeInsets.all(0)
            : EdgeInsets.symmetric(
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
                  hintText: 'Search by student name'.tr(),
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
                        'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students')
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, Student> students = Map<String, Student>();
                    snapshot.data.snapshot.value?.forEach((k, student) {
                      if (widget.courseId != null) {
                        if (searchTextEditingController.text == '') {
                          if (student['course'] != null) {
                            if (student['course'][widget.courseId] != null) {
                              Student sstudent = Student.fromJson(student);
                              if (sstudent.status == 'Registered') {
                                students[k] = sstudent;
                              }
                            }
                          }
                        } else {
                          Student sstudent = Student.fromJson(student);
                          if (sstudent.name
                                  .contains(searchTextEditingController.text) &&
                              sstudent.course?.firstWhere((element) =>
                                      element.courseID == widget.courseId) !=
                                  null) {
                            if (sstudent.status == 'Registered') {
                              students[k] = sstudent;
                            }
                          }
                        }
                      } else {
                        if (searchTextEditingController.text == '') {
                          Student sstudent = Student.fromJson(student);
                          if (sstudent.status == 'Registered') {
                            students[k] = sstudent;
                          }
                        } else {
                          Student sstudent = Student.fromJson(student);
                          if (sstudent.name
                              .contains(searchTextEditingController.text)) {
                            if (sstudent.status == 'Registered') {
                              students[k] = sstudent;
                            }
                          }
                        }
                      }
                    });
                    return Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(searchTextEditingController.text == ''
                                ? 'Total Students : ${students.length}'
                                : 'Found Students : ${students.length}'),
                          ),
                        ),
                        Expanded(
                          flex: 12,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount: students?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                    title: Text(
                                      '${students[students.keys.toList()[index]].name}',
                                      style:
                                          TextStyle(color: Color(0xffF36C24)),
                                    ),
                                    subtitle: Text(
                                      '${students[students.keys.toList()[index]].email}',
                                      style:
                                          TextStyle(color: Color(0xffF36C24)),
                                    ),
                                    trailing: Icon(
                                      Icons.chevron_right,
                                      color: Color(0xffF36C24),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => StudentProfile(
                                              student: students[students.keys
                                                  .toList()[index]],
                                              keyS: students.keys
                                                  .toList()[index]),
                                        ),
                                      );
                                    },
                                    onLongPress: () => editStudent(
                                        students[students.keys.toList()[index]],
                                        students.keys.toList()[index]),
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
    );
  }

  editStudent(Student student, String keyS) {
    TextEditingController nameTextEditingController = TextEditingController()
      ..text = student?.name ?? '';
    TextEditingController addressTextEditingController = TextEditingController()
      ..text = student?.address ?? '';
    TextEditingController phoneTextEditingController = TextEditingController()
      ..text = student?.phoneNo ?? '';
    // Courses course;
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
              // StreamBuilder<Event>(
              //   stream: FirebaseDatabase.instance
              //       .reference()
              //       .child(
              //           'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses')
              //       .onValue,
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       List<Courses> courses = List<Courses>();
              //       snapshot.data.snapshot.value?.forEach((k, v) {
              //         courses.add(Courses.fromJson(v));
              //       });
              //       return DropdownButton(
              //           value: course,
              //           hint: Text('Select Course'.tr()),
              //           items: courses
              //               .map(
              //                 (k) => DropdownMenuItem(
              //                   child: Container(
              //                     width: MediaQuery.of(context).size.width / 5,
              //                     child: Text(
              //                       k.name,
              //                       overflow: TextOverflow.ellipsis,
              //                     ),
              //                   ),
              //                   value: k,
              //                 ),
              //               )
              //               .toList(),
              //           onChanged: (value) {
              //             setState(() {
              //               course = value;
              //             });
              //           });
              //     } else {
              //       return Container();
              //     }
              //   },
              // ),
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
                          Alert.instance.alert(
                              context, 'Something remains unfilled'.tr());
                          return;
                        }
                        // bool flag = false;
                        // if (course != null) {
                        //   student.course?.forEach((element) {
                        //     if (course.id == element.courseID) {
                        //       flag = true;
                        //     }
                        //   });
                        //   if (flag == false) {
                        //     Course(
                        //         academicYear: DateTime.now().year.toString() +
                        //             '-' +
                        //             (DateTime.now().year + 1).toString(),
                        //         courseID: course.id,
                        //         courseName: course.name,
                        //         paymentToken:
                        //             'Registered By ${FireBaseAuth.instance.user.displayName}');
                        //   }
                        // }
                        Student dstudent = Student(
                            name: nameTextEditingController.text,
                            address: addressTextEditingController.text,
                            phoneNo: phoneTextEditingController.text,
                            email: student.email,
                            status: student.status,
                            photoURL: student.photoURL,
                            classs: student.classs,
                            rollNo: student.rollNo);
                        FirebaseDatabase.instance
                            .reference()
                            .child(
                                'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/$keyS')
                            .update(dstudent.toJson());
                        Navigator.of(context).pop();
                      },
                      child: Text('Update Student'.tr()),
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
