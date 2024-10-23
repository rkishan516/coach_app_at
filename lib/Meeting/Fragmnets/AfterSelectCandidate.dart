import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AfterSelectCandidate extends StatefulWidget {
  final String type;
  final String leftuids;
  final String searchVariable;
  final Map map;
  AfterSelectCandidate({
    required this.type,
    this.leftuids = "",
    required this.searchVariable,
    required this.map,
  });
  @override
  _SelectCandidateState createState() => _SelectCandidateState();
}

class _SelectCandidateState extends State<AfterSelectCandidate> {
  final dbref = FirebaseDatabase.instance;
  List<TwoStepSelectedCandidateModel> _list = [];
  Map<String, bool> _correspondingmap = {};
  String leftuids = "";
  int previlagelevel = AppwriteAuth.instance.previlagelevel;

  _loadFromDatabase() async {
    if (widget.type == "SubAdmins within a MidAdmin") {
      String _branches = widget.searchVariable;
      List<String> _branchlist =
          _branches.replaceAll("[", "").replaceAll("]", "").split(",");

      _branchlist.forEach((element) async {
        final snapshot = await dbref
            .ref()
            .child(
                'institute/${AppwriteAuth.instance.instituteid}/branches/${element.trim()}/admin')
            .once();
        final namesnapshot = await dbref
            .ref()
            .child(
                'institute/${AppwriteAuth.instance.instituteid}/branches/${element.trim()}/name')
            .once();
        Map emailmap = snapshot.snapshot.value as Map;
        emailmap.forEach((emailkey, emailvalue) {
          if (emailvalue["name"] != null) {
            _list.add(TwoStepSelectedCandidateModel(
                "",
                namesnapshot.snapshot.value as String,
                emailvalue["name"],
                "https://www.leafstudio.co.uk/wp-content/uploads/2019/11/person-icon-silhouette-png-0.png",
                emailkey));
            if (widget.leftuids.contains(emailkey))
              _correspondingmap[emailkey] = false;
            else
              _correspondingmap[emailkey] = true;
          }
          setState(() {
            _list = _list;
            _correspondingmap = _correspondingmap;
          });
        });
      });
    } else if (widget.type == "Authorities of a branch" &&
        previlagelevel == 4) {
      Map emailmap = widget.map[widget.searchVariable]["admin"];
      emailmap.forEach((emailkey, emailvalue) {
        if (emailvalue["name"] != null) {
          _list.add(TwoStepSelectedCandidateModel(
              "",
              widget.map[widget.searchVariable]["name"],
              emailvalue["name"],
              "https://www.leafstudio.co.uk/wp-content/uploads/2019/11/person-icon-silhouette-png-0.png",
              emailkey));
          if (widget.leftuids.contains(emailkey))
            _correspondingmap[emailkey] = false;
          else
            _correspondingmap[emailkey] = true;
        }
        setState(() {
          _list = _list;
          _correspondingmap = _correspondingmap;
        });
      });
      Map map = widget.map[widget.searchVariable]["teachers"];

      map.forEach((key, value) {
        if (key.toString().length >= 25) {
          _list.add(TwoStepSelectedCandidateModel("", value["qualification"],
              value["name"], value["photoUrl"], key));
          if (widget.leftuids.contains(key))
            _correspondingmap[key] = false;
          else
            _correspondingmap[key] = true;
        }
      });
    } else if (widget.type == "Authorities of a branch" &&
        previlagelevel == 34) {
      final subadminsnapshot = await dbref
          .ref()
          .child(
              'institute/${AppwriteAuth.instance.instituteid}/branches/${widget.searchVariable}/admin')
          .once();
      Map emailmap = subadminsnapshot.snapshot.value as Map;
      emailmap.forEach((emailkey, emailvalue) {
        if (emailvalue["name"] != null) {
          _list.add(TwoStepSelectedCandidateModel(
              "",
              "",
              emailvalue["name"],
              "https://www.leafstudio.co.uk/wp-content/uploads/2019/11/person-icon-silhouette-png-0.png",
              emailkey));
          if (widget.leftuids.contains(emailkey))
            _correspondingmap[emailkey] = false;
          else
            _correspondingmap[emailkey] = true;
        }
        setState(() {
          _list = _list;
          _correspondingmap = _correspondingmap;
        });
      });

      final teachersnapshot = await dbref
          .ref()
          .child(
              'institute/${AppwriteAuth.instance.instituteid}/branches/${widget.searchVariable}/teachers')
          .once();
      Map map = teachersnapshot.snapshot.value as Map;

      map.forEach((key, value) {
        if (key.toString().length >= 25) {
          _list.add(TwoStepSelectedCandidateModel("", value["qualification"],
              value["name"], value["photoUrl"], key));

          if (widget.leftuids.contains(key))
            _correspondingmap[key] = false;
          else
            _correspondingmap[key] = true;
        }
      });
    } else if (widget.type == "Teachers of a course") {
      final snapshot = await dbref
          .ref()
          .child(
              'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/teachers')
          .once();
      Map map = snapshot.snapshot.value as Map;
      map.forEach((key, value) {
        if (key.toString().length >= 25) {
          List coursemap = value["courses"];
          coursemap.forEach((coursevalue) {
            if (coursevalue["id"] == widget.searchVariable) {
              _list.add(TwoStepSelectedCandidateModel(
                  "",
                  value["qualification"],
                  value["name"],
                  value["photoUrl"],
                  key));
              if (widget.leftuids.contains(key))
                _correspondingmap[key] = false;
              else
                _correspondingmap[key] = true;
            }
          });
        }
        setState(() {
          _list = _list;
          _correspondingmap = _correspondingmap;
        });
      });
    } else if (widget.type == "Teachers of a subject") {
      final snapshot = await dbref
          .ref()
          .child(
              'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/courses/${widget.searchVariable}/subjects')
          .once();
      Map map = snapshot.snapshot.value as Map;
      map.forEach((key, value) {
        Map coursemap = value["mentor"];
        coursemap.forEach((mentor, mentorvalue) async {
          final teachersnapshot = await dbref
              .ref()
              .child(
                  'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/teachers')
              .orderByChild('email')
              .equalTo(mentorvalue.toString().trim())
              .once();
          Map teachermap = teachersnapshot.snapshot.value as Map;
          teachermap.forEach((teacherkey, teachervalue) {
            if (teacherkey.toString().length >= 25) {
              _list.add(TwoStepSelectedCandidateModel("", teachervalue["name"],
                  value["name"], teachervalue["photoUrl"], teacherkey));
              if (widget.leftuids.contains(key))
                _correspondingmap[key] = false;
              else
                _correspondingmap[key] = true;
            }
          });
          setState(() {
            _list = _list;
            _correspondingmap = _correspondingmap;
          });
        });
      });
    }

    setState(() {
      _list = _list;
      _correspondingmap = _correspondingmap;
    });
  }

  @override
  void initState() {
    _loadFromDatabase();
    leftuids = widget.leftuids;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type),
        actions: [
          MaterialButton(
              child: Text("Done"),
              onPressed: () {
                Navigator.of(context).pop(leftuids);
              })
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            itemCount: _list.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Image.network(_list[index].photourl),
                ),
                trailing: Checkbox(
                  value: _correspondingmap[_list[index].uid] ?? true,
                  onChanged: (bool? value) {
                    if (value == null) return;
                    setState(() {
                      _correspondingmap[_list[index].uid] = value;
                      if (value) {
                        leftuids =
                            leftuids.split(_list[index].uid + ":_:_:").join();
                      } else
                        leftuids = leftuids + _list[index].uid + ":_:_:";
                    });
                  },
                ),
                title: Text(_list[index].name),
                subtitle: Text(_list[index].branchname),
              );
            }),
      ),
    );
  }
}

class TwoStepSelectedCandidateModel {
  String branchname;
  String branchaddress;
  String name;
  String photourl;
  String uid;
  TwoStepSelectedCandidateModel(
      this.branchaddress, this.branchname, this.name, this.photourl, this.uid);
}
