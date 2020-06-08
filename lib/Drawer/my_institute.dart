import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/model.dart';
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
              widget.dataSnapshot.split('/')[1][0].toUpperCase() +
                  widget.dataSnapshot.split('/')[1].toString().substring(1),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                  return Text(
                      "Contact".tr() + ": " + snapshot.data.snapshot.value);
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
            flex: 5,
            child: StreamBuilder<Event>(
              stream: FirebaseDatabase.instance
                  .reference()
                  .child('/instituteList/')
                  .orderByValue()
                  .equalTo(FireBaseAuth.instance.instituteid)
                  .onValue,
              builder: (BuildContext context, snap) {
                if (snap.hasData) {
                  if (snap.data.snapshot.value == null) {
                    return Text('Unable to find Institute Code'.tr());
                  }
                  if (FireBaseAuth.instance.previlagelevel == 4) {
                    return StreamBuilder<Event>(
                      stream: FirebaseDatabase.instance
                          .reference()
                          .child(
                              '/institute/${FireBaseAuth.instance.instituteid}/branches')
                          .onValue,
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.snapshot.value == null) {
                            return Text('Unable to find Institute Code'.tr());
                          } else {
                            Map<String, Branch> branches =
                                Map<String, Branch>();
                            snapshot.data.snapshot.value.forEach((k, b) {
                              branches[k] = Branch.fromJson(b);
                            });
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                itemCount: branches.length,
                                itemBuilder: (context, index) {
                                  String key = branches.keys.toList()[index];
                                  return Card(
                                    color: Colors.orange[100],
                                    child: ListTile(
                                      isThreeLine: true,
                                      title: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Branch Name'.tr() +
                                            ': ' +
                                            '${branches[key].name}'),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Branch Code'.tr() +
                                            ' : ${snap.data.snapshot.value.keys.toList()[0] + key}'),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        } else {
                          return PlaceholderLines(
                            count: 1,
                            animate: true,
                          );
                        }
                      },
                    );
                  } else if (FireBaseAuth.instance.previlagelevel > 1) {
                    return Text(
                        'Institute Code'.tr()+' : ${snap.data.snapshot.value.keys.toList()[0]}${FireBaseAuth.instance.branchid}\n('+'Share this code with Student'.tr()+')');
                  } else {
                    return Text(
                        'Institute Code'.tr()+' : ${snap.data.snapshot.value.keys.toList()[0]}${FireBaseAuth.instance.branchid}');
                  }
                } else {
                  return PlaceholderLines(
                    count: 1,
                    animate: true,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
