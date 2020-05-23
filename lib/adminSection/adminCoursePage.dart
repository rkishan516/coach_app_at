import 'package:coach_app/Models/model.dart';
import 'package:coach_app/adminSection/adminSubjectPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coach_app/courses/subject_page.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminCoursePage extends StatefulWidget {
  @override
  _AdminCoursePageState createState() => _AdminCoursePageState();
}

class _AdminCoursePageState extends State<AdminCoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff519ddb), Color(0xff54d179)])),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Your Courses',
                    style: GoogleFonts.portLligatSans(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 12,
              child: StreamBuilder<Event>(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child('institute/0/courses')
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Courses> courses = List<Courses>();
                    snapshot.data.snapshot.value.values?.forEach((course) {
                      courses.add(Courses.fromJson(course));
                    });
                    return ListView.builder(
                      itemCount: courses?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            title: Text(
                              '${courses[index].name}',
                              style: TextStyle(color: Colors.blue),
                            ),
                            trailing: Icon(
                              Icons.chevron_right,
                              color: Colors.blue,
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
                              batch: courses[index].batch.join(','),
                              subjects: courses[index].subjects,
                              id: courses[index].id,
                            ),
                          ),
                        );
                      },
                    );
                  }else if(snapshot.hasError){
                    return Center(child: Text('${snapshot.error}'),);
                  } 
                  else {
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
      floatingActionButton: FloatingActionButton(
        child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff519ddb), Color(0xff54d179)])),
            child: Icon(Icons.add)),
        onPressed: () => addCourse(context),
      ),
    );
  }
}

addCourse(BuildContext context,
    {String name = '',
    String description = '',
    String medium = '',
    String price = '',
    String batch = '',
    String id = '',
    List<Subjects> subjects}) {
  TextEditingController nameTextEditingController = TextEditingController()
    ..text = name;
  TextEditingController descriptionTextEditingController =
      TextEditingController()..text = description;
  TextEditingController mediumTextEditingController = TextEditingController()
    ..text = medium;
  TextEditingController priceTextEditingController = TextEditingController()
    ..text = price;
  TextEditingController batchTextEditingController = TextEditingController()
    ..text = batch;
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
                    Text(
                      'Course Name',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: nameTextEditingController,
                      decoration: InputDecoration(
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
                    Text(
                      'Course Description',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: descriptionTextEditingController,
                      decoration: InputDecoration(
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
                    Text(
                      'Medium',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: mediumTextEditingController,
                      decoration: InputDecoration(
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
                    Text(
                      'Fee',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: priceTextEditingController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
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
                    Text(
                      'Batches',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: batchTextEditingController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Seprated With comma',
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    (id == '')
                        ? Container()
                        : FlatButton(
                            onPressed: () {
                              FirebaseDatabase.instance
                                  .reference()
                                  .child('institute/0/courses/$id')
                                  .remove();

                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Remove',
                            ),
                          ),
                    FlatButton(
                      onPressed: () {
                        if (nameTextEditingController.text != '' &&
                            descriptionTextEditingController.text != '') {
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
                            batch: batchTextEditingController.text
                                .split(',')
                                .map((e) => e.capitalize().trim())
                                .toList(),
                            subjects: subjects,
                            id: (id == '')
                                ? nameTextEditingController.text.hashCode
                                    .toString()
                                : id,
                          );
                          FirebaseDatabase.instance
                              .reference()
                              .child('institute/0/courses/${course.id}')
                              .set(course.toJson());
                        }
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Add Course',
                      ),
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
