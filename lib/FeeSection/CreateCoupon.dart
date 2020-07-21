
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:coach_app/FeeSection/random_string.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CreateCoupon extends StatefulWidget {
  @override
  _CreateCouponState createState() => _CreateCouponState();
}

class _CreateCouponState extends State<CreateCoupon> {
  final TextEditingController _feeText = TextEditingController();
  final TextEditingController _discountText = TextEditingController();
  final TextEditingController _totalText = TextEditingController();
   final dbRef = FirebaseDatabase.instance;
   String couponKey="";
   int noofcoupons=1;

  _changeTotalFees(value){
    print(value);
    setState(() {
      if(value!='')
      _totalText.text = (double.parse(_feeText.text)- (double.parse(_feeText.text)*0.01*double.parse(value))).toString();
      else
      _totalText.text="";
    });
  }
  _saveintodatabase(){

    dbRef.reference().child('institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/coupons').child(couponKey).update({
      "discount": _discountText.text,
    });
    Navigator.of(context).pop();
  }
  _loadFromDatabase(){
  

   
  }
  @override
  void initState() {
    super.initState();
    couponKey= randomNumeric(6);
    _loadFromDatabase();
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2, 
                child: Text(
                  'Enter total fees',
                  
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500
                  ),
                  )
                  ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _feeText,
                  decoration: InputDecoration(
                      
                      border: OutlineInputBorder(),
                      labelText: "Enter Fees",
                      hintText: "Enter Fees"),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.1,),
          
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(10.0)
            ),

            child: Column(children: [
              Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2, 
                child: Text(
                  'Enter Discount Value(%)',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400
                  ),
                  )
                  ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  onChanged: (value){
                    _changeTotalFees(value);
                  },
                  controller: _discountText,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter value",
                      hintText: "Enter value"),
                ),
              ),
            ],
          ),
          SizedBox(height: 30.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2, 
                child: Text(
                  'Fees After Coupon is applied',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400
                  ),
                  )
                  ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  controller: _totalText,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "",
                      hintText: ""),
                ),
              ),
            ],
          )  
            ],),
          ),
        SizedBox(height: MediaQuery.of(context).size.height*0.1,),
        Divider(
                height: 48.0,
                thickness: 2.0,
              ),

              GestureDetector(
                onTap: () {
                  _saveintodatabase();
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.orange),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 15), 

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
