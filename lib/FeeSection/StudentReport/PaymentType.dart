
import 'package:coach_app/Authentication/FirebaseAuth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'OneTimePay.dart';
import 'StuInstallment.dart';

class PaymentType extends StatefulWidget {
  @override
  _PaymentTypeState createState() => _PaymentTypeState();
}

class _PaymentTypeState extends State<PaymentType> {
  bool toggleValue1 = false;
  bool toggleValue2 = false;
  final dbref = FirebaseDatabase.instance;

  _loadFromDatabase() async {
     await dbref
        .reference()
        .child(
            "institute/${FireBaseAuth.instance.instituteid}/branches/${FireBaseAuth.instance.branchid}/students/E2PyrrbVVqNI8PqwRNwvZCfy57X2/course/410665312/fees/Installments/AllowedThrough")
        .onValue.listen((event) {
          print(event.snapshot.value);
    if (event.snapshot.value == "Installments") {
      setState(() {
        toggleValue1 = true;
      });
    } else if (event.snapshot.value == "OneTime") {
      setState(() {
        toggleValue2 = true;
      });
    }
    else{
      setState(() {
      toggleValue1= false;
      toggleValue2= false;  
      });
    } 
         });
        
    
  }

  @override
  void initState() {
    super.initState();
    _loadFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Type"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                    'Select Payment Type',
                    style: TextStyle(
                        fontSize: 22.0, fontWeight: FontWeight.w400),
              ),
              SizedBox(height:MediaQuery.of(context).size.height*0.2 ,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Pay in Installments',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onLongPress: () {
                        if (toggleValue1)
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (coontext) =>
                                  StuInstallment(toggleValue1)));
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 1000),
                        height: 40.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: toggleValue1
                              ? Colors.greenAccent[100]
                              : Colors.redAccent[100].withOpacity(0.5),
                        ),
                        child: Stack(
                          children: [
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.easeIn,
                              left: toggleValue1 ? 60.0 : 0.0,
                              right: toggleValue1 ? 0.0 : 60.0,
                              child: InkWell(
                                onTap: () {
                                  if (!toggleValue1 && !toggleValue2)
                                    toggleButton1();
                                },
                                child: AnimatedSwitcher(
                                  duration: Duration(microseconds: 1000),
                                  transitionBuilder: (Widget child,
                                      Animation<double> animation) {
                                    return RotationTransition(
                                      child: child,
                                      turns: animation,
                                    );
                                  },
                                  child: toggleValue1
                                      ? Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 35.0,
                                          key: UniqueKey(),
                                        )
                                      : Icon(
                                          Icons.remove_circle_outline,
                                          color: Colors.red,
                                          size: 35.0,
                                          key: UniqueKey(),
                                        ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex:2,
                      child: Text(
                      'Pay One Time',
                      style:
                          TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex:1,
                      child: GestureDetector(
                      onLongPress: () {
                        if (toggleValue2)
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  OneTimeInstallment(toggleValue2)));
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 1000),
                        height: 40.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: toggleValue2
                              ? Colors.greenAccent[100]
                              : Colors.redAccent[100].withOpacity(0.5),
                        ),
                        child: Stack(
                          children: [
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.easeIn,
                              left: toggleValue2 ? 60.0 : 0.0,
                              right: toggleValue2 ? 0.0 : 60.0,
                              child: InkWell(
                                onTap: () {
                                  if (!toggleValue1 && !toggleValue2)
                                    toggleButton2();
                                },
                                child: AnimatedSwitcher(
                                  duration: Duration(microseconds: 1000),
                                  transitionBuilder: (Widget child,
                                      Animation<double> animation) {
                                    return RotationTransition(
                                      child: child,
                                      turns: animation,
                                    );
                                  },
                                  child: toggleValue2
                                      ? Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 35.0,
                                          key: UniqueKey(),
                                        )
                                      : Icon(
                                          Icons.remove_circle_outline,
                                          color: Colors.red,
                                          size: 35.0,
                                          key: UniqueKey(),
                                        ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  toggleButton1() {
    setState(() {
      toggleValue1 = !toggleValue1;
      if (toggleValue1) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => StuInstallment(!toggleValue1))).then((value) => _loadFromDatabase());
      } else {}
    });
  }

  toggleButton2() {
    setState(() {
      toggleValue2 = !toggleValue2;
      if (toggleValue2) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OneTimeInstallment(!toggleValue2))).then((value) => _loadFromDatabase());
      } else {}
    });
  }
}
