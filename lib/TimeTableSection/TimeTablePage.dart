import 'dart:async';

import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class Periods {
  TimeOfDay startTime;
  TimeOfDay endTime;
  Periods({this.startTime, this.endTime});
}

class TimeTablePage extends StatefulWidget {
  final String courseId;
  TimeTablePage({@required this.courseId});
  @override
  _TimeTablePageState createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {
  int noOfRow = 1;
  List<Periods> timePeriods;
  String day1, day2;
  Courses courses;
  TimeTable timeTable;
  PageController pageController;
  ScrollController controller1,
      controllerMonday,
      controllerTuesday,
      controllerWednesday,
      controllerThursday,
      controllerFriday,
      controllerSaturday;
  LinkedScrollControllerGroup controllerGroup;
  StreamSubscription<Event> dataFetch;

  @override
  void initState() {
    pageController = PageController();
    controllerGroup = LinkedScrollControllerGroup();
    controller1 = controllerGroup.addAndGet();
    controllerMonday = controllerGroup.addAndGet();
    controllerTuesday = controllerGroup.addAndGet();
    controllerWednesday = controllerGroup.addAndGet();
    controllerThursday = controllerGroup.addAndGet();
    controllerFriday = controllerGroup.addAndGet();
    controllerSaturday = controllerGroup.addAndGet();
    timePeriods = List<Periods>();
    timePeriods
        .add(Periods(startTime: TimeOfDay.now(), endTime: TimeOfDay.now()));
    day1 = "Monday";
    day2 = "Tuesday";
    dataFetch = FirebaseDatabase.instance
        .reference()
        .child(
            'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseId}')
        .onValue
        .listen((event) {
      setState(() {
        courses = Courses.fromJson(event.snapshot.value);
        if (courses.timeTable != null && noOfRow == 1) {
          timeTable = courses.timeTable;
          timePeriods = List<Periods>();
          timeTable.monday.forEach((timeTableClass) {
            int flag = 0;
            timePeriods.forEach((element) {
              if (element.endTime == timeTableClass.endTime &&
                  element.startTime == timeTableClass.startTime) {
                flag = 1;
              }
            });
            if (flag == 0) {
              timePeriods.add(Periods(
                  endTime: timeTableClass.endTime,
                  startTime: timeTableClass.startTime));
            }
          });
          timeTable.tuesday.forEach((timeTableClass) {
            int flag = 0;
            timePeriods.forEach((element) {
              if (element.endTime == timeTableClass.endTime &&
                  element.startTime == timeTableClass.startTime) {
                flag = 1;
              }
            });
            if (flag == 0) {
              timePeriods.add(Periods(
                  endTime: timeTableClass.endTime,
                  startTime: timeTableClass.startTime));
            }
          });
          timeTable.wednesday.forEach((timeTableClass) {
            int flag = 0;
            timePeriods.forEach((element) {
              if (element.endTime == timeTableClass.endTime &&
                  element.startTime == timeTableClass.startTime) {
                flag = 1;
              }
            });
            if (flag == 0) {
              timePeriods.add(Periods(
                  endTime: timeTableClass.endTime,
                  startTime: timeTableClass.startTime));
            }
          });
          timeTable.thursday.forEach((timeTableClass) {
            int flag = 0;
            timePeriods.forEach((element) {
              if (element.endTime == timeTableClass.endTime &&
                  element.startTime == timeTableClass.startTime) {
                flag = 1;
              }
            });
            if (flag == 0) {
              timePeriods.add(Periods(
                  endTime: timeTableClass.endTime,
                  startTime: timeTableClass.startTime));
            }
          });
          timeTable.friday.forEach((timeTableClass) {
            int flag = 0;
            timePeriods.forEach((element) {
              if (element.endTime == timeTableClass.endTime &&
                  element.startTime == timeTableClass.startTime) {
                flag = 1;
              }
            });
            if (flag == 0) {
              timePeriods.add(Periods(
                  endTime: timeTableClass.endTime,
                  startTime: timeTableClass.startTime));
            }
          });
          timeTable.saturday.forEach((timeTableClass) {
            int flag = 0;
            timePeriods.forEach((element) {
              if (element.endTime == timeTableClass.endTime &&
                  element.startTime == timeTableClass.startTime) {
                flag = 1;
              }
            });
            if (flag == 0) {
              timePeriods.add(Periods(
                  endTime: timeTableClass.endTime,
                  startTime: timeTableClass.startTime));
            }
          });
          noOfRow = timePeriods.length;
        }
      });
    });
    timeTable = TimeTable(
        monday: [],
        tuesday: [],
        wednesday: [],
        thursday: [],
        friday: [],
        saturday: []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: Column(
        children: [
          Container(
            height: height / 2,
            padding: EdgeInsets.only(
              left: width / 20,
              right: width / 20,
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: Color(0xffF36C24),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            'Timing',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            if (day1 != "Monday")
                              Align(
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  onTap: () {
                                    pageController.previousPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOutExpo);
                                  },
                                  child: Text(
                                    "<",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            Center(
                              child: Text(
                                day1,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Center(
                              child: Text(
                                day2,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            if (day2 != "Saturday")
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    pageController.nextPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOutExpo);
                                  },
                                  child: Text(
                                    ">",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            width: 3 * width / 10,
                            child: ListView.builder(
                              controller: controller1,
                              shrinkWrap: true,
                              itemCount: noOfRow,
                              itemBuilder: (context, index) {
                                String time = TimeOfDay.now()
                                        .format(context)
                                        .toString() +
                                    "\n-\n" +
                                    TimeOfDay.now().format(context).toString();
                                if (timePeriods.length > index) {
                                  time = timePeriods[index]
                                          .startTime
                                          .format(context)
                                          .toString() +
                                      "\n-\n" +
                                      timePeriods[index]
                                          .endTime
                                          .format(context)
                                          .toString();
                                }
                                return InkWell(
                                  onTap:
                                      (FireBaseAuth.instance.previlagelevel >=
                                              3)
                                          ? () => addTimePeriod(index)
                                          : null,
                                  child: Card(
                                    shape: (index == noOfRow - 1)
                                        ? RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(
                                                10,
                                              ),
                                            ),
                                          )
                                        : null,
                                    child: Container(
                                      width: 2.85 * width / 10,
                                      height: height / 10,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            time,
                                            style: TextStyle(
                                                color: Color(0xffF36C24)),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: height / 2,
                            child: PageView(
                              onPageChanged: (position) {
                                setState(() {
                                  if (position == 0) {
                                    day1 = "Monday";
                                    day2 = "Tuesday";
                                  } else if (position == 1) {
                                    day1 = "Wednesday";
                                    day2 = "Thursday";
                                  } else {
                                    day1 = "Friday";
                                    day2 = "Saturday";
                                  }
                                });
                              },
                              children: [
                                buildRow(width, height, controllerMonday,
                                    controllerTuesday),
                                buildRow(width, height, controllerWednesday,
                                    controllerThursday),
                                buildRow(width, height, controllerFriday,
                                    controllerSaturday),
                              ],
                              controller: pageController,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (FireBaseAuth.instance.previlagelevel >= 3)
            RaisedButton(
              color: Color(0xffF36C24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              padding: EdgeInsets.only(left: 50, right: 50),
              onPressed: () => setState(() {
                noOfRow++;
                timePeriods.add(Periods(
                    startTime: TimeOfDay.now(), endTime: TimeOfDay.now()));
              }),
              child: Text(
                'Add Row',
                style: TextStyle(color: Colors.white),
              ),
            ),
          if (FireBaseAuth.instance.previlagelevel >= 3)
            RaisedButton(
              color: Color(0xffF36C24),
              padding: EdgeInsets.only(left: 40, right: 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              onPressed: () => setState(() {
                if (noOfRow > 1) {
                  removeRow();
                }
              }),
              child: Text(
                'Remove Row',
                style: TextStyle(color: Colors.white),
              ),
            )
        ],
      ),
    );
  }

  removeRow() {
    timeTable.monday.removeWhere(
      (element) => (element.startTime == timePeriods.last.startTime &&
          element.endTime == timePeriods.last.endTime),
    );
    timeTable.tuesday.removeWhere(
      (element) => (element.startTime == timePeriods.last.startTime &&
          element.endTime == timePeriods.last.endTime),
    );
    timeTable.wednesday.removeWhere(
      (element) => (element.startTime == timePeriods.last.startTime &&
          element.endTime == timePeriods.last.endTime),
    );
    timeTable.thursday.removeWhere(
      (element) => (element.startTime == timePeriods.last.startTime &&
          element.endTime == timePeriods.last.endTime),
    );
    timeTable.friday.removeWhere(
      (element) => (element.startTime == timePeriods.last.startTime &&
          element.endTime == timePeriods.last.endTime),
    );
    timeTable.saturday.removeWhere(
      (element) => (element.startTime == timePeriods.last.startTime &&
          element.endTime == timePeriods.last.endTime),
    );
    FirebaseDatabase.instance
        .reference()
        .child(
            "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseId}/TimeTable")
        .update(timeTable.toJson());
    timePeriods.removeLast();
    noOfRow--;
  }

  Row buildRow(double width, double height, ScrollController controllerDay1,
      ScrollController controllerDay2) {
    List<TimeTableClass> firstWidget, secondWidget;

    if (courses != null) {
      if (courses.timeTable != null) {
        if (day1 == "Monday") {
          if (courses.timeTable.monday != null) {
            firstWidget = courses.timeTable.monday;
          }
        } else if (day1 == "Wednesday") {
          if (courses.timeTable.wednesday != null) {
            firstWidget = courses.timeTable.wednesday;
          }
        } else if (day1 == "Friday") {
          if (courses.timeTable.friday != null) {
            firstWidget = courses.timeTable.friday;
          }
        }
        if (day2 == "Tuesday") {
          if (courses.timeTable.tuesday != null) {
            secondWidget = courses.timeTable.tuesday;
          }
        } else if (day2 == "Thursday") {
          if (courses.timeTable.thursday != null) {
            secondWidget = courses.timeTable.thursday;
          }
        } else if (day2 == "Saturday") {
          if (courses.timeTable.saturday != null) {
            secondWidget = courses.timeTable.saturday;
          }
        }
      }
    }
    return Row(
      children: [
        Container(
          width: 3 * width / 10,
          child: ListView.builder(
            controller: controllerDay1,
            shrinkWrap: true,
            itemCount: noOfRow,
            padding: EdgeInsets.all(0),
            itemBuilder: (context, index) {
              String subject = 'Enter Subject';
              String teacher;
              if (firstWidget != null) {
                TimeTableClass timeTableClass;
                firstWidget.forEach((element) {
                  if (element.startTime == timePeriods[index].startTime &&
                      element.endTime == timePeriods[index].endTime) {
                    timeTableClass = element;
                  }
                });

                if (timeTableClass != null) {
                  subject = timeTableClass.subjectName;
                  teacher = timeTableClass.teacherName;
                }
              }
              return InkWell(
                onTap: (FireBaseAuth.instance.previlagelevel >= 3)
                    ? () => addTimeTableSubject(0, index)
                    : null,
                child: Card(
                  elevation: 0.0,
                  child: Container(
                    width: 3 * width / 10,
                    height: height / 10,
                    child: Stack(
                      children: [
                        if (subject != 'Enter Subject')
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                "Class",
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  (FireBaseAuth.instance.previlagelevel >= 3)
                                      ? subject
                                      : (subject == "Enter Subject")
                                          ? "Break"
                                          : subject,
                                  style: TextStyle(
                                    color: (subject != 'Enter Subject')
                                        ? Color(
                                            0xffF36C24,
                                          )
                                        : Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                if (teacher != null)
                                  Text(
                                    teacher,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          width: 3 * width / 10,
          child: ListView.builder(
            controller: controllerDay2,
            shrinkWrap: true,
            itemCount: noOfRow,
            itemBuilder: (context, index) {
              String subject = 'Enter Subject';
              String teacher;
              if (secondWidget != null) {
                TimeTableClass timeTableClass;
                secondWidget.forEach((element) {
                  if (element.startTime == timePeriods[index].startTime &&
                      element.endTime == timePeriods[index].endTime) {
                    timeTableClass = element;
                  }
                });

                if (timeTableClass != null) {
                  subject = timeTableClass.subjectName;
                  teacher = timeTableClass.teacherName;
                }
              }
              return InkWell(
                onTap: (FireBaseAuth.instance.previlagelevel >= 3)
                    ? () => addTimeTableSubject(1, index)
                    : null,
                child: Card(
                  shape: (index == noOfRow - 1)
                      ? RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(
                              10,
                            ),
                          ),
                        )
                      : null,
                  elevation: 0.0,
                  child: Container(
                    width: 3 * width / 10,
                    height: height / 10,
                    child: Stack(
                      children: [
                        if (subject != 'Enter Subject')
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                "Class",
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  (FireBaseAuth.instance.previlagelevel >= 3)
                                      ? subject
                                      : (subject == "Enter Subject")
                                          ? "Break"
                                          : subject,
                                  style: TextStyle(
                                    color: (subject != 'Enter Subject')
                                        ? Color(
                                            0xffF36C24,
                                          )
                                        : Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                if (teacher != null)
                                  Text(
                                    teacher,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                  ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  addTimePeriod(int i) async {
    timePeriods[i].startTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(hour: 00, minute: 00),
          helpText: "Class Start Time",
          initialEntryMode: TimePickerEntryMode.input,
        ) ??
        timePeriods[i].startTime ??
        TimeOfDay.now();
    timePeriods[i].endTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(hour: 00, minute: 00),
          helpText: "Class End Time",
          initialEntryMode: TimePickerEntryMode.input,
        ) ??
        timePeriods[i].endTime ??
        TimeOfDay.now();
    setState(() {});
  }

  addTimeTableSubject(int dayLine, int timeLine,
      {String name = '', String mentors = ''}) {
    Subjects selectedSubject;
    String selectedSubjectKey;
    String selectedTeacherKey;
    Teacher selectedTeacher;
    Map<String, Teacher> teachers;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => Dialog(
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
                        DropdownButton<String>(
                            hint: Text('Select Subject'),
                            value: selectedSubjectKey,
                            items: courses.subjects.entries
                                .map<DropdownMenuItem<String>>((e) =>
                                    DropdownMenuItem<String>(
                                        value: e.key,
                                        child: Text(e.value.name)))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                selectedSubjectKey = val;
                                courses.subjects?.forEach((key, value) {
                                  if (key == selectedSubjectKey) {
                                    selectedSubject = value;
                                  }
                                });
                              });
                            })
                      ],
                    ),
                  ),
                  if (selectedSubjectKey != null)
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Mentors',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          StreamBuilder<Event>(
                              stream: FirebaseDatabase.instance
                                  .reference()
                                  .child(
                                      'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/teachers')
                                  .onValue,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data.snapshot.value == null) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Center(
                                          child: Text(
                                            'Your Institute does not have any Teacher',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    teachers = Map<String, Teacher>();
                                    snapshot.data.snapshot.value?.forEach(
                                      (k, v) {
                                        Teacher teacher = Teacher.fromJson(v);
                                        // if (mentors.contains(teacher.email)) {
                                        //   selectedTeacher.add(teacher);
                                        // }
                                        teacher.courses?.forEach((course) {
                                          if (course.id == widget.courseId) {
                                            if (course.subjects
                                                .contains(selectedSubjectKey)) {
                                              teachers[k] = teacher;
                                            }
                                          }
                                        });
                                      },
                                    );
                                    return DropdownButton<String>(
                                      hint: Text('Select Teacher'),
                                      value: selectedTeacherKey,
                                      items: teachers.entries
                                          .map(
                                            (e) => DropdownMenuItem<String>(
                                              value: e.key,
                                              child: Text(e.value.name),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (val) {
                                        setState(() {
                                          selectedTeacherKey = val;
                                          teachers.forEach((key, value) {
                                            if (key == val) {
                                              selectedTeacher = value;
                                            }
                                          });
                                        });
                                      },
                                    );
                                  }
                                } else {
                                  return Container();
                                }
                              }),
                        ],
                      ),
                    ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        (name == '')
                            ? Container()
                            : FlatButton(
                                onPressed: () async {
                                  String res = await showDialog(
                                      context: context,
                                      builder: (context) => AreYouSure());
                                  if (res != 'Yes') {
                                    return;
                                  }

                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Remove',
                                ),
                              ),
                        FlatButton(
                          onPressed: () {
                            TimeTableClass timeTableClass = TimeTableClass(
                                classType: "class",
                                startTime: timePeriods[timeLine].startTime,
                                endTime: timePeriods[timeLine].endTime,
                                subjectKey: selectedSubjectKey,
                                subjectName: selectedSubject.name,
                                teacherKey: selectedTeacherKey,
                                teacherName: selectedTeacher.name);
                            if (dayLine == 0) {
                              if (day1 == "Monday") {
                                if (timeTable.monday.length > timeLine) {
                                  timeTable.monday[timeLine] = timeTableClass;
                                } else {
                                  timeTable.monday.add(timeTableClass);
                                }
                              } else if (day1 == "Wednesday") {
                                if (timeTable.wednesday.length > timeLine) {
                                  timeTable.wednesday[timeLine] =
                                      timeTableClass;
                                } else {
                                  timeTable.wednesday.add(timeTableClass);
                                }
                              } else if (day1 == "Friday") {
                                if (timeTable.friday.length > timeLine) {
                                  timeTable.friday[timeLine] = timeTableClass;
                                } else {
                                  timeTable.friday.add(timeTableClass);
                                }
                              }
                            } else {
                              if (day2 == "Tuesday") {
                                if (timeTable.tuesday.length > timeLine) {
                                  timeTable.tuesday[timeLine] = timeTableClass;
                                } else {
                                  timeTable.tuesday.add(timeTableClass);
                                }
                              } else if (day2 == "Thursday") {
                                if (timeTable.thursday.length > timeLine) {
                                  timeTable.thursday[timeLine] = timeTableClass;
                                } else {
                                  timeTable.thursday.add(timeTableClass);
                                }
                              } else if (day2 == "Saturday") {
                                if (timeTable.saturday.length > timeLine) {
                                  timeTable.saturday[timeLine] = timeTableClass;
                                } else {
                                  timeTable.saturday.add(timeTableClass);
                                }
                              }
                            }
                            FirebaseDatabase.instance
                                .reference()
                                .child(
                                    "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${widget.courseId}/TimeTable")
                                .update(timeTable.toJson());
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Add Class Period',
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
      },
    );
  }
}
