import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class next extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final String imgUrl = 'https://pixel.nymag.com/imgs/daily/selectall/2017/12/26/26-eric-schmidt.w700.h700.jpg';

    return new Stack(children: <Widget>[
      new Container(color: Colors.greenAccent,),
      new Image.network(imgUrl, fit: BoxFit.fill,),
      new BackdropFilter(
          filter: new ui.ImageFilter.blur(
            sigmaX: 6.0,
            sigmaY: 6.0,
          ),
          child: new Container(
            decoration: BoxDecoration(
    gradient: LinearGradient(
    colors: [Colors.orange,Colors.deepOrange],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    )

            ),)),
      new Scaffold(
          appBar: new AppBar(
            title: new Text('Profile'),
            centerTitle: false,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          drawer: new Drawer(child: new Container(),),
          backgroundColor: Colors.transparent,
          body: new Center(
            child: new Column(
              children: <Widget>[
                new SizedBox(height: _height/12,),
                  new CircleAvatar(radius:_width<_height? _width/4:_height/4,backgroundImage: NetworkImage(imgUrl),),
                new SizedBox(height: _height/25.0,),
                new Text('Teachers name', style: new TextStyle(fontWeight: FontWeight.bold, fontFamily: 'portLliga',fontSize: _width/15, color: Colors.white),),
                new Padding(padding: new EdgeInsets.only(top: _height/30, left: _width/8, right: _width/8),
                  child:new Text('Teachers Id.\n Email-Id',
                    style: new TextStyle(fontWeight: FontWeight.normal,fontFamily: 'portLliga', fontSize: _width/25,color: Colors.white),textAlign: TextAlign.center,) ,),
                new Divider(height: _height/30,color: Colors.white,),
                new Row(
                  children: <Widget>[
                    rowCell("name of Subjects", 'Subjects'),
                    rowCell("75%", 'Performance'),
                  ],),
                new Divider(height: _height/30,color: Colors.white,),
                new Row(
                  children: <Widget>[
                    rowCell("name of Qualifications", 'Qualification'),
                  ],),
                new Divider(height: _height/30,color: Colors.white),
                new Padding(padding: new EdgeInsets.only(left: _width/8, right: _width/8), child: new FlatButton(onPressed: (){},
                  child: new Container(child: new Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                    new Icon(Icons.assignment_turned_in),
                    new SizedBox(width: _width/30,),
                    new Text('Years of Experience', style: new TextStyle(fontFamily: 'portLliga'))
                  ],)),color: Colors.blue[50],),),
                new Padding(padding: new EdgeInsets.only(left: _width/3.5, right: _width/3.5), child: new FlatButton(onPressed: (){},
                  child: new Container(child: new Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                    new Icon(Icons.rotate_right),
                    new SizedBox(width: _width/60,),
                    new Text('Performance', style: new TextStyle(fontFamily: 'portLliga',color: Colors.white))
                  ],)),color: Colors.greenAccent),),


              ],//
            ),
          )
      )
    ],);
  }

  Widget rowCell(String count, String type) => new Expanded(child: new Column(children: <Widget>[
    new Text('$count',style: new TextStyle(color: Colors.white,fontFamily: 'portLliga'),),
    new Text(type,style: new TextStyle(color: Colors.white, fontWeight: FontWeight.normal,fontFamily: 'portLliga'))
  ],));

}
