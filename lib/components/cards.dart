import 'package:beginning_app_development/theme/color.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  TaskCard({Key key}) : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
            color: iVSalmon.shade200,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )),
        height: 40,
        width: double.infinity,
        child: TextField(
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
