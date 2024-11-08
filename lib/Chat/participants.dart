import 'package:coach_app/Chat/group_description.dart';
import 'package:coach_app/Chat/independent.dart';
import 'package:coach_app/Chat/mid_admin_based.dart';
import 'package:coach_app/Chat/models/item_class.dart';
import 'package:coach_app/Profile/TeacherProfile.dart';
import 'package:flutter/material.dart';

class participants extends StatefulWidget {
  final CurrUser currentUser;
  participants({required this.currentUser});
  _participantState createState() => new _participantState(currentUser);
}

class _participantState extends State<participants>
    with TickerProviderStateMixin {
  final CurrUser currentUser;
  _participantState(this.currentUser);

  bool monVal = false;
  bool tonVal = false;
  bool wonVal = false;
  bool thonVal = false;
  bool fonVal = false;
  bool sonVal = false;
  int count = 0;
  choose ch = choose(false, false, false, false, false, false);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: new AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: new Text("Chat Section"),
          backgroundColor: Color.fromARGB(255, 242, 108, 37),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(SizeConfig.b * 2.54, SizeConfig.v * 2.71,
              SizeConfig.b * 2.54, SizeConfig.b * .36),
          color: Color.fromARGB(255, 230, 230, 230),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select Participants for Group",
                  style: TextStyle(fontSize: SizeConfig.b * 4.5)),
              SizedBox(height: SizeConfig.v * 2.71),
              (currentUser.role == 'Admin' || currentUser.role == 'Mid Admin')
                  ? InkWell(
                      onTap: () {
                        choose ch1 =
                            choose(true, false, false, false, false, false);
                        Navigator.of(context)
                            .push(new MaterialPageRoute(builder: (context) {
                          return new GroupDes(
                              currentUser: currentUser,
                              catg: "Mid Admin",
                              ch: ch1);
                        }));
                      },
                      child: Container(
                          height: SizeConfig.v * 8.13,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(SizeConfig.b * 7.63),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Checkbox(
                                    value: monVal,
                                    activeColor:
                                        Color.fromARGB(255, 230, 230, 230),
                                    checkColor:
                                        Color.fromARGB(255, 242, 108, 37),
                                    onChanged: (bool? value) {
                                      if (value == null) return;
                                      setState(() {
                                        monVal = value;
                                        ch.mid = value;
                                        if (value)
                                          count = count + 1;
                                        else
                                          count = count - 1;
                                      });
                                    },
                                  ),
                                  Text("Mid-Admins",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 242, 108, 37),
                                          fontSize: SizeConfig.b * 4.58)),
                                ],
                              ),
                              SizedBox(width: SizeConfig.b * 45.8),
                              Icon(Icons.arrow_forward_ios,
                                  color: Color.fromARGB(255, 242, 108, 37))
                            ],
                          )),
                    )
                  : SizedBox(),
              (currentUser.role == 'Admin' || currentUser.role == 'Mid Admin')
                  ? SizedBox(height: SizeConfig.v * 3.79)
                  : SizedBox(),
              (currentUser.role == 'Admin' ||
                      currentUser.role == 'Mid Admin' ||
                      currentUser.role == 'Sub Admin')
                  ? InkWell(
                      onTap: () {
                        choose ch1 =
                            choose(false, true, false, false, false, false);
                        Navigator.of(context)
                            .push(new MaterialPageRoute(builder: (context) {
                          return new GroupDes(
                              currentUser: currentUser,
                              catg: "Sub Admin",
                              ch: ch1);
                        }));
                      },
                      child: Container(
                          height: SizeConfig.v * 8.13,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(SizeConfig.b * 7.63),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Checkbox(
                                    value: tonVal,
                                    activeColor:
                                        Color.fromARGB(255, 230, 230, 230),
                                    checkColor:
                                        Color.fromARGB(255, 242, 108, 37),
                                    onChanged: (bool? value) {
                                      if (value == null) return;
                                      setState(() {
                                        tonVal = value;
                                        ch.subBased = !ch.subBased;
                                        if (value)
                                          count = count + 1;
                                        else
                                          count = count - 1;
                                      });
                                    },
                                  ),
                                  Text("Sub Admins",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 242, 108, 37),
                                          fontSize: SizeConfig.b * 4.58)),
                                ],
                              ),
                              SizedBox(width: SizeConfig.b * 46.9),
                              Icon(Icons.arrow_forward_ios,
                                  color: Color.fromARGB(255, 242, 108, 37))
                            ],
                          )),
                    )
                  : SizedBox(),
              (currentUser.role == 'Admin' ||
                      currentUser.role == 'Mid Admin' ||
                      currentUser.role == 'Sub Admin')
                  ? SizedBox(height: SizeConfig.v * 3.79)
                  : SizedBox(),
              (currentUser.role == 'Admin')
                  ? InkWell(
                      onTap: () {
                        print("Mid-ADmin Based");
                        Navigator.of(context)
                            .push(new MaterialPageRoute(builder: (context) {
                          return new MidAdminBased(
                            currentUser: currentUser,
                          );
                        }));
                      },
                      child: Container(
                          height: SizeConfig.v * 8.13,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius:
                                BorderRadius.circular(SizeConfig.b * 7.63),
                          ),
                          child: Row(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Checkbox(
                                    value: fonVal,
                                    activeColor:
                                        Color.fromARGB(255, 230, 230, 230),
                                    checkColor:
                                        Color.fromARGB(255, 242, 108, 37),
                                    onChanged: (bool? value) {
                                      if (value == null) return;
                                      setState(() {
                                        fonVal = value;
                                        ch.midBased = !ch.midBased;
                                        if (value)
                                          count = count + 1;
                                        else
                                          count = count - 1;
                                      });
                                    },
                                  ),
                                  Text("Mid-Admin Based",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 242, 108, 37),
                                          fontSize: SizeConfig.b * 4.58)),
                                ],
                              ),
                              SizedBox(width: SizeConfig.b * 33.62),
                              Icon(Icons.arrow_forward_ios,
                                  color: Color.fromARGB(255, 242, 108, 37))
                            ],
                          )),
                    )
                  : SizedBox(),
              (currentUser.role == 'Admin')
                  ? SizedBox(height: SizeConfig.v * 3.79)
                  : SizedBox(),
              (currentUser.role == 'Admin' || currentUser.role == 'Mid Admin')
                  ? InkWell(
                      onTap: () {
                        print("Pressed");
                      },
                      child: Container(
                          height: SizeConfig.v * 8.13,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius:
                                BorderRadius.circular(SizeConfig.b * 7.63),
                          ),
                          child: Row(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Checkbox(
                                    value: thonVal,
                                    activeColor:
                                        Color.fromARGB(255, 230, 230, 230),
                                    checkColor:
                                        Color.fromARGB(255, 242, 108, 37),
                                    onChanged: (bool? value) {
                                      if (value == null) return;
                                      setState(() {
                                        thonVal = value;
                                        ch.branch = !ch.branch;
                                        if (value)
                                          count = count + 1;
                                        else
                                          count = count - 1;
                                      });
                                    },
                                  ),
                                  Text("Branch Based",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 242, 108, 37),
                                          fontSize: SizeConfig.b * 4.58)),
                                ],
                              ),
                              SizedBox(width: SizeConfig.b * 41),
                              Icon(Icons.arrow_forward_ios,
                                  color: Color.fromARGB(255, 255, 107, 37))
                            ],
                          )),
                    )
                  : SizedBox(),
              (currentUser.role == 'Admin' || currentUser.role == 'Mid Admin')
                  ? SizedBox(height: SizeConfig.v * 3.79)
                  : SizedBox(),
              (currentUser.role == 'Admin' ||
                      currentUser.role == 'Mid Admin' ||
                      currentUser.role == 'Sub Admin' ||
                      currentUser.role == 'Teacher')
                  ? InkWell(
                      onTap: () {
                        choose ch1 =
                            choose(false, false, false, false, true, false);
                        Navigator.of(context)
                            .push(new MaterialPageRoute(builder: (context) {
                          return new GroupDes(
                              currentUser: currentUser,
                              catg: "Teacher",
                              ch: ch1);
                        }));
                      },
                      child: Container(
                          height: SizeConfig.v * 8.13,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius:
                                BorderRadius.circular(SizeConfig.b * 7.63),
                          ),
                          child: Row(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Checkbox(
                                    value: thonVal,
                                    activeColor:
                                        Color.fromARGB(255, 230, 230, 230),
                                    checkColor:
                                        Color.fromARGB(255, 242, 108, 37),
                                    onChanged: (bool? value) {
                                      if (value == null) return;
                                      setState(() {
                                        thonVal = value;
                                        ch.branch = !ch.branch;
                                        if (value)
                                          count = count + 1;
                                        else
                                          count = count - 1;
                                      });
                                    },
                                  ),
                                  Text("Teachers",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 242, 108, 37),
                                          fontSize: SizeConfig.b * 4.58)),
                                ],
                              ),
                              SizedBox(width: SizeConfig.b * 50),
                              Icon(Icons.arrow_forward_ios,
                                  color: Color.fromARGB(255, 255, 107, 37))
                            ],
                          )),
                    )
                  : SizedBox(),
              (currentUser.role == 'Admin' ||
                      currentUser.role == 'Mid Admin' ||
                      currentUser.role == 'Sub Admin' ||
                      currentUser.role == 'Teacher')
                  ? SizedBox(height: SizeConfig.v * 3.79)
                  : SizedBox(),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(new MaterialPageRoute(builder: (context) {
                    return new independent(currentUser: currentUser);
                  }));
                },
                child: Container(
                  height: SizeConfig.v * 8.13,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(SizeConfig.b * 7.63),
                  ),
                  child: Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                            value: sonVal,
                            activeColor: Color.fromARGB(255, 230, 230, 230),
                            checkColor: Color.fromARGB(255, 242, 108, 37),
                            onChanged: (bool? value) {
                              if (value == null) return;
                              setState(() {
                                sonVal = value;
                                ch.ind = !ch.ind;
                                if (value)
                                  count = count + 1;
                                else
                                  count = count - 1;
                              });
                            },
                          ),
                          Text("Independent",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 242, 108, 37),
                                  fontSize: SizeConfig.b * 4.58)),
                        ],
                      ),
                      SizedBox(width: SizeConfig.b * 43),
                      Icon(Icons.arrow_forward_ios,
                          color: Color.fromARGB(255, 255, 107, 37))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            elevation: 0.0,
            child: new Icon(Icons.check, size: 30),
            backgroundColor: Color.fromARGB(255, 255, 107, 37),
            onPressed: () {
              String catg;
              if (count > 0) {
                catg = "Mid Admin";

                Navigator.of(context)
                    .push(new MaterialPageRoute(builder: (context) {
                  return new GroupDes(
                    catg: catg,
                    ch: ch,
                    currentUser: currentUser,
                  );
                }));
              }
            }));
  }
}

class choose {
  bool mid, subBased, midBased, branch, ind, teacher;

  choose(this.mid, this.subBased, this.midBased, this.branch, this.teacher,
      this.ind);
}
