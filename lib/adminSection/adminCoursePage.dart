import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/GlobalFunction/SlideButton.dart';
import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/adminSection/adminSubjectPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_app/courses/subject_page.dart';
import 'package:easy_localization/easy_localization.dart';

class AdminCoursePage extends StatefulWidget {
  @override
  _AdminCoursePageState createState() => _AdminCoursePageState();
}

class _AdminCoursePageState extends State<AdminCoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  stream: FirebaseDatabase.instance
                      .reference()
                      .child(
                          'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses')
                      .onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Courses> courses = List<Courses>();
                      snapshot.data.snapshot.value?.values?.forEach((course) {
                        courses.add(Courses.fromJson(course));
                      });
                      return ListView.builder(
                        itemCount: courses?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                title: Text(
                                  '${courses[index].name}',
                                  style: TextStyle(color: Color(0xffF36C24)),
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: Color(0xffF36C24),
                                ),
                                onTap: () => Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => AdminSubjectPage(
                                        courseId: courses[index].id),
                                  ),
                                ),
                                onLongPress: () => addCourse(
                                  context,
                                  name: courses[index].name,
                                  description: courses[index].description,
                                  price: courses[index].price.toString(),
                                  medium: courses[index].medium,
                                  subjects: courses[index].subjects,
                                  id: courses[index].id,
                                ),
                              ),
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
        floatingActionButton: SlideButtonR(
          height: 50,
          width: 150,
          onTap: () => addCourse(context),
          text: 'Create Course'.tr(),
        ));
  }
}

addCourse(BuildContext context,
    {String name = '',
    String description = '',
    String medium = '',
    String price = '',
    String id = '',
    Map<String, Subjects> subjects}) {
  TextEditingController nameTextEditingController = TextEditingController()
    ..text = name;
  TextEditingController descriptionTextEditingController =
      TextEditingController()..text = description;
  TextEditingController mediumTextEditingController = TextEditingController()
    ..text = medium;
  TextEditingController priceTextEditingController = TextEditingController()
    ..text = price;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
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
                    TextField(
                      controller: nameTextEditingController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        hintText: 'Course Name'.tr(),
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
                      controller: descriptionTextEditingController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        hintText: 'Course Description'.tr(),
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
                      controller: mediumTextEditingController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        hintText: 'Medium'.tr(),
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
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 9,
                          child: TextField(
                            controller: priceTextEditingController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              hintText: 'Fee'.tr(),
                              border: InputBorder.none,
                              fillColor: Color(0xfff3f3f4),
                              filled: true,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            '₹',
                            style: TextStyle(fontSize: 25),
                          ),
                        )),
                      ],
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    (id == '')
                        ? Container()
                        : FlatButton(
                            onPressed: () async {
                              String res = await showDialog(
                                  context: context,
                                  builder: (context) => AreYouSure());
                              if (res != 'Yes') {
                                return;
                              }
                              FirebaseDatabase.instance
                                  .reference()
                                  .child(
                                      'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/$id')
                                  .remove();
                              FirebaseDatabase.instance
                                  .reference()
                                  .child(
                                      'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/coursesList/$id')
                                  .remove();
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Remove'.tr(),
                            ),
                          ),
                    FlatButton(
                      onPressed: () {
                        if (nameTextEditingController.text == '') {
                          Alert.instance.alert(
                              context,
                              'Please Enter the course '
                                  .tr(args: ['Name'.tr()]));
                          return;
                        }
                        if (descriptionTextEditingController.text == '') {
                          Alert.instance.alert(
                              context,
                              'Please Enter the course '
                                  .tr(args: ['Description'.tr()]));
                          return;
                        }
                        if (mediumTextEditingController.text == '') {
                          Alert.instance.alert(
                              context,
                              'Please Enter the course '
                                  .tr(args: ['Medium'.tr()]));
                          return;
                        }
                        if (priceTextEditingController.text == '') {
                          Alert.instance.alert(
                              context,
                              'Please Enter the course '
                                  .tr(args: ['Fee'.tr()]));
                          return;
                        }
                        Courses course = Courses(
                          name: nameTextEditingController.text
                              .capitalize()
                              .trim(),
                          description: descriptionTextEditingController.text
                              .capitalize()
                              .trim(),
                          date: DateTime.now().toIso8601String(),
                          medium: mediumTextEditingController.text
                              .capitalize()
                              .trim(),
                          price: double.parse(priceTextEditingController.text)
                              .toInt(),
                          subjects: subjects,
                          id: (id == '')
                              ? nameTextEditingController.text.hashCode
                                  .toString()
                              : id,
                        );
                        FirebaseDatabase.instance
                            .reference()
                            .child(
                                'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/courses/${course.id}')
                            .update(course.toJson());
                        FirebaseDatabase.instance
                            .reference()
                            .child(
                                'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/coursesList/')
                            .update({course.id: course.name});

                        Navigator.of(context).pop();
                      },
                      child: Text('Add Course'.tr()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

//TODO Quiz start at or expired
