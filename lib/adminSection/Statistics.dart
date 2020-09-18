import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Provider/AdminProvider.dart';
import 'package:coach_app/Provider/MidAdminProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  String filter = "";
  @override
  Widget build(BuildContext context) {
    Map<String, Branch> branches = (FireBaseAuth.instance.previlagelevel == 4)
        ? Provider.of<AdminProvider>(context).branch
        : (FireBaseAuth.instance.previlagelevel == 34)
            ? Provider.of<MidAdminProvider>(context).branches
            : Map<String, Branch>();
    if (filter != "") {
      branches.removeWhere((key, value) => !filter.contains(key.toString()));
    }
    Map<String, MidAdmin> midAdmin = (FireBaseAuth.instance.previlagelevel == 4)
        ? Provider.of<AdminProvider>(context).midAdmins
        : Map<String, MidAdmin>();
    int teacherCount = 0,
        studentCount = 0,
        branchesCount = 0,
        coursesCount = 0,
        studentRequestCount = 0;
    branchesCount = branches?.length ?? 0;
    branches?.forEach((key, value) {
      coursesCount += value.courses?.length ?? 0;
      studentCount += value.students?.values
              ?.toList()
              ?.where((element) => element.status == "Registered")
              ?.length ??
          0;
      studentRequestCount += value.students?.values
              ?.toList()
              ?.where((element) => element.status == "Existing Student")
              ?.length ??
          0;
      teacherCount += value.teachers?.length ?? 0;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Statistics',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
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
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Stack(
                          children: [
                            Center(child: Text('Total')),
                            if (FireBaseAuth.instance.previlagelevel == 4)
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20.0, top: 2),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(
                                          0xffF36C24,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: EdgeInsets.only(left: 5, right: 5),
                                    child: DropdownButton(
                                        selectedItemBuilder: (context) {
                                          return [
                                            Container(
                                              color: Color(
                                                0xffF36C24,
                                              ),
                                              child: Text(
                                                'filter',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ];
                                        },
                                        hint: Text(
                                          'filter',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        items: ['None', 'Mid - Admins']
                                            .map(
                                              (e) => DropdownMenuItem(
                                                value: e,
                                                child: Text(
                                                  e,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (value) {
                                          if (value == 'Mid - Admins') {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    elevation: 0.0,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    child: Stack(
                                                      children: <Widget>[
                                                        Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          padding:
                                                              EdgeInsets.all(
                                                            16.0,
                                                          ),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 66.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            shape: BoxShape
                                                                .rectangle,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black26,
                                                                blurRadius:
                                                                    10.0,
                                                                offset:
                                                                    const Offset(
                                                                        0.0,
                                                                        10.0),
                                                              ),
                                                            ],
                                                          ),
                                                          child:
                                                              ListView.builder(
                                                            itemCount:
                                                                midAdmin.length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return ListTile(
                                                                title: Text(midAdmin[
                                                                        midAdmin
                                                                            .keys
                                                                            .toList()[index]]
                                                                    .name),
                                                                onTap: () {
                                                                  setState(() {
                                                                    filter = midAdmin[midAdmin
                                                                            .keys
                                                                            .toList()[index]]
                                                                        .branches;
                                                                  });
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                          } else {
                                            setState(() {
                                              filter = "";
                                            });
                                          }
                                        }),
                                  ),
                                ),
                              )
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StatisticsCapsule(
                            text: "Branches", count: branchesCount.toString()),
                        StatisticsCapsule(
                            text: "Courses", count: coursesCount.toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StatisticsCapsule(
                          text: "Teachers",
                          count: teacherCount.toString(),
                        ),
                        StatisticsCapsule(
                          text: "Student",
                          count: studentCount.toString(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StatisticsCapsule(
                          text: "Student Request",
                          count: studentRequestCount.toString(),
                          width: 1.2 * MediaQuery.of(context).size.width / 2,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Divider(
                color: Colors.black54,
                height: 0.75,
                thickness: 0.75,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  children: [
                    Expanded(child: Center(child: Text('Overall Analysis'))),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: Container(
                          padding: EdgeInsets.only(top: 12, bottom: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(
                                10,
                              ),
                              topLeft: Radius.circular(
                                10,
                              ),
                            ),
                            color: Color(0xffF36C24),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Branches',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Courses',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Teachers',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Students',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12.0, top: 0, bottom: 20),
                      child: Card(
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(
                              10,
                            ),
                            bottomLeft: Radius.circular(
                              10,
                            ),
                          ),
                        ),
                        child: Container(
                          height: 1.25 * MediaQuery.of(context).size.height / 3,
                          child: ListView.builder(
                              itemCount: branches?.length ?? 0,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.only(top: 12, bottom: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Center(
                                            child: Text(
                                              branches[branches.keys
                                                      .toList()[index]]
                                                  .name,
                                              style: TextStyle(
                                                fontSize: 6,
                                                color: Color(0xffF36C24),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            (branches[branches.keys
                                                            .toList()[index]]
                                                        .courses
                                                        ?.length ??
                                                    0)
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            (branches[branches.keys
                                                            .toList()[index]]
                                                        .teachers
                                                        ?.length ??
                                                    0)
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            (branches[branches.keys
                                                            .toList()[index]]
                                                        .students
                                                        ?.values
                                                        ?.toList()
                                                        ?.where((element) =>
                                                            element.status ==
                                                            "Registered")
                                                        ?.length ??
                                                    0)
                                                .toString(),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
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
    );
  }
}

class StatisticsCapsule extends StatelessWidget {
  final String text, count;
  final double width;
  StatisticsCapsule({@required this.text, @required this.count, this.width});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Container(
        width: width ?? 1.2 * MediaQuery.of(context).size.width / 3,
        child: Row(
          children: [
            Expanded(
              flex: 25,
              child: Container(
                padding: EdgeInsets.all(12),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Color(
                        0xffF36C24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 19,
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xffF36C24),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                padding: EdgeInsets.all(12),
                child: Center(
                  child: Text(
                    count,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
