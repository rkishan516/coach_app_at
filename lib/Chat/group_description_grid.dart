import 'package:coach_app/Chat/models/item_class.dart';
import 'package:coach_app/Profile/TeacherProfile.dart';
import 'package:flutter/material.dart';

class GridItem extends StatefulWidget {
  final Key key;
  final Item item;
  final ValueChanged<bool> isSelected;

  GridItem({
    required this.item,
    required this.isSelected,
    required this.key,
  });

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool isSelected = true;
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
            child: Stack(alignment: Alignment.center, children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: SizeConfig.b * 6.2,
                    backgroundImage: NetworkImage(widget.item.imageUrl),
                  ),
                  SizedBox(height: SizeConfig.v * 1.5),
                  Container(
                    width: SizeConfig.b * 40.7,
                    child: Text(widget.item.name,
                        style: TextStyle(
                            fontSize: SizeConfig.b * 3.2,
                            fontWeight: FontWeight.w400,
                            color: Colors.black)),
                  )
                ],
              ),
              isSelected
                  ? Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.all(SizeConfig.b * 0),
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
