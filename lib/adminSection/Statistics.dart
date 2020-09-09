import 'package:coach_app/Models/model.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  final List<Branch> branches;
  StatisticsPage({@required this.branches});
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Statistics',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Divider(
              color: Colors.black,
              height: 2,
              thickness: 2,
            ),
            Expanded(
              flex: 3,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}

class StatisticsCapsule extends StatelessWidget {
  final String text, count;
  StatisticsCapsule({@required this.text, @required this.count});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            child: Center(
              child: Text(text),
            ),
          ),
          Container(
            child: Center(
              child: Text(count),
            ),
          )
        ],
      ),
    );
  }
}
