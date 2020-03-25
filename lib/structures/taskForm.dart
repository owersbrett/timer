import 'package:flutter/material.dart';
import 'package:beginning_app_development/components/cards.dart';
import 'package:beginning_app_development/theme/color.dart';

class TaskForm extends StatefulWidget {
  TaskForm({Key key}) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  FocusNode myFocusNode;
  // bool _goalSet = false;
  // String _goal = "Goal";

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  void _setGoal() {
    setState(() {
      // _goal = "Good Job!";
      // _goalSet = _goalSet ? false : true;
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
       
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TaskCard(),
                TaskCard(
                  // task: "Task 1",
                ),
                TaskCard(
                  // task: "Task 2",
                ),
                TaskCard(
                  // task: "Task 3",
                ),
                TaskCard(
                  // task: "Task 4",
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  child: Text("Where timer goes"),
                ),
                Card(
                  child: Text("Task 2"),
                ),
                Card(
                  child: Text("Task 3"),
                ),
                Card(
                  child: Text("Task 4"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
