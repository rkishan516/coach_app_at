import 'package:flutter/material.dart';
import 'package:coach_app/Chat/mid_admin_based.dart';
import 'package:coach_app/Chat/models/item_class.dart';

class GridItem extends StatefulWidget {
  final Key key;
  final Item item;
  final ValueChanged<bool> isSelected;

  GridItem({this.item, this.isSelected, this.key});

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
            widget.isSelected(isSelected);
          });
        },
        child: Container(
            color: Color.fromARGB(255, 230, 230, 230),
            child: Row(children: [
              SizedBox(width: SizeConfig.b * 2.54),
              CircleAvatar(
                  foregroundColor: Theme.of(context).accentColor,
                  backgroundColor: Colors.grey,
                  radius: SizeConfig.b * 6.36,
                  backgroundImage: NetworkImage(widget.item.imageUrl)
                  //AssetImage(widget.item.imageUrl),
                  ),
              SizedBox(width: SizeConfig.b * 4.07),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.v * 1.08),
                  Text(widget.item.name,
                      style: TextStyle(
                          fontSize: SizeConfig.b * 4.78,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 242, 108, 37))),
                  SizedBox(width: SizeConfig.b * 1.27),
                  SizedBox(height: SizeConfig.v * 2.5),
                ],
              ),
              SizedBox(height: SizeConfig.v * 8.5),
              isSelected
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(SizeConfig.b * 4.07),
                        child: Icon(
                          Icons.check_circle,
                          color: Color.fromARGB(255, 242, 108, 37),
                        ),
                      ),
                    )
                  : Container(),
            ])));
  }
}
