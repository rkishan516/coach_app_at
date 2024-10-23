import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/Models/random_string.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CreateCoupon extends StatefulWidget {
  @override
  _CreateCouponState createState() => _CreateCouponState();
}

class _CreateCouponState extends State<CreateCoupon> {
  final TextEditingController _discountText = TextEditingController();
  final dbRef = FirebaseDatabase.instance;
  String couponKey = "";

  @override
  void initState() {
    couponKey = randomNumeric(6);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Coupon'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Enter Discount Value(%)',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _discountText,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter value",
                      hintText: "Enter value",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 48.0,
            thickness: 2.0,
          ),
          GestureDetector(
            onTap: () {
              //Save into database
              dbRef
                  .ref()
                  .child(
                      'institute/${AppwriteAuth.instance.instituteid}/branches/${AppwriteAuth.instance.branchid}/coupons')
                  .child(couponKey)
                  .update({
                "discount": _discountText.text,
              });
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  20.0,
                ),
                color: Color(
                  0xffF36C24,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                vertical: 15,
              ),
              alignment: Alignment.center,
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
