import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/InstituteAdmin/branchPage.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/adminSection/branchRegister.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:google_fonts/google_fonts.dart';

class BranchList extends StatefulWidget {
  @override
  _BranchListState createState() => _BranchListState();
}

class _BranchListState extends State<BranchList> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int length = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: StreamBuilder<Event>(
          stream: FirebaseDatabase.instance
              .reference()
              .child('institute/${FireBaseAuth.instance.instituteid}/name')
              .onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                snapshot.data.snapshot.value,
                style: GoogleFonts.portLligatSans(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              );
            }
            return Container();
          },
        ),
        flexibleSpace: Stack(
          children: <Widget>[
            Transform.translate(
              offset: Offset(size.width - 70.0, 56.0),
              child: StreamBuilder<Event>(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child(
                        'institute/${FireBaseAuth.instance.instituteid}/name')
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return FutureBuilder<dynamic>(
                      future: FirebaseStorage.instance
                          .ref()
                          .child(
                              '/instituteLogo/${snapshot.data.snapshot.value}')
                          .getDownloadURL(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  45.0,
                                ),
                                border: Border.all(
                                    color: Colors.white, width: 3.0)),
                            child: CircleAvatar(
                              radius: 23.0,
                              backgroundImage: NetworkImage(
                                snapshot.data,
                              ),
                            ),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: StreamBuilder<Event>(
                      stream: FirebaseDatabase.instance
                          .reference()
                          .child(
                              'institute/${FireBaseAuth.instance.instituteid}/paid')
                          .onValue,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.snapshot.value == 'Trial') {
                            return Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Trial',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }
                        }
                        return Container();
                      },
                    ),
                  ),
                ),
              ],
            ),
            preferredSize: Size(MediaQuery.of(context).size.width, 1)),
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
        ),
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
                    Map<String, Branch> institutes = Map<String, Branch>();
                    print(snapshot.data.snapshot.value);
                    snapshot.data.snapshot.value?.forEach((k, v) {
                      institutes[k] = Branch.fromJson(v);
                    });
                    length = institutes.length;
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,childAspectRatio: 0.8),
                        itemCount: length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Colors.orange,
                            child: InkWell(
                              child: GridTile(
                                child: ListView(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                                      child: Center(
                                        child: Container(
                                          width: 54.0,
                                          height: 35.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.elliptical(27.0, 17.5)),
                                            color: const Color(0xffffffff),
                                          ),
                                          child: Center(
                                            child: Text(
                                              institutes.keys.toList()[index],
                                              style: TextStyle(
                                                  color: Color(0xffF36C24)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Text(
                                          '${institutes[institutes.keys.toList()[index]].name}',
                                          overflow: TextOverflow.fade,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Text(
                                          '${institutes[institutes.keys.toList()[index]].address}',
                                          overflow: TextOverflow.fade,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                FireBaseAuth.instance.branchid =
                                    institutes.keys.toList()[index];
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
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
                                      branchCode:
                                          institutes.keys.toList()[index],
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
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
