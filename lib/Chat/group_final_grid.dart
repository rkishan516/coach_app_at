import 'package:coach_app/Chat/models/item_class.dart';
import 'package:coach_app/Profile/TeacherProfile.dart';
import 'package:flutter/material.dart';

class GridItem extends StatefulWidget {
  final Key? key;
  final Item item;

  GridItem({required this.item, this.key});

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
          });
        },
        child: Container(
            color: Color.fromARGB(255, 230, 230, 230),
            child: Column(children: [
              Row(
                children: [
                  SizedBox(width: SizeConfig.b * 2),
                  CircleAvatar(
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Colors.grey,
                    radius: SizeConfig.b * 5.36,
                    backgroundImage: NetworkImage(widget.item.imageUrl),
                  ),
                  SizedBox(width: SizeConfig.b * 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: SizeConfig.v * 0.68),
                      Text(widget.item.name,
                          style: TextStyle(fontSize: SizeConfig.b * 4.07)),
                      SizedBox(height: SizeConfig.v * 0.68),
                      Text(widget.item.des,
                          style: TextStyle(
                              color: Color.fromARGB(255, 242, 108, 37),
                              fontSize: 12))
                    ],
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.v * 2.27),
            ])));
  }
}
