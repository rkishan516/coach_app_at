import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'AfterSelectCandidate.dart';

class TwoStepSelectCandidate extends StatefulWidget {
  final String type;
  final String leftuids;
  final String firstselecteduids;
  TwoStepSelectCandidate({this.type, this.leftuids, this.firstselecteduids});
  @override
  _SelectCandidateState createState() => _SelectCandidateState();
}

class _SelectCandidateState extends State<TwoStepSelectCandidate> {
  final dbref = FirebaseDatabase.instance;
  List<TwoStepSelectedCandidateModel> _list = [];
  Map<String, bool> _correspondingmap = {};
  String _leftuids = "";
  String _firstselecteduids = "";
  ObjectPass _objectPass = ObjectPass("", "");
  Map mapofbranches;
  int previlagelevel = FireBaseAuth.instance.previlagelevel;

  _loadFromDatabase() async {
    if (widget.type == "SubAdmins within a MidAdmin") {
      DataSnapshot snapshot = await dbref
          .reference()
          .child('institute/${FireBaseAuth.instance.instituteid}/midAdmin')
          .once();
      Map map = snapshot.value;
      map.forEach((key, value) {
        if (key.toString().length >= 25) {
          _list.add(TwoStepSelectedCandidateModel(value["branches"],
              value["district"], value["name"], value["photoUrl"], key));
          if (widget.firstselecteduids.contains(key))
            _correspondingmap[key] = true;
          else
            _correspondingmap[key] = false;
        }
      });
    } else if (widget.type == "Authorities of a branch" &&
        previlagelevel == 4) {
      DataSnapshot snapshot = await dbref
          .reference()
          .child('institute/${FireBaseAuth.instance.instituteid}/branches')
          .once();
      mapofbranches = snapshot.value;
      mapofbranches.forEach((key, value) {
        _list.add(TwoStepSelectedCandidateModel(
            key,
            value["address"],
            value["name"],
            "https://www.leafstudio.co.uk/wp-content/uploads/2019/11/person-icon-silhouette-png-0.png",
            key));
        if (widget.firstselecteduids.contains(key))
          _correspondingmap[key] = true;
        else
          _correspondingmap[key] = false;
      });
    } else if (widget.type == "Authorities of a branch" &&
        previlagelevel == 34) {
      //String _branches="[1515, 1901, 1902, 1404, 1301, 1215, 1101, 1704, 1812, 2014, 2101, 2201, 2301]";
      String _branches = FireBaseAuth.instance.branchList.toString();
      List<String> _branchlist =
          _branches.replaceAll("[", "").replaceAll("]", "").split(",");
      print(_branchlist);
      _branchlist.forEach((element) async {
        DataSnapshot addresssnapshot = await dbref
            .reference()
            .child(
                'institute/${FireBaseAuth.instance.instituteid}/branches/${element.trim()}/address')
            .once();
        DataSnapshot namesnapshot = await dbref
            .reference()
            .child(
                'institute/${FireBaseAuth.instance.instituteid}/branches/${element.trim()}/name')
            .once();

        _list.add(TwoStepSelectedCandidateModel(
            element.trim(),
            addresssnapshot.value,
            namesnapshot.value,
            "https://www.leafstudio.co.uk/wp-content/uploads/2019/11/person-icon-silhouette-png-0.png",
            element.trim()));
        if (widget.firstselecteduids.contains(element))
          _correspondingmap[element] = true;
        else
          _correspondingmap[element] = false;

        setState(() {
          _list = _list;
          _correspondingmap = _correspondingmap;
        });
      });
    } else if (widget.type == "Teachers of a course") {
      DataSnapshot snapshot = await dbref
          .reference()
          .child(
              'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/coursesList')
          .once();
      Map map = snapshot.value;
      map?.forEach((key, value) {
        _list.add(TwoStepSelectedCandidateModel(
            key,
            "",
            value,
            "https://banner2.cleanpng.com/20180505/cre/kisspng-book-cover-outline-clip-art-5aed58b656e528.2169014815255041823559.jpg",
            key));
        if (widget.firstselecteduids.contains(key))
          _correspondingmap[key] = true;
        else
          _correspondingmap[key] = false;
      });
    } else if (widget.type == "Teachers of a subject") {
      DataSnapshot snapshot = await dbref
          .reference()
          .child(
              'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/coursesList')
          .once();
      Map map = snapshot.value;
      map?.forEach((key, value) {
        _list.add(TwoStepSelectedCandidateModel(
            key,
            "",
            value,
            "https://banner2.cleanpng.com/20180505/cre/kisspng-book-cover-outline-clip-art-5aed58b656e528.2169014815255041823559.jpg",
            key));
        if (widget.firstselecteduids.contains(key))
          _correspondingmap[key] = true;
        else
          _correspondingmap[key] = false;
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
    _leftuids = widget.leftuids;
    _firstselecteduids = widget.firstselecteduids;
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
                _objectPass.firstSelecteduids = _firstselecteduids;
                Navigator.of(context).pop(_objectPass);
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
                onLongPress: () {
                  if (_correspondingmap[_list[index].uid])
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => AfterSelectCandidate(
                                  leftuids: _leftuids,
                                  type: widget.type,
                                  searchVariable: _list[index].branchaddress,
                                  map: mapofbranches,
                                )))
                        .then((value) {
                      _objectPass.leftuids = value;
                    });
                },
                leading: CircleAvatar(
                  child: Image.network(_list[index].photourl),
                ),
                trailing: Checkbox(
                    value: _correspondingmap[_list[index].uid] ?? false,
                    onChanged: (bool value) {
                      setState(() {
                        _correspondingmap.forEach((key, value) {
                          if (value == true) {
                            _correspondingmap[key] = false;
                          }
                        });
                        _correspondingmap[_list[index].uid] = value;
                        if (value) {
                          _firstselecteduids = _list[index].uid + ":_:_:";
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => AfterSelectCandidate(
                                        leftuids: _leftuids,
                                        type: widget.type,
                                        searchVariable:
                                            _list[index].branchaddress,
                                        map: mapofbranches,
                                      )))
                              .then((value) {
                            _objectPass.leftuids = value;
                          });
                        } else
                          _firstselecteduids = _firstselecteduids
                              .split(_list[index].uid + ":_:_:")
                              .join();
                      });
                    }),
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

class ObjectPass {
  String firstSelecteduids;
  String leftuids;
  ObjectPass(this.firstSelecteduids, this.leftuids);
}
