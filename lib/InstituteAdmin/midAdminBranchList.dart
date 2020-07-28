import 'package:auto_size_text/auto_size_text.dart';
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/GlobalFunction/SlideButton.dart';
import 'package:coach_app/InstituteAdmin/branchPage.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/adminSection/branchRegister.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';

class MidAdminBranchList extends StatefulWidget {
  @override
  _MidAdminBranchListState createState() => _MidAdminBranchListState();
}

class _MidAdminBranchListState extends State<MidAdminBranchList> {
  int length = 0;
  List<int> branchesKey;

  @override
  Widget build(BuildContext context) {
    branchesKey = FireBaseAuth.instance.branchList;
    Size size = MediaQuery.of(context).size;
    length = branchesKey?.length;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF36C24),
        title: StreamBuilder<Event>(
          stream: FirebaseDatabase.instance
              .reference()
              .child('/institute/${FireBaseAuth.instance.instituteid}/name')
              .onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return AutoSizeText(
                snapshot.data.snapshot.value ?? '',
                maxLines: 2,
                style: GoogleFonts.portLligatSans(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              );
            }else{
              return Container();
            }
          },
        ),
        flexibleSpace: Stack(
          children: <Widget>[
            Transform.translate(
              offset: Offset(size.width - 70.0, 56.0),
              child: FutureBuilder<dynamic>(
                future: FirebaseStorage.instance
                    .ref()
                    .child(
                        '/instituteLogo/${FireBaseAuth.instance.instituteid}')
                    .getDownloadURL(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            45.0,
                          ),
                          border: Border.all(color: Colors.white, width: 3.0)),
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
              ),
            ),
          ],
        ),
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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.8),
            itemCount: length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Color(0xffF36C24),
                child: StreamBuilder<Event>(
                  stream: FirebaseDatabase.instance
                      .reference()
                      .child(
                          'institute/${FireBaseAuth.instance.instituteid}/branches/${branchesKey[index]}')
                      .onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Branch branch =
                          Branch.fromJson(snapshot.data.snapshot.value);
                      return InkWell(
                        child: GridTile(
                          child: ListView(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
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
                                        branchesKey[index].toString(),
                                        style:
                                            TextStyle(color: Color(0xffF36C24)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Text(
                                    '${branch.name}',
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
                                    '${branch.address}',
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
                          FireBaseAuth.instance.branchid = branchesKey[index];
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
                                institute: branch,
                                branchCode: branchesKey[index].toString(),
                              );
                            },
                          );
                        },
                      );
                    } else {
                      return UploadDialog(warning: 'Fetching'.tr());
                    }
                  },
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: SlideButtonR(
                        text: 'Add branch'.tr(),
                        onTap: () => showCupertinoDialog(
                            context: context,
                            builder: (context) => BranchRegister()),
                        width: 150,
                        height: 50),
    );
  }
}
