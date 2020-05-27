import 'package:coach_app/Models/model.dart';
import 'package:coach_app/courses/content_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChapterPage extends StatefulWidget {
  final Subjects subject;
  ChapterPage({@required this.subject});
  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  List<String> chapters = [
    'Chemical Bonding',
    'Solid State',
    'Solutions',
    'Chemical Kinetics',
    'Surface Chemistry',
    'Coordination Compounds',
    'Alcohols, Phenols, and Ethers',
    'Aldehydes, Ketones, and Carboxylic Acids'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                      text: widget.subject.name,
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
                child: ListView.builder(
                  itemCount: widget.subject.chapters.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          '${widget.subject.chapters[index].name}',
                          style: TextStyle(color: Colors.blue),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Colors.blue,
                        ),
                        onTap: () => Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => ContentPage(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
