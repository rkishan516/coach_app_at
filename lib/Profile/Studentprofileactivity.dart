import 'package:coach_app/Models/model.dart';
import 'package:flutter/material.dart';

class Studentprofileactivity extends StatefulWidget {
  final Student student;
  Studentprofileactivity({@required this.student});
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
                  width: MediaQuery.of(context).size.width/2,
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
                          "${widget.student.course}",
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
                                    width: _width /4,
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
            new Padding(
              padding: new EdgeInsets.only(
                  top: 5.0, left: 20.0, right: 20.0, bottom: 5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(5)),
                padding: new EdgeInsets.only(left: 5.0, right: 5.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "Course's name",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text(
                        "Course Id",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text(
                        "Payment Token",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                      width: _width,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_city,color: Colors.green,size: 100,),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${widget.student.address}",
                              style: TextStyle(
                                  color: Colors.black87.withOpacity(0.7),
                                  fontSize: 20),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width - 268,
                                child: Text(
                                  "House # 2, Road # 5, Green Road Dhanmondi, Dhaka, India",
                                  style: TextStyle(color: Colors.grey),
                                ))
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
            new FlatButton(
                onPressed: () {},
                child: new Container(
                    child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Icon(Icons.rotate_right),
                    new SizedBox(
                      width: _width / 120,
                    ),
                    new Text('Performance',
                        style: new TextStyle(
                            fontFamily: 'portLliga', color: Colors.white))
                  ],
                )),
                color: Colors.greenAccent),
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
