import 'package:coach_app/Models/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormGenerator extends StatefulWidget {
  String title;
  String description;
  FormGenerator({@required this.title, @required this.description});
  @override
  _FormGeneratorState createState() => _FormGeneratorState();
}

class _FormGeneratorState extends State<FormGenerator> {
  String dropDownValue = 'Short Paragraph';
  String label = 'Short Paragraph';
  bool haveChoices = false;
  List<TextEditingController> choices = List<TextEditingController>();
  TextEditingController _textEditingController = TextEditingController();
  bool isError = false;
  List<Widget> formFields = List<Widget>();
  List<QuestionModel> formFieldsModals = List<QuestionModel>();
  Duration testTime = Duration();

  @override
  void initState() {
    for (int i = 0; i < 4; i++) {
      choices.add(TextEditingController());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Build New Quiz',
        ),
        elevation: 5.0,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: Container(
              padding: EdgeInsets.all(30.0),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
            ),
          ),
          CupertinoTimerPicker(
            onTimerDurationChanged: (duration) => testTime = duration,
            mode: CupertinoTimerPickerMode.hms,
          ),
          FormBuilder(
            autovalidate: true,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: formFields.length,
              itemBuilder: (BuildContext context, int index) =>
                  formFields[index],
            ),
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  DropdownButton(
                    value: dropDownValue,
                    items: <String>[
                      'Short Paragraph',
                      'Long Paragraph',
                      'Single Choice',
                      'Multiple Choice',
                      'True False',
                      'Fill In the Blank'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (e) => setState(
                      () {
                        dropDownValue = e;
                        label = e + ' label';
                        if (e == 'Single Choice' || e == 'Multiple Choice') {
                          haveChoices = true;
                        } else {
                          haveChoices = false;
                        }
                      },
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 200,
                      child: TextField(
                        decoration: InputDecoration(hintText: 'Label Text'),
                        controller: _textEditingController,
                        onChanged: (val) {
                          label = val;
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      formFieldsModals.forEach((element) {
                        if (element.question == label) {
                          label += formFields.length.toString();
                        }
                      });

                      var choice = choices.map((e) => e?.text).toSet().toList();
                      choice.remove('');
                      setState(
                        () {
                          formFields.add(
                            getRequiredFormWidget(dropDownValue, label,
                                choices: choice),
                          );
                          _textEditingController.text = '';
                        },
                      );
                      formFieldsModals.add(
                        QuestionModel(
                            question: label,
                            type: dropDownValue,
                            choices: choice,
                            answer: ''),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  haveChoices
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: choices.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Choice $index',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextField(
                                    controller: choices[index],
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: Color(0xfff3f3f4),
                                      filled: true,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      : Container(),
                  RaisedButton(
                    child: Icon(
                      Icons.loupe,
                      color: Colors.yellow,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      QuizModel form = QuizModel(
                        questions: formFieldsModals,
                        testTime: testTime,
                      );
                      Navigator.of(context).pop(form);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
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
