import 'dart:async';

import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CouponModal.dart';
import 'CreateCoupon.dart';


class CouponList extends StatefulWidget {
  @override
  _CouponListState createState() => _CouponListState();
}

class _CouponListState extends State<CouponList> {
  final List<CouponModal> _listItem= [];
   Query _query;
    final dbRef = FirebaseDatabase.instance;
  StreamSubscription<Event> _onDataAddedSubscription;
  StreamSubscription<Event> _onDataChangedSubscription;
  StreamSubscription<Event> _onDataRemovedSubscription;
  SharedPreferences _pref;
  final GlobalKey<ScaffoldState> _scaffoldkey= new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _initializeevent();

  }
  _initializeevent() {
    _query =dbRef.reference().child('institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/coupons');
    _onDataAddedSubscription = _query.onChildAdded.listen(onCouponAdded);
    //_onDataChangedSubscription = _query.onChildChanged.listen(onCouponChanged);
    _onDataRemovedSubscription = _query.onChildRemoved.listen(onCouponRemoved);
   
  }

  onCouponAdded(Event event) {
    
    setState(() {
      _listItem.add(CouponModal.fromSnapShot(event.snapshot));
      
    });
    //_showsnackbar(context,"New Event is Added");
  }
  onCouponRemoved(Event event) {
    //_showsnackbar(context,"Event is removed");
    var index;
    _listItem.forEach((element) {
      if(element.couponKey==event.snapshot.key){
       index=_listItem.indexOf(element);
      }
    });
    setState(() {
        _listItem.removeAt(index);
        
       });
    
  }
// onCouponChanged(Event event) {
  
//     _listItem.forEach((element) {
//       if(element.couponKey==event.snapshot.key){
//         var index=_listItem.indexOf(element);
//        setState(() {
//         _listItem[index] = CouponModal.fromSnapShot(event.snapshot);
//        });
//       }
//     });
//     //_showsnackbar(context,"Event is Updated");
//   }

 void _showsnackbar(BuildContext context, String message){
 
  final snackBar= SnackBar(content: Text(message));
  _scaffoldkey.currentState.showSnackBar(snackBar);
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coupon List'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:(){
         Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateCoupon()));
        } ,
        tooltip: "Add Coupon",
        ),
      body:  
           Container(
             padding: EdgeInsets.all(8.0),
             child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: _listItem.map((item)=> GestureDetector(
                onLongPress: (){
                  dbRef.reference().child('institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/coupons').child(item.couponKey).remove();
                },
                              child: Card(
                   color: Colors.transparent,
                  elevation: 0,
                  child: Container(
                    decoration: BoxDecoration( 
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage('assets/coupon.png'),

                        )
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text("Save "+item.discountValue+"%",
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white
                      ),)
                      ),
                  ),
                ),
              )
              ).toList(),
              ),
           ),
      
    );
  }
}