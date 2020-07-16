import 'package:coach_app/FeeSection/ToggleButton.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/Profile/student_performance.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Studentprofileactivity extends StatefulWidget {
  final Student student;
  final String keyS;
  Studentprofileactivity({@required this.student, @required this.keyS});
  @override
  _Studentinfostate createState() => _Studentinfostate();
}

class _Studentinfostate extends State<Studentprofileactivity> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Student'.tr()+' '+ 'Profile'.tr(),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          height: _height,
          width: _width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: _width < _height ? _width / 8 : _height / 8,
                  backgroundImage: NetworkImage(
                    widget.student.photoURL,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 220,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "${widget.student.name}",
                          style: TextStyle(fontSize: 23),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          "${widget.student.email}",
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          "${widget.student.phoneNo}",
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          "Student".tr(),
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: 100,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 4),
                              decoration: BoxDecoration(
                                  color: (Colors.green),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        color: (Colors.greenAccent),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Container(
                                    width: _width / 4,
                                    child: Text(
                                      "${widget.student.status}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_city,
                          color: Colors.green,
                          size: 100,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${widget.student.address.replaceAll(',', '\n')}",
                              style: TextStyle(
                                  color: Colors.black87.withOpacity(0.7),
                                  fontSize: 20),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            if (widget.student.course != null)
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.student.course.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StudentPerformance(
                              uid: widget.keyS,
                              courseId: widget.student.course[index].courseID,
                            ))),
                    child: Padding(
                      padding: new EdgeInsets.only(
                          top: 5.0, left: 20.0, right: 20.0, bottom: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xffF36C24),
                            borderRadius: BorderRadius.circular(5)),
                        padding: new EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "${widget.student.course[index].courseName}",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Text(
                                "${widget.student.course[index].academicYear}",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Text(
                                "${widget.student.course[index].paymentToken}",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ),
                            ToggleButton(studentUid: widget.keyS,courseId: widget.student.course[index].courseID,),
                            SizedBox(
                              height: 5,
                              width: _width,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            else
              Container(),
          ]),
        ),
      ),
    );
  }
}

class IconTile extends StatelessWidget {
  final String imgAssetPath;
  final Color backColor;

  IconTile({this.imgAssetPath, this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: backColor, borderRadius: BorderRadius.circular(15)),
        child: Image.asset(
          imgAssetPath,
          width: 20,
        ),
      ),
    );
  }
}
