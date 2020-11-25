
import 'package:coach_app/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class BeforeImageLoading extends StatefulWidget {
  var imageurl;
  BeforeImageLoading({this.imageurl});

  @override
  _BeforeImageLoadingState createState() => _BeforeImageLoadingState();
}

class _BeforeImageLoadingState extends State<BeforeImageLoading> {
  TextEditingController _texController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Caption"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 10,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              padding: EdgeInsets.only(top: 20.0, bottom: 16.0),
              child: Center(
                child: Image.file(
                  widget.imageurl,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              color: GuruCoolLightColor.backgroundShade,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                      autofocus: false,
                      autocorrect: true,
                      controller: _texController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: 'Add a caption...'.tr(),
                        fillColor: GuruCoolLightColor.whiteColor,
                        filled: true,
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(22.0)),
                          borderSide: BorderSide(
                            color: GuruCoolLightColor.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    iconSize: 35.0,
                    alignment: Alignment.topRight,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).pop(_texController.text == ""
                          ? "EmpText"
                          : _texController.text);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
