import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/YoutubeAPI/youtubeApi.dart';
import 'package:coach_app/courses/FormGeneration/form_generator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadContent extends StatefulWidget {
  @override
  _UploadContentState createState() => _UploadContentState();
}

class _UploadContentState extends State<UploadContent> {
  List<Courses> _courses = <Courses>[];
  late Courses _courseSelected;
  List<String> _subjects = <String>[];
  String? _subjectSelected, _subjectSelectedid;
  List<String> _chapters = <String>[];
  String? _chapterSelected;
  Map<String, String> _keych = {};
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  TextEditingController linkTextEditingController = TextEditingController();
  late String type, time = '', title = '';
  String? keyC;
  late DatabaseReference reference;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  QuizModel? quizModel;
  var file;
  @override
  void initState() {
    type = "Youtube Video";
    titleTextEditingController.text = '';
    descriptionTextEditingController.text = '';
    linkTextEditingController.text = '';
    keyC = null;
    super.initState();
  }

  Widget _coursesdropdownmenu(List<Courses> list) {
    return DropdownButton<Courses>(
      elevation: 8,
      items: list.map((dropDownStringitem) {
        return DropdownMenuItem<Courses>(
          value: dropDownStringitem,
          child: Text(
            dropDownStringitem.name,
          ),
        );
      }).toList(),
      onChanged: (newValueSelected) {
        if (newValueSelected == null) return;
        _subjects = <String>[];
        _chapters = <String>[];
        _subjectSelected = null;
        _chapterSelected = null;
        setState(() {
          newValueSelected.subjects?.forEach((key, value) {
            _subjects.add(value.name.toString());
          });

          _courseSelected = newValueSelected;
        });
      },
      isExpanded: true,
      hint: Text("Select Course"),
      value: _courseSelected,
    );
  }

  Widget _subjectdropdownmenu(List<String> list) {
    return DropdownButton<String>(
      elevation: 8,
      items: list.map((dropDownStringitem) {
        return DropdownMenuItem<String>(
          value: dropDownStringitem,
          child: Text(
            dropDownStringitem,
          ),
        );
      }).toList(),
      onChanged: (newValueSelected) {
        if (newValueSelected == null) return;
        _chapters = <String>[];
        _chapterSelected = null;
        _keych = {};
        setState(() {
          _courseSelected.subjects?.forEach((key, value) {
            if (value.name.toString() == newValueSelected) {
              _subjectSelectedid = key.toString();
              value.chapters?.forEach((keych, valuech) {
                _keych[valuech.name.toString()] = keych;
                _chapters.add(valuech.name.toString());
              });
            }
          });
          _subjectSelected = newValueSelected;
        });
      },
      isExpanded: true,
      hint: Text("Select Subject"),
      value: _subjectSelected ?? null,
    );
  }

  Widget _chaptersdropdownmenu(List<String> list) {
    return DropdownButton<String>(
      elevation: 8,
      items: list.map((dropDownStringitem) {
        return DropdownMenuItem<String>(
          value: dropDownStringitem,
          child: Text(
            dropDownStringitem,
          ),
        );
      }).toList(),
      onChanged: (newValueSelected) {
        if (newValueSelected == null) return;
        setState(() {
          _chapterSelected = newValueSelected;
        });
      },
      isExpanded: true,
      hint: Text("Select Chapter"),
      value: _chapterSelected ?? null,
    );
  }

  void _showsnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text("Upload Content"),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
            stream: FirebaseDatabase.instance
                .ref()
                .child(
                    'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/courses')
                .onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print("Select course");

                (snapshot.data!.snapshot.value as List).forEach((course) {
                  Courses _specificcourse = Courses.fromJson(course);
                  bool _isrepeating = false;
                  _courses.forEach((element) {
                    if (element.id == _specificcourse.id) {
                      _isrepeating = true;
                      return;
                    }
                  });
                  if (!_isrepeating || _courses.length == 0)
                    _courses.add(_specificcourse);
                });
                _courses.sort((a, b) => a.date.compareTo(b.date));

                return ListView(
                  children: [
                    _coursesdropdownmenu(_courses),
                    SizedBox(
                      height: 20.0,
                    ),
                    _subjectdropdownmenu(_subjects),
                    SizedBox(
                      height: 20.0,
                    ),
                    _chaptersdropdownmenu(_chapters),
                    SizedBox(
                      height: 10.0,
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
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
                                    Text(
                                      'Type'.tr(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    DropdownButton(
                                      value: type,
                                      elevation: 0,
                                      isExpanded: true,
                                      items: ['Youtube Video', 'Quiz', 'PDF']
                                          .map(
                                            (e) => DropdownMenuItem(
                                              child: Text(e.tr()),
                                              value: e,
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (value) {
                                        if (value == null) return;
                                        setState(() {
                                          type = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TextField(
                                      controller: titleTextEditingController,
                                      decoration: InputDecoration(
                                        hintText: 'Title'.tr(),
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
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
                                      controller:
                                          descriptionTextEditingController,
                                      decoration: InputDecoration(
                                        hintText: 'Description'.tr(),
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                        border: InputBorder.none,
                                        fillColor: Color(0xfff3f3f4),
                                        filled: true,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              if (type == 'Youtube Video' || type == 'PDF')
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      TextField(
                                        controller: linkTextEditingController,
                                        decoration: InputDecoration(
                                          hintText: type == 'Youtube Video'
                                              ? 'Youtube Video Link'.tr()
                                              : 'Google Drive Link'.tr(),
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                          border: InputBorder.none,
                                          fillColor: Color(0xfff3f3f4),
                                          filled: true,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    if (type == "Youtube Video" && keyC == null)
                                      MaterialButton(
                                        color: Colors.white,
                                        onPressed: () async {
                                          file = await FilePicker.platform
                                              .pickFiles();
                                        },
                                        elevation: 1,
                                        child: Text(
                                          "Select Video",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    (keyC == null)
                                        ? Container()
                                        : MaterialButton(
                                            onPressed: () async {
                                              String res = await showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AreYouSure());
                                              if (res != 'Yes') {
                                                return;
                                              }
                                              reference
                                                  .child('content/$keyC')
                                                  .remove();
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              'Remove'.tr(),
                                            ),
                                          ),
                                    MaterialButton(
                                      onPressed: () async {
                                        Content content = Content(
                                          kind: type,
                                          title:
                                              titleTextEditingController.text,
                                          description:
                                              descriptionTextEditingController
                                                  .text,
                                          link: '',
                                          time: '',
                                          ylink: '',
                                          quizModel: null,
                                        );

                                        if (type == 'Youtube Video') {
                                          if (linkTextEditingController.text ==
                                              '') {
                                            if (file == null) {
                                              Alert.instance.alert(context,
                                                  'Either fill link or select video');
                                              return;
                                            }
                                            content.ylink =
                                                await YoutubeUpload()
                                                    .uploadVideo(
                                                        file,
                                                        content.title,
                                                        content.description);
                                          } else {
                                            content.ylink =
                                                linkTextEditingController.text;
                                          }
                                        } else if (type == 'PDF') {
                                          content.link =
                                              linkTextEditingController.text;
                                        } else {
                                          var cal =
                                              await Navigator.of(context).push(
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  FormGenerator(
                                                title:
                                                    titleTextEditingController
                                                        .text,
                                                description:
                                                    descriptionTextEditingController
                                                        .text,
                                                quizModel: quizModel,
                                              ),
                                            ),
                                          );
                                          if (cal == null) {
                                            content.quizModel = quizModel;
                                          } else {
                                            content.quizModel = cal;
                                          }
                                        }
                                        if (time == '') {
                                          content.time = DateTime.now()
                                              .toIso8601String()
                                              .split('T')[0];
                                        } else {
                                          content.time = time;
                                        }
                                        if (keyC == null &&
                                            _subjectSelectedid != null &&
                                            _chapterSelected != null) {
                                          reference = FirebaseDatabase.instance
                                              .ref()
                                              .child(
                                                  'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/courses/${_courseSelected.id}/subjects/$_subjectSelectedid/chapters/${_keych[_chapterSelected]}');
                                          try {
                                            await reference
                                                .child('content/')
                                                .push()
                                                .update(content.toJson());

                                            _showsnackbar(
                                                context, "Content Added".tr());
                                          } catch (err) {
                                            _showsnackbar(
                                                context,
                                                "Failed. Please Try Again"
                                                    .tr());
                                          }
                                        } else {
                                          try {
                                            reference
                                                .child('content/$keyC')
                                                .update(content.toJson());
                                          } catch (err) {
                                            _showsnackbar(
                                                context,
                                                "Failed. Please Try Again"
                                                    .tr());
                                          }
                                        }
                                        setState(() {
                                          type = "Youtube Video";
                                          titleTextEditingController.text = '';
                                          descriptionTextEditingController
                                              .text = '';
                                          linkTextEditingController.text = '';
                                          keyC = null;
                                        });
                                      },
                                      color: Color(0xffF36C24),
                                      child: Text(
                                        'Add Content'.tr(),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
            }),
      ),
    );
  }
}
