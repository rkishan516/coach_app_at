import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:coach_app/SpeechRouting/RouteMap.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

const languages = const [
  const Language('English', 'en_US'),
  const Language('Hindi', 'hi_IND'),
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}

class InsideSheet extends StatefulWidget {
  @override
  _InsideSheetState createState() => new _InsideSheetState();
}

class _InsideSheetState extends State<InsideSheet> {
  late SpeechToText _speech;

  bool _isAvailable = false;
  bool _isListening = false;

  String resulttext = 'Tap Mic and Speak';
  late Map _routejson;

  //String _currentLocale = 'en_US';
  Language selectedLang = languages.first;

  @override
  initState() {
    super.initState();
    activateSpeechRecognizer();
    printDailyNewsDigest();
  }

  Future printDailyNewsDigest() async {
    // String news = await gatherNewsReports();
    String stringjson =
        await DefaultAssetBundle.of(context).loadString("assets/Routing.json");
    _routejson = jsonDecode(stringjson);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void activateSpeechRecognizer() {
    _speech = SpeechToText();
    _speech.initialize(
      onStatus: (status) {
        setState(() {
          _isListening = _speech.isListening;
        });
      },
    ).then((bool result) => setState(
          () => _isAvailable = result,
        ));

    // _speech.setRecognitionStartedHandler(() => setState(() {
    //       _isListening = true;
    //       if (_isListening) {
    //         setState(() {
    //           resulttext = "Tap Mic and Speak";
    //         });
    //       }
    //     }));

    // _speech.setRecognitionCompleteHandler((val) => setState(() {
    //       _isListening = false;
    //       if (!_isListening) {
    //         setState(() {
    //           resulttext = "Unable to Route";
    //         });
    //       }
    //     }));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: new Text('GuruCool Assistant'),
        actions: [
          new PopupMenuButton<Language>(
            onSelected: (Language lang) {
              setState(() => selectedLang = lang);
            },
            itemBuilder: (BuildContext context) => _buildLanguagesWidgets,
          )
        ],
      ),
      body: new Padding(
          padding: new EdgeInsets.all(8.0),
          child: new Center(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                new Expanded(
                    child: new Container(
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.grey.shade200,
                        child: Center(
                            child: Text(
                          resulttext,
                          style: TextStyle(fontSize: 20.0),
                        )))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButton(
                      onPressed: _isAvailable && !_isListening
                          ? () => _speech.listen(
                                onResult: (result) {
                                  final text = result.recognizedWords;
                                  setState(() {
                                    resulttext = text;
                                  });
                                  _routejson.forEach((key, value) async {
                                    if (text
                                        .trim()
                                        .toLowerCase()
                                        .contains(key)) {
                                      if (value
                                          .toString()
                                          .startsWith("/show dialog")) {
                                        Navigator.of(context).pop();
                                        showDialog(
                                          context: context,
                                          builder: (context) => RouteMap()
                                              .createroute()[value]!
                                              .call(context),
                                        );
                                      } else {
                                        Navigator.of(context).pop();
                                        Navigator.pushNamed(context, value);
                                      }
                                    }
                                  });
                                },
                              )
                          : _isListening
                              ? () => _speech.stop().then(
                                    (value) {
                                      setState(
                                        () => _isListening = false,
                                      );
                                    },
                                  )
                              : null,
                      label: _isListening
                          ? 'Listening...'
                          : 'Listen (${selectedLang.code})',
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }

  List<CheckedPopupMenuItem<Language>> get _buildLanguagesWidgets => languages
      .map((l) => new CheckedPopupMenuItem<Language>(
            value: l,
            checked: selectedLang == l,
            child: new Text(l.name),
          ))
      .toList();

  Widget _buildButton({String? label, VoidCallback? onPressed}) {
    if (!_isListening && !_isAvailable) {
      activateSpeechRecognizer();
    }
    return new Padding(
        padding: new EdgeInsets.all(12.0),
        child: AvatarGlow(
          glowBorderRadius: BorderRadius.circular(50.0),
          duration: Duration(milliseconds: 2000),
          repeat: true,
          glowColor: Color(0xffF36C24),
          child: FloatingActionButton(
            elevation: 8.0,
            backgroundColor: Color(0xffF36C24),
            mini: false,
            onPressed: onPressed,
            tooltip: label,
            child: _isListening ? Icon(Icons.mic) : Icon(Icons.mic_off),
          ),
        ));
  }
}
