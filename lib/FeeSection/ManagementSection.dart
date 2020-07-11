
import 'package:flutter/material.dart';

import 'CouponList.dart';
import 'FeeReceipt.dart';
import 'FeeStructure.dart';
import 'StudentReport/PaymentType.dart';
import 'ToggleButton.dart';

class ManagementSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Management Section"),),
      body: Center(
        child: Padding(
          padding:EdgeInsets.all(22.0),
          child: Column(
            children: [
              RaisedButton(
                onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CouponList()));
              },
              child: Text("Coupon List"),
              ),
              SizedBox(height: 10.0,),
              RaisedButton(
                onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FeeReceipt()));
              },
              child: Text("Create Course Create Fees"),
              ),
              SizedBox(height: 10.0,),

              RaisedButton(
                onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FeeStructure()));
              },
              child: Text("Fees Management"),
              ),
              SizedBox(height: 10.0,),

              RaisedButton(
                onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ToggleButton()));
              },
              child: Text(" Attach Cupon on a particular student"),
              ),
              SizedBox(height: 10.0,),

              
              RaisedButton(
                onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PaymentType()));
              },
              child: Text(" Student fee Section"),
              ),
            ],
          ),
          ),
      ),
    );

  }
}