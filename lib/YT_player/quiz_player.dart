import 'dart:async';

import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:coach_app/GlobalFunction/placeholderLines.dart';
import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:easy_localization/easy_localization.dart';

class Quiz extends StatefulWidget {
  DatabaseReference reference;
  Quiz({this.reference});
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  String timerCalled;
  Timer timer;

  @override
  void initState() {
    timerCalled = 'Not Called';
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                colors: [Colors.white, Color(0xffF36C24)])),
        child: StreamBuilder<Event>(
            stream: widget.reference.onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Content quizContent =
                    Content.fromJson(snapshot.data.snapshot.value);
                if (timerCalled == 'Not Called') {
                  timerCalled = 'Called';
                  DateTime endTime = quizContent.quizModel.startTime
                      .add(quizContent.quizModel.testTime);
                  Duration testDuration = endTime.difference(DateTime.now());
                  timer = Timer(testDuration, () {
                    _fbKey.currentState?.save();
                    widget.reference
                        .child(
                            'quizModel/result/${FireBaseAuth.instance.user.uid}')
                        .set({
                      "name": FireBaseAuth.instance.user.displayName,
                      "score": -1,
                      "response": _fbKey.currentState?.value
                    });
                    Navigator?.of(context)?.pop();
                  });
                }
                return ListView(
                  children: <Widget>[
                    Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 50,
                            child: Center(
                              child: Text(
                                quizContent.title,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Card(
                            child: Container(
                              height: 50,
                              child: Center(
                                child: Text(
                                  quizContent.quizModel.testTime.inHours
                                          .toString() +
                                      ' hr ' +
                                      (quizContent.quizModel.testTime
                                                  .inMinutes %
                                              60)
                                          .toString() +
                                      ' min',
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        height: 100,
                        child: Text(
                          quizContent.description,
                        ),
                      ),
                    ),
                    FormBuilder(
                      key: _fbKey,
                      onChanged: (value) {
                        _fbKey.currentState.save();
                      },
                      autovalidate: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        controller: ScrollController(
                            initialScrollOffset: 0, keepScrollOffset: true),
                        itemCount: quizContent.quizModel.questions.length,
                        itemBuilder: (BuildContext context, int index) => Card(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0, top: 10.0),
                            child: getRequiredFormWidget(
                              quizContent.quizModel.questions[index].type,
                              quizContent.quizModel.questions[index].question,
                              index + 1,
                              choices: quizContent
                                  .quizModel.questions[index].choices,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        color: Colors.white,
                        child: Text('Submit'.tr()),
                        onPressed: () async{
                          String res = await showDialog(
                              context: context,
                              builder: (context) => AreYouSure());
                          if (res != 'Yes') {
                            return;
                          }
                          _fbKey.currentState?.save();
                          widget.reference
                              .child(
                                  'quizModel/result/${FireBaseAuth.instance.user.uid}')
                              .set({
                            "name": FireBaseAuth.instance.user.displayName,
                            "score": -1,
                            "response": _fbKey.currentState?.value
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
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

  getRequiredFormWidget(String value, String labelText, int index,
      {List<String> choices}) {
    switch (value) {
      case 'Short Paragraph':
      case 'Long Paragraph':
      case 'Fill In the Blank':
        return FormBuilderTextField(
          attribute: labelText,
          decoration:
              InputDecoration(labelText: index.toString() + '. ' + labelText),
          validators: [],
        );
      case 'Multiple Choice':
        return FormBuilderCheckboxList(
          attribute: labelText,
          decoration:
              InputDecoration(labelText: index.toString() + '. ' + labelText),
          options: choices
              .map((e) => FormBuilderFieldOption(
                    value: e,
                  ))
              .toList(),
          validators: [],
        );
      case 'Single Choice':
        return FormBuilderRadio(
          attribute: labelText,
          decoration:
              InputDecoration(labelText: index.toString() + '. ' + labelText),
          validators: [],
          options: choices
              .map((choice) =>
                  FormBuilderFieldOption(value: choice, child: Text("$choice")))
              .toList(),
        );
      case 'True False':
        return FormBuilderSwitch(
          label: Text(index.toString() + '. ' + labelText),
          attribute: labelText,
          initialValue: false,
        );
      default:
        return Container();
    }
  }
}
