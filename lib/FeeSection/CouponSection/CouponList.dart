import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Dialogs/areYouSure.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:coach_app/Utils/Colors.dart';
import '../CouponSection/CouponModal.dart';
import '../CouponSection/CreateCoupon.dart';

class CouponList extends StatefulWidget {
  @override
  _CouponListState createState() => _CouponListState();
}

class _CouponListState extends State<CouponList> {
  final List<CouponModal> _listItem = [];
  Query _query;
  final dbRef = FirebaseDatabase.instance;
  @override
  void initState() {
    super.initState();
    _initializeevent();
  }

  _initializeevent() {
    _query = dbRef.reference().child(
        'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/coupons');
    _query.onChildAdded.listen(onCouponAdded);
    _query.onChildRemoved.listen(onCouponRemoved);
  }

  onCouponAdded(Event event) {
    setState(() {
      _listItem.add(CouponModal.fromSnapShot(event.snapshot));
    });
  }

  onCouponRemoved(Event event) {
    var index;
    _listItem.forEach((element) {
      if (element.couponKey == event.snapshot.key) {
        index = _listItem.indexOf(element);
      }
    });
    setState(() {
      _listItem.removeAt(index);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coupon List'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CreateCoupon())),
        tooltip: "Add Coupon",
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: _listItem
              .map(
                (item) => GestureDetector(
                  onLongPress: () async {
                    String val = await showDialog(
                        context: context, builder: (context) => AreYouSure());
                    if (val != 'Yes') {
                      return;
                    }
                    dbRef
                        .reference()
                        .child(
                            'institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/coupons')
                        .child(item.couponKey)
                        .remove();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 6,
                      color: GuruCoolLightColor.primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.values[4],
                        children: [
                          Card(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.height / 6,
                              color: GuruCoolLightColor.whiteColor,
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'SAVE',
                                        style: TextStyle(
                                          fontSize: 26,
                                          color: Color(
                                            0xffF36C24,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        item.discountValue + "%",
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Color(
                                            0xffF36C24,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    '!',
                                    style: TextStyle(
                                      fontSize: 42,
                                      color: GuruCoolLightColor.primaryColor,
                                    ),
                                  )
                                ],
                              )),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 8,
                              width: MediaQuery.of(context).size.width / 3,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: GuruCoolLightColor.whiteColor,
                                    width: 2,
                                  ),
                                  left: BorderSide(
                                    color: GuruCoolLightColor.whiteColor,
                                    width: 2,
                                  ),
                                  right: BorderSide(
                                    color: GuruCoolLightColor.whiteColor,
                                    width: 2,
                                  ),
                                  top: BorderSide(
                                    color: GuruCoolLightColor.whiteColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Discount\nCoupon',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 26,
                                    color: GuruCoolLightColor.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
