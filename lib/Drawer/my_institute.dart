import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class MyInstitute extends StatefulWidget {
  dynamic dataSnapshot;
  MyInstitute({@required this.dataSnapshot});
  @override
  _MyInstituteState createState() => _MyInstituteState();
}

class _MyInstituteState extends State<MyInstitute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Institute'.tr(),
          style: GoogleFonts.portLligatSans(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData.fallback().copyWith(color: Colors.white),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              child: Center(
                child: FutureBuilder<dynamic>(
                    future: FirebaseStorage.instance
                        .ref()
                        .child(widget.dataSnapshot)
                        .getDownloadURL(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                50.0,
                              ),
                              border:
                                  Border.all(color: Colors.orange, width: 3.0)),
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundImage: NetworkImage(
                              snapshot.data,
                            ),
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),
            ),
          ),
          Expanded(
            
            child: Text(
              widget.dataSnapshot.split('/')[1][0].toUpperCase() + widget.dataSnapshot.split('/')[1].toString().substring(1),
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
            ),
          ),
          Expanded(
            child: StreamBuilder<Event>(
              stream: FirebaseDatabase.instance
                  .reference()
                  .child(
                      '/institute/${FireBaseAuth.instance.instituteid}/Phone No')
                  .onValue,
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  return Text("Contact".tr()+": " +snapshot.data.snapshot.value);
                } else {
                  return PlaceholderLines(
                    count: 1,
                    animate: true,
                  );
                }
              },
            ),
          ),
          Expanded(
            child: Container(),
            flex: 4,
          ),
        ],
      ),
    );
  }
}
