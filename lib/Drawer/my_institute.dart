import 'package:coach_app/Drawer/drawer.dart';
import 'package:coach_app/Drawer/firebaseStorageImage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
      drawer: getDrawer(context),
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
                        return CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),
            ),
          ),
          Expanded(child: Text(widget.dataSnapshot)),
        ],
      ),
    );
  }
}
