import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Installments extends StatefulWidget {
  final String totalFees;
  final bool toggleValue;
  Installments(this.totalFees, this.toggleValue);
  @override
  _InstallmentsState createState() => _InstallmentsState();
}

class _InstallmentsState extends State<Installments> {
  int noOfTextFields = 0;
  List<String> _currentDurationSelected = List(25);
  List<TextEditingController> _listEditingControllerDD;
  List<TextEditingController> _listEditingControllerYYYY;
  List<TextEditingController> _listEditingControllerMoney;
  Map map;
  bool editValue= false;
  final dbRef= FirebaseDatabase.instance;
  final TextEditingController _maxInstallText =
      TextEditingController();
  
  var durationperiod = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];
  

  Widget _createTextFields(int value) {
          
    if (value != 0) {
      
      if(editValue){
        for(int i=0;i<noOfTextFields;i++){
        String pass= (i+1).toString()+"Installment";
        _listEditingControllerMoney[i].text=map["Installments"][pass]["Amount"];
        _listEditingControllerDD[i].text= map["Installments"][pass]["Duration"].toString().split(" ")[0];
        _currentDurationSelected[i]= map["Installments"][pass]["Duration"].toString().split(" ")[1];
        _listEditingControllerYYYY[i].text= map["Installments"][pass]["Duration"].toString().split(" ")[2];
        editValue= false;
      }
      }           
        
      return ListView.builder(
          itemCount: value,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: (){
                setState(() {
                  dbRef.reference().child("institute/-M9meNGfHPWJZ0c37OsE/branches/1101/courses/410665312/fees")
                  .child("MaxInstallment/Installments/${(index+1).toString()+"Installment"}").remove();
                  noOfTextFields-=1;
                });
              },
                          child: Card(
                
                  child: Container(
                    
                width: MediaQuery.of(context).size.width ,
                height: MediaQuery.of(context).size.height*0.13 ,
                child: Row(
                  children: [
                    SizedBox(width: 4.0,),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        
                        onChanged: (value) {
                          //TODO
                        },
                        controller: _listEditingControllerMoney[index],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Enter value"),
                      ),
                    ),
                    SizedBox(width: 8.0,),
                    Expanded(
                      flex: 1,
                                        child: TextField(
                        onChanged: (value) {
                          //TODO
                        },
                        controller: _listEditingControllerDD[index],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "DD"),
                      ),
                    ),
                    SizedBox(width: 4.0,),
                    Expanded(
                      flex: 1,
                                        child: DropdownButton<String>(
                              items:
                                  durationperiod.map((String dropDownStringitem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringitem,
                                  child: Text(dropDownStringitem),
                                );
                              }).toList(),
                              onChanged: (String newValueSelected) {
                                setState(() {
                                 _currentDurationSelected[index] = newValueSelected;
                                  print(_currentDurationSelected[index]);
                                });
                              },
                              isExpanded: true,
                              hint: Text('MM'),
                              value: _currentDurationSelected[index],
                            ),
                    ),
                    SizedBox(width: 4.0,),
                    Expanded(
                      flex: 1,
                                        child: TextField(
                        onChanged: (value) {
                          //TODO
                        },
                        controller: _listEditingControllerYYYY[index],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "YYYY"),
                      ),
                    ),
                    SizedBox(width: 4.0,)
                  ],
                ),
              )),
            );
          });
    } else
      return SizedBox(
        height: 4.0,
      );
  }


       
  _saveintodatabase() {
    for(int i=0;i<noOfTextFields;i++){
      dbRef.reference().child("institute/-M9meNGfHPWJZ0c37OsE/branches/1101/courses/410665312/fees").child("MaxInstallment/Installments").update({
        ((i+1)).toString()+"Installment": {
            "Amount": _listEditingControllerMoney[i].text,
            "Duration" : _listEditingControllerDD[i].text + " " + _currentDurationSelected[i] +" "+ _listEditingControllerYYYY[i].text
        }
      });
    }
     dbRef.reference().child("institute/-M9meNGfHPWJZ0c37OsE/branches/1101/courses/410665312/fees").child("MaxInstallment").update({
       "IsMaxAllowed" : true,
       "MaxAllowedInstallment": _maxInstallText.text
      });
    Navigator.of(context).pop("confirm");
  }
  Widget _saveButton() {
    return GestureDetector(
      onTap: () {
        _saveintodatabase();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), color: Colors.orange),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        child: Text(
          "Confirm",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

 _loadFromDatabase() async{
  dbRef.reference().child("institute/-M9meNGfHPWJZ0c37OsE/branches/1101/courses/410665312/fees").child("MaxInstallment").once()
  .then((snapshot){
    map = snapshot.value;
    setState(() {
      noOfTextFields= int.parse(map["MaxAllowedInstallment"]);
      _maxInstallText.text= noOfTextFields.toString();
       _listEditingControllerDD= new List<TextEditingController>(noOfTextFields);
               _listEditingControllerYYYY= new List<TextEditingController>(noOfTextFields);
              _listEditingControllerMoney= new List(noOfTextFields);
               for(int i=0;i<noOfTextFields;i++){
                 _listEditingControllerMoney[i]= TextEditingController(text: !editValue? (double.parse((double.parse(widget.totalFees)/noOfTextFields).toStringAsFixed(2)).toString()):"" );
                 _listEditingControllerDD[i] = TextEditingController();
                 _listEditingControllerYYYY[i] = TextEditingController();
                 }
    });
  });
 }

 @override
  void initState() {
    super.initState();
    editValue= widget.toggleValue;
    if(editValue)
    _loadFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Installmets"),
      ),
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                noOfTextFields = int.parse(value != "" ? value : "0");
                 _listEditingControllerDD= new List<TextEditingController>(noOfTextFields);
               _listEditingControllerYYYY= new List<TextEditingController>(noOfTextFields);
              _listEditingControllerMoney= new List(noOfTextFields);
               for(int i=0;i<noOfTextFields;i++){
                 _listEditingControllerMoney[i]= TextEditingController(text: !editValue? (double.parse((double.parse(widget.totalFees)/noOfTextFields).toStringAsFixed(2)).toString()):"" );
                 _listEditingControllerDD[i] = TextEditingController();
                 _listEditingControllerYYYY[i] = TextEditingController();
                 }
               
              });
            },
            controller: _maxInstallText,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter No. of Installments"),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            color: noOfTextFields!=0? Colors.orange: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.66,
              child: _createTextFields(noOfTextFields)),
          SizedBox(height: 8.0,),    
          _saveButton()    
        ],
      ),
    );
  }
}
