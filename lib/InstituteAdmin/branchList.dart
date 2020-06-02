import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/InstituteAdmin/branchPage.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/adminSection/branchRegister.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class BranchList extends StatefulWidget {
  @override
  _BranchListState createState() => _BranchListState();
}

class _BranchListState extends State<BranchList> {
  @override
  Widget build(BuildContext context) {
    int length = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Branches'.tr(),
          style: GoogleFonts.portLligatSans(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData.fallback().copyWith(color: Colors.white),
      ),
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
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.orange, Colors.deepOrange])),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 12,
              child: StreamBuilder<Event>(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child(
                        'institute/${FireBaseAuth.instance.instituteid}/branches/')
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, Institute> institutes =
                        Map<String, Institute>();
                    print(snapshot.data.snapshot.value);
                    snapshot.data.snapshot.value?.forEach((k, v) {
                      institutes[k] = Institute.fromJson(v);
                    });
                    length = institutes.length;
                    return ListView.builder(
                      itemCount: length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.orange,
                            child: Text(
                              institutes.keys.toList()[index],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            '${institutes[institutes.keys.toList()[index]].name}',
                            style: TextStyle(color: Colors.orange),
                          ),
                          subtitle: Text(
                            '${institutes[institutes.keys.toList()[index]].address}',
                            style: TextStyle(color: Colors.orange),
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: Colors.orange,
                          ),
                          onTap: () {
                            FireBaseAuth.instance.branchid =
                                institutes.keys.toList()[index];
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return BranchPage();
                            }));
                          },
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return BranchRegister(
                                    institute: institutes[
                                        institutes.keys.toList()[index]],
                                    branchCode: institutes.keys.toList()[index],
                                  );
                                });
                          },
                        ));
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
