import 'package:coach_app/Models/model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';

class Quiz extends StatefulWidget {
  DatabaseReference reference;
  Quiz({this.reference});
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Event>(
          stream: widget.reference.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Content quizContent =
                  Content.fromJson(snapshot.data.snapshot.value);
              return Column(
                children: <Widget>[
                  Card(
                    child: Container(
                      child: Center(
                        child: Text(
                          quizContent.title,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      child: Center(
                        child: Text(
                          quizContent.description,
                        ),
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
                      itemCount: quizContent.quizModel.questions.length,
                      itemBuilder: (BuildContext context, int index) =>
                          getRequiredFormWidget(
                        quizContent.quizModel.questions[index].type,
                        quizContent.quizModel.questions[index].question,
                        choices: quizContent.quizModel.questions[index].choices,
                      ),
                    ),
                  ),
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
    );
  }

  getRequiredFormWidget(String value, String labelText,
      {List<String> choices}) {
    switch (value) {
      case 'Short Paragraph':
      case 'Long Paragraph':
      case 'Fill In the Blank':
        return FormBuilderTextField(
          attribute: "text" + labelText,
          decoration: InputDecoration(labelText: labelText),
          validators: [
            FormBuilderValidators.max(70),
          ],
        );
      case 'Multiple Choice':
        return FormBuilderCheckboxList(
          attribute: 'Multiple Choice' + labelText,
          decoration: InputDecoration(labelText: labelText),
          options: choices
              .map((e) => FormBuilderFieldOption(
                    value: e,
                  ))
              .toList(),
          validators: [],
        );
      case 'Single Choice':
        return FormBuilderRadio(
          attribute: "Single Choice" + labelText,
          decoration: InputDecoration(labelText: labelText),
          validators: [FormBuilderValidators.required()],
          options: choices
              .map((choice) =>
                  FormBuilderFieldOption(value: choice, child: Text("$choice")))
              .toList(),
        );
      case 'True False':
        return FormBuilderSwitch(
          label: Text(labelText),
          attribute: "True False" + labelText,
          initialValue: false,
        );
      default:
        return Container();
    }
  }
}
