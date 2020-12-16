import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/GlobalFunction/SlideButton.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/courses/FormGeneration/fields/form_builder_checkbox_list.dart';
import 'package:coach_app/courses/FormGeneration/fields/form_builder_radio.dart';
import 'package:coach_app/courses/FormGeneration/fields/form_builder_switch.dart';
import 'package:coach_app/courses/FormGeneration/fields/form_builder_text_field.dart';
import 'package:coach_app/courses/FormGeneration/form_builder.dart';
import 'package:coach_app/courses/FormGeneration/form_builder_field_option.dart';
import 'package:coach_app/courses/FormGeneration/form_builder_validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class FormGenerator extends StatefulWidget {
  final String title;
  final String description;
  final QuizModel quizModel;
  FormGenerator(
      {@required this.title,
      @required this.description,
      @required this.quizModel});
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
  List<QuestionModel> formFieldsModals;
  Duration testTime;
  DateTime startTime;

  @override
  void initState() {
    for (int i = 0; i < 4; i++) {
      choices.add(TextEditingController());
    }
    testTime = widget.quizModel?.testTime ?? Duration();
    startTime = widget.quizModel?.startTime ?? DateTime.now();
    formFieldsModals = widget.quizModel?.questions ?? List<QuestionModel>();
    super.initState();
  }

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
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: ListView(
            children: <Widget>[
              Card(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      widget.title.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                child: Container(
                  height: 40,
                  child: Center(child: Text('Start Date and Time'.tr())),
                ),
              ),
              Card(
                child: Container(
                  height: 100,
                  child: CupertinoDatePicker(
                    onDateTimeChanged: (dateTime) {
                      startTime = dateTime;
                    },
                    initialDateTime: DateTime.now(),
                    mode: CupertinoDatePickerMode.dateAndTime,
                  ),
                ),
              ),
              Card(
                child: Container(
                  height: 40,
                  child: Center(child: Text('Quiz Duration'.tr())),
                ),
              ),
              Card(
                child: Container(
                  height: 100,
                  child: CupertinoTimerPicker(
                    initialTimerDuration: testTime,
                    onTimerDurationChanged: (duration) => testTime = duration,
                    mode: CupertinoTimerPickerMode.hms,
                  ),
                ),
              ),
              FormBuilder(
                autovalidate: true,
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: ScrollController(),
                  itemCount: formFieldsModals.length,
                  itemBuilder: (BuildContext context, int index) => Card(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: ListTile(
                        title: getRequiredFormWidget(
                          formFieldsModals[index].type,
                          '${index + 1}. ' + formFieldsModals[index].question,
                          choices: formFieldsModals[index].choices,
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Color(0xffF36C24),
                          ),
                          onPressed: () {
                            setState(() {
                              formFieldsModals.removeAt(index);
                            });
                          },
                        ),
                      ),
                    ),
                  ),
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
                            child: Text(value.tr()),
                          );
                        }).toList(),
                        onChanged: (e) => setState(
                          () {
                            dropDownValue = e;
                            label = e + ' label';
                            if (e == 'Single Choice' ||
                                e == 'Multiple Choice') {
                              haveChoices = true;
                            } else {
                              haveChoices = false;
                            }
                          },
                        ),
                      ),
                      TextField(
                        controller: _textEditingController,
                        onChanged: (val) {
                          label = val;
                        },
                        decoration: InputDecoration(
                          hintText: 'Question'.tr(),
                          border: InputBorder.none,
                          fillColor: Color(0xfff3f3f4),
                          filled: true,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      haveChoices
                          ? ListView.builder(
                              shrinkWrap: true,
                              controller: ScrollController(),
                              itemCount: choices.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Choice'.tr() + ' $index',
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
                      SlideButtonCovered(
                        height: 50,
                        text: 'Add Question'.tr(),
                        width: 150,
                        icon: Icon(Icons.add_circle_outline),
                        onTap: () {
                          bool flag = false;
                          formFieldsModals.forEach((element) {
                            if (element.question == label) {
                              Alert.instance.alert(
                                  context, 'Question Already Exist'.tr());
                              flag = true;
                              return;
                            }
                          });
                          if (flag == true) {
                            _textEditingController.text = '';
                            choices.forEach((e) {
                              e.text = '';
                            });
                            return;
                          }

                          var choice =
                              choices.map((e) => e?.text).toSet().toList();
                          choice.remove('');
                          setState(
                            () => _textEditingController.text = '',
                          );
                          formFieldsModals.add(
                            QuestionModel(
                                question: label,
                                type: dropDownValue,
                                choices: choice),
                          );
                          choices.forEach((element) {
                            element.text = '';
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: RaisedButton(
                          child: Text(
                            'Submit Quiz'.tr(),
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          color: Color(0xffFF6C24),
                          onPressed: () {
                            QuizModel form = QuizModel(
                              questions: formFieldsModals,
                              testTime: testTime,
                              startTime: startTime,
                            );
                            Navigator.of(context).pop(form);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getRequiredFormWidget(String value, String labelText,
      {List<String> choices}) {
    switch (value) {
      case 'Short Paragraph':
      case 'Fill In the Blank':
        return FormBuilderTextField(
          attribute: "text" + labelText,
          decoration: InputDecoration(labelText: labelText),
          maxLength: 100,
        );
      case 'Long Paragraph':
        return FormBuilderTextField(
          attribute: "text" + labelText,
          decoration: InputDecoration(labelText: labelText),
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
