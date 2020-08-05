import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Profile/StudentProfilePage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class StudentsRequests extends StatefulWidget {
  @override
  _StudentsRequestsState createState() => _StudentsRequestsState();
}

class _StudentsRequestsState extends State<StudentsRequests> {
  DatabaseReference ref = FirebaseDatabase.instance.reference().child(
      'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students');
  GlobalKey<ScaffoldState> _scKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scKey,
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
                stream: ref.onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, Student> students = Map<String, Student>();
                    snapshot.data.snapshot.value?.forEach((key, student) {
                      Student studentp = Student.fromJson(student);
                      if (studentp.status == 'Existing Student') {
                        students[key] = studentp;
                      }
                    });
                    return ListView.builder(
                      itemCount: students?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: StudentRequestListTile(
                            keyS: students.keys.toList()[index],
                            student: students[students.keys.toList()[index]],
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
}

class StudentRequestListTile extends StatefulWidget {
  final String keyS;
  final Student student;
  StudentRequestListTile({this.keyS, this.student});
  @override
  _StudentRequestListTileState createState() => _StudentRequestListTileState();
}

class _StudentRequestListTileState extends State<StudentRequestListTile> {
  DatabaseReference ref = FirebaseDatabase.instance.reference().child(
      'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students');
  String selectedCourseID;
  Courses selectedCourse;
  @override
  void initState() {
    selectedCourseID = widget.student.classs;
    super.initState();
  }

  paidOneTime(double totalfees, String duration, String date, String courseId,
      String studentUid) async {
    await FirebaseDatabase.instance
        .reference()
        .child(
            "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/$studentUid/course/$courseId/fees/")
        .update({
      "Installments": {
        "OneTime": {
          "Amount": totalfees,
          "Duration": duration,
          "Status": "Paid",
          "PaidTime": date,
          "Fine": "",
          "PaidInstallment": "",
          "PaidFine": "",
        },
        "AllowedThrough": "OneTime",
        "LastPaidInstallment": "OneTime"
      }
    });
  }

  _updateList(
      List<bool> paidInstallment,
      Map<String, Installment> _listInstallment,
      String courseId,
      String studentUid,
      String date) async {
    var keys = _listInstallment.keys.toList()..sort();

    for (int i = 0; i < _listInstallment.length; i++) {
      if (i < paidInstallment.length ? !paidInstallment[i] : false) {
        FirebaseDatabase.instance
            .reference()
            .child(
                "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/$studentUid/course/$courseId/fees/Installments")
            .update({
          keys[i]: {
            "Amount":
                (double.parse(_listInstallment[keys[i]].amount)).toString(),
            "Duration": _listInstallment[keys[i]].duration,
            "Status": "Due",
            "PaidTime": "",
            "Fine": ""
          }
        });
      } else {
        FirebaseDatabase.instance
            .reference()
            .child(
                "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/$studentUid/course/$courseId/fees/Installments")
            .update(
          {
            keys[i]: {
              "Amount": _listInstallment[keys[i]].amount,
              "Duration": _listInstallment[keys[i]].duration,
              "Status": "Paid",
              "PaidTime": date,
              "Fine": ""
            },
            "AllowedThrough": "Installments",
            "LastPaidInstallment": keys[i]
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => StudentProfilePage(
                student: widget.student, keyS: widget.keyS)));
      },
      child: Card(
        elevation: 5.0,
        color: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(widget.student.photoURL),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 0),
                      child: Text(
                        ' ${widget.student.name}',
                        style: TextStyle(
                          color: Color(
                            0xffF36C24,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        '${widget.student.email}',
                        style: TextStyle(
                          color: Color(
                            0xffF36C24,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        '${widget.student.phoneNo}',
                        style: TextStyle(
                          color: Color(
                            0xffF36C24,
                          ),
                        ),
                      ),
                    ),
                    StreamBuilder<Event>(
                      stream: ref.parent().child('/courses').onValue,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Map<String, Courses> courses = Map<String, Courses>();
                          snapshot.data.snapshot.value.forEach((k, v) {
                            courses[k] = (Courses.fromJson(v));
                            if (k.toString() == widget.student.classs) {
                              if (selectedCourse == null) {
                                selectedCourse = Courses.fromJson(v);
                              }
                            }
                          });
                          return DropdownButton<String>(
                              value: selectedCourseID,
                              hint: Text('Select Course'.tr()),
                              items: courses
                                  .map(
                                    (k, e) => MapEntry(
                                      k,
                                      DropdownMenuItem(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          child: Text(
                                            e.name,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        value: e.id,
                                      ),
                                    ),
                                  )
                                  .values
                                  .toList(),
                              onChanged: (value) {
                                setState(
                                  () {
                                    selectedCourseID = value;
                                    selectedCourse = courses[value];
                                  },
                                );
                              });
                        } else {
                          return Container();
                        }
                      },
                    )
                  ],
                ),
              ],
            ),
            StreamBuilder<Event>(
                stream:
                    ref.parent().child('/courses/$selectedCourseID').onValue,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  Courses selectedCourse =
                      Courses.fromJson(snapshot.data.snapshot.value);
                  return ListView(
                    shrinkWrap: true,
                    controller: ScrollController(),
                    children: [
                      if (selectedCourse?.fees?.oneTime?.isOneTimeAllowed ??
                          false)
                        SwitchListTile.adaptive(
                          title: Text('Paid One Time'),
                          value: widget
                                  .student.requestedCourseFee?.isPaidOneTime ??
                              false,
                          onChanged: ((selectedCourse
                                          ?.fees?.oneTime?.isOneTimeAllowed ??
                                      false) &&
                                  (selectedCourse?.fees?.maxInstallment
                                          ?.isMaxAllowed ??
                                      false))
                              ? (val) {
                                  setState(() {
                                    widget.student.requestedCourseFee
                                            .isPaidOneTime =
                                        !widget.student.requestedCourseFee
                                            .isPaidOneTime;
                                  });
                                }
                              : null,
                        ),
                      if (selectedCourse?.fees?.maxInstallment?.isMaxAllowed ??
                          false)
                        SwitchListTile.adaptive(
                          title: Text('Paid In Installments'),
                          value: !(widget
                                  .student.requestedCourseFee?.isPaidOneTime ??
                              true),
                          onChanged: ((selectedCourse
                                          ?.fees?.oneTime?.isOneTimeAllowed ??
                                      false) &&
                                  (selectedCourse?.fees?.maxInstallment
                                          ?.isMaxAllowed ??
                                      false))
                              ? (val) {
                                  setState(() {
                                    widget.student.requestedCourseFee
                                            .isPaidOneTime =
                                        !widget.student.requestedCourseFee
                                            .isPaidOneTime;
                                  });
                                }
                              : null,
                        ),
                      if (!(widget.student.requestedCourseFee?.isPaidOneTime ??
                              true) &&
                          (selectedCourse?.fees?.maxInstallment?.isMaxAllowed ??
                              false))
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: int.parse(selectedCourse?.fees
                                  ?.maxInstallment?.maxAllowedInstallment ??
                              "0"),
                          itemBuilder: (context, index) {
                            if (widget
                                    .student.requestedCourseFee.installments ==
                                null) {
                              widget.student.requestedCourseFee.installments =
                                  List<bool>.filled(
                                      int.parse(selectedCourse
                                              ?.fees
                                              ?.maxInstallment
                                              ?.maxAllowedInstallment ??
                                          "0"),
                                      false,
                                      growable: true);
                            }
                            return CheckboxListTile(
                              title: Text('Installment ${index + 1}'),
                              value: widget.student.requestedCourseFee
                                  .installments[index],
                              onChanged: (val) {
                                setState(
                                  () {
                                    if (val == true) {
                                      for (int i = 0; i <= index; i++) {
                                        widget.student.requestedCourseFee
                                            .installments[i] = true;
                                      }
                                    } else {
                                      for (int i = index;
                                          i <
                                              widget.student.requestedCourseFee
                                                  .installments.length;
                                          i++) {
                                        print(i);
                                        widget.student.requestedCourseFee
                                            .installments[i] = false;
                                      }
                                    }
                                  },
                                );
                              },
                            );
                          },
                        ),
                    ],
                  );
                }),
            Container(
              child: ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    color: Color(0xffF36C24),
                    onPressed: () {
                      if (selectedCourseID == null || selectedCourse == null) {
                        Alert.instance.alert(
                            context, 'Select the course for Student'.tr());
                      } else {
                        Course course = Course(
                          academicYear: DateTime.now().year.toString() +
                              '-' +
                              (DateTime.now().year + 1).toString(),
                          courseID: selectedCourseID,
                          courseName: selectedCourse.name,
                          paymentToken:
                              'Registered By ${FireBaseAuth.instance.user.displayName}',
                        );
                        ref.child(widget.keyS).update(
                          {
                            'status': 'Registered',
                          },
                        );
                        ref
                            .child(widget.keyS + '/course')
                            .child(selectedCourseID)
                            .update(course.toJson());
                        DateTime dateTime = DateTime.now();
                        String dd = dateTime.day.toString().length == 1
                            ? "0" + dateTime.day.toString()
                            : dateTime.day.toString();
                        String mm = dateTime.month.toString().length == 1
                            ? "0" + dateTime.month.toString()
                            : dateTime.month.toString();
                        String yyyy = dateTime.year.toString();
                        String date = dd + " " + mm + " " + yyyy;
                        if ((selectedCourse?.fees?.oneTime?.isOneTimeAllowed ??
                                false) &&
                            (widget.student.requestedCourseFee?.isPaidOneTime ??
                                false)) {
                          paidOneTime(
                              double.parse(
                                  selectedCourse.fees.feeSection.totalFees),
                              (selectedCourse.fees.oneTime.duration),
                              (date),
                              selectedCourse.id,
                              widget.keyS);
                        } else if (!(widget.student.requestedCourseFee
                                    ?.isPaidOneTime ??
                                true) &&
                            (selectedCourse
                                    ?.fees?.maxInstallment?.isMaxAllowed ??
                                false)) {
                          _updateList(
                              widget.student.requestedCourseFee.installments,
                              selectedCourse.fees.maxInstallment.installment,
                              selectedCourse.id,
                              widget.keyS,
                              date);
                        }
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => StudentsRequests()));
                      }
                    },
                    child: Text(
                      'ACCEPT',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  FlatButton(
                    color: Color(0xffF36C24),
                    onPressed: () {
                      ref.child(widget.keyS).remove();
                    },
                    child: Text(
                      'REJECT',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
