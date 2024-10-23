import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SelectCandidate extends StatefulWidget {
  final String type;
  final String leftuids;
  SelectCandidate({
    required this.type,
    required this.leftuids,
  });
  @override
  _SelectCandidateState createState() => _SelectCandidateState();
}

class _SelectCandidateState extends State<SelectCandidate> {
  final dbref = FirebaseDatabase.instance;
  List<SelectedCandidateModel> _list = [];
  Map<String, bool> _correspondingmap = {};
  int previlagelevel = AppwriteAuth.instance.previlagelevel;
  String leftuids = "";

  _loadFromDatabase() async {
    if (widget.type == "SubAdmins" && previlagelevel != 34) {
      final snapshot = await dbref
          .ref()
          .child('institute/${AppwriteAuth.instance.instituteid}/branches')
          .once();
      Map map = snapshot.snapshot.value as Map;
      map.forEach((key, value) {
        Map emailmap = value["admin"];
        emailmap.forEach((emailkey, emailvalue) {
          if (emailvalue["name"] != null) {
            _list.add(SelectedCandidateModel(
                value["address"],
                value["name"],
                emailvalue["name"],
                "https://www.leafstudio.co.uk/wp-content/uploads/2019/11/person-icon-silhouette-png-0.png",
                emailkey));
            if (widget.leftuids.contains(emailkey))
              _correspondingmap[emailkey] = false;
            else
              _correspondingmap[emailkey] = true;
          }
        });
      });
    } else if (widget.type == "MidAdmins") {
      final snapshot = await dbref
          .ref()
          .child('institute/${AppwriteAuth.instance.instituteid}/midAdmin')
          .once();
      Map map = snapshot.snapshot.value as Map;
      map.forEach((key, value) {
        if (key.toString().length >= 25) {
          _list.add(SelectedCandidateModel(
              "", value["district"], value["name"], value["photoUrl"], key));
          if (widget.leftuids.contains(key))
            _correspondingmap[key] = false;
          else
            _correspondingmap[key] = true;
        }
      });
    } else if (widget.type == "Teachers") {
      final snapshot = await dbref
          .ref()
          .child(
              'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/teachers')
          .once();
      Map map = snapshot.snapshot.value as Map;
      map.forEach((key, value) {
        if (key.toString().length >= 25) {
          _list.add(SelectedCandidateModel("", value["qualification"],
              value["name"], value["photoUrl"], key));
          if (widget.leftuids.contains(key))
            _correspondingmap[key] = false;
          else
            _correspondingmap[key] = true;
        }
      });
    } else if (widget.type == "All students") {
      final snapshot = await dbref
          .ref()
          .child(
              'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/students')
          .once();
      Map map = snapshot.snapshot.value as Map;
      map.forEach((key, value) {
        if (key.toString().length >= 25) {
          _list.add(SelectedCandidateModel(
              "", value["phone No"], value["name"], value["photoURL"], key));
          if (widget.leftuids.contains(key))
            _correspondingmap[key] = false;
          else
            _correspondingmap[key] = true;
        }
      });
    } else if (widget.type == "Other MidAdmins") {
      final snapshot = await dbref
          .ref()
          .child('institute/${AppwriteAuth.instance.instituteid}/midAdmin')
          .once();
      Map map = snapshot.snapshot.value as Map;
      map.forEach((key, value) {
        if (key.toString().length >= 25 &&
            key.toString() != AppwriteAuth.instance.user!.$id) {
          _list.add(SelectedCandidateModel(
              "", value["district"], value["name"], value["photoUrl"], key));
          if (widget.leftuids.contains(key))
            _correspondingmap[key] = false;
          else
            _correspondingmap[key] = true;
        }
      });
    } else if (widget.type == "SubAdmins" && previlagelevel == 34) {
      //String _branches="[1515, 1901, 1902, 1404, 1301, 1215, 1101, 1704, 1812, 2014, 2101, 2201, 2301]";
      String _branches = AppwriteAuth.instance.branchList.toString();
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
            _list.add(SelectedCandidateModel(
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
        title: Text("Select Candidate"),
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
                    }),
                title: Text(_list[index].name),
                subtitle: Text(_list[index].branchname +
                    "\n" +
                    _list[index].branchaddress),
              );
            }),
      ),
    );
  }
}

class SelectedCandidateModel {
  String branchname;
  String branchaddress;
  String name;
  String photourl;
  String uid;
  SelectedCandidateModel(
      this.branchaddress, this.branchname, this.name, this.photourl, this.uid);
}
