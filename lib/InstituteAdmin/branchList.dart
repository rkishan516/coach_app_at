import 'dart:collection';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/Alert.dart';
import 'package:coach_app/Dialogs/uploadDialog.dart';
import 'package:coach_app/GlobalFunction/SlideButton.dart';
import 'package:coach_app/InstituteAdmin/branchPage.dart';
import 'package:coach_app/InstituteAdmin/midAdminList.dart';
import 'package:coach_app/Models/model.dart';
import 'package:coach_app/adminSection/branchRegister.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';

class BranchList extends StatefulWidget {
  @override
  _BranchListState createState() => _BranchListState();
}

class _BranchListState extends State<BranchList> {
  TextEditingController searchTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int length = 0;
    return StreamBuilder<Event>(
      stream: FirebaseDatabase.instance
          .reference()
          .child('institute/${FireBaseAuth.instance.instituteid}/')
          .onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, Branch> institutes = SplayTreeMap<String, Branch>();
          if (snapshot.data.snapshot.value != null) {
            snapshot.data.snapshot.value['branches']?.forEach((k, v) {
              if (searchTextEditingController.text == '') {
                institutes[k] = Branch.fromJson(v);
              } else {
                Branch branch = Branch.fromJson(v);
                if (branch.name.toLowerCase().contains(
                        searchTextEditingController.text.toLowerCase()) ||
                    branch.address.toLowerCase().contains(
                        searchTextEditingController.text.toLowerCase()) ||
                    k.contains(searchTextEditingController.text)) {
                  institutes[k] = branch;
                }
              }
            });
          }

          length = institutes.length;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xffF36C24),
              title: Text(
                snapshot.data.snapshot.value['name'] ?? '',
                style: GoogleFonts.portLligatSans(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              flexibleSpace: Stack(
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(size.width - 70, kToolbarHeight - 24),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: (snapshot.data.snapshot.value['paid'] == 'Trial')
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Trial',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : Container(),
                    ),
                  ),
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
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: searchTextEditingController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Color(0xfff3f3f4),
                          ),
                        ),
                        contentPadding: EdgeInsets.only(left: 10),
                        hintStyle: TextStyle(fontSize: 15),
                        hintText: 'Search by branch code,name,address'.tr(),
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 12,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.85),
                        itemCount: length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Color(0xffF36C24),
                            child: InkWell(
                              child: GridTile(
                                child: Column(
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
                                        child: AutoSizeText(
                                          '${institutes[institutes.keys.toList()[index]].name}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
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
                                        child: AutoSizeText(
                                          '${institutes[institutes.keys.toList()[index]].address}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
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
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Row(
              children: <Widget>[
                if (snapshot.data.snapshot.value['paid'] == 'Trial' ||
                    snapshot.data.snapshot.value['paid'] == 'Paid')
                  SlideButton(
                    icon: Icon(Icons.list),
                    text: 'Mid Admin'.tr(),
                    onTap: () {
                      if(searchTextEditingController.text != ''){
                        Alert.instance.alert(context, "Mid admin can't be access during filter mode".tr());
                        searchTextEditingController.text = '';
                        return;
                      }
                      List<Map<String, String>> branches =
                          List<Map<String, String>>();
                      institutes.forEach(
                        (key, value) {
                          branches.add(
                            {
                              'branchName': value.name,
                              'branchKey': key,
                            },
                          );
                        },
                      );
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              MidAdminList(branches: branches)));
                    },
                    width: 180,
                    height: 50,
                  )
                else
                  Container(),
                SlideButtonR(
                    text: 'Add new branch'.tr(),
                    onTap: () => showCupertinoDialog(
                        context: context,
                        builder: (context) => BranchRegister()),
                    width: 180,
                    height: 50)
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        } else {
          return UploadDialog(warning: 'Fetching'.tr());
        }
      },
    );
  }
}
