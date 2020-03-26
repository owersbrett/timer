import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:beginning_app_development/theme/color.dart';
import 'package:numberpicker/numberpicker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intervolition',
      theme: ThemeData(
        primarySwatch: iVGreen,
        primaryColor: iVGreen,
        primaryTextTheme: Typography().white,
        primaryIconTheme: IconThemeData(color: Colors.white),
        accentColor: Colors.white,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(title: 'Intervolition'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TabController tb;
  int hour = 0;
  int min = 25;
  int sec = 0;
  bool started = false;
  bool stopped = false;
  int timeForTimer = 0;
  String timeToDisplay = "25:00";
  bool checkTimer = true;

  void setHour(val) {
    hour = val;
  }

  void setMin(val) {
    min = val;
  }

  void setSec(val) {
    sec = val;
  }

  void start() {
    if (!started) {
      setState(() {
        started = true;
        stopped = false;
      });

      timeForTimer = (hour * 60 * 60) + (min * 60) + sec;

      Timer.periodic(
          Duration(
            seconds: 1,
          ), (Timer t) {
        setState(() {
          if (timeForTimer < 1 || checkTimer == false) {
            t.cancel();
            checkTimer = true;
            started = false;
          } else {
            timeForTimer -= 1;
          }

          if (timeForTimer < 60) {
            timeToDisplay = timeForTimer.toString();
          } else if (timeForTimer < 3600) {
            int m = timeForTimer ~/ 60;
            min = m;
            int s = timeForTimer - (60 * m);
            sec = s;
            String seconds = (s < 10) ? "0" + s.toString() : s.toString();

            timeToDisplay = m.toString() + ":" + seconds;
          } else {
            int h = timeForTimer ~/ 3600;
            hour = h;
            int t = timeForTimer - (3600 * h);

            int m = t ~/ 60;
            min = m;
            int s = t - (60 * m);
            sec = s;
            timeToDisplay =
                h.toString() + ":" + m.toString() + ":" + s.toString();
          }
        });
      });
    }
  }

  void stop() {
    if (!stopped) {
      setState(() {
        started = false;
        stopped = true;
        checkTimer = false;
      });
    }
  }

  void resetTimer() {
    if (stopped) {
      setState(() {
        hour = 0;
        min = 25;
        sec = 0;
        started = false;
        stopped = false;
        timeForTimer = 1500;
        timeToDisplay = "25:00";
        checkTimer = true;
      });
    }
  }

  void initState() {
    tb = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  Widget timeField(
    String unitOfTime,
    Function setTime,
  ) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              bottom: 10.0,
            ),
            child: Text(
              unitOfTime,
            ),
          ),
          NumberPicker.integer(
            // highlightSelectedValue: false,

            infiniteLoop: (unitOfTime == "HH") ? false : true,
            initialValue:
                (unitOfTime == "HH") ? hour : (unitOfTime == "MM") ? min : sec,
            minValue: 0,
            maxValue: (unitOfTime == "HH") ? 23 : 59,
            listViewWidth: 85.0,
            onChanged: (val) {
              setState(() {
                setTime(val);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget myNotes() {
    return Container(
      width: double.infinity,
      color: iVLGreen,
      child: Text(
        "Yo",
        style: TextStyle(
          color: Colors.grey[900],
        ),
      ),
    );
  }

  Widget timerButton(String label, Function buttonFunction, bool isActive) {
    return GestureDetector(
      onTap: buttonFunction,
      child: Container(
        width: 120,
        height: 80,
        child: (label == "Start")
            ? Icon(
                Icons.play_arrow,
                color: iVGreen,
                size: 42,
              )
            : Icon(
                Icons.stop,
                color: iVSalmon,
                size: 42,
              ),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[900],
              offset: Offset(5.0, 5.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Colors.grey[800],
              offset: Offset(-5.0, -5.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: (isActive == true)
                  ? (label == "Start")
                      ? Theme.of(context).primaryColor
                      : iVSalmon
                  : Colors.white.withOpacity(0.0),
              // offset: Offset(-5.0, -5.0),
              blurRadius: 3.0,
              spreadRadius: 0.2,
            ),
          ],
        ),
      ),
    );
  }

  Widget timer({bool notes: false}) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 5,
            child: !notes
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      timeField("HH", setHour),
                      timeField("MM", setMin),
                      timeField("SS", setSec),
                    ],
                  )
                : Container(),
          ),
          Expanded(
            flex: 1,
            child: Visibility(
              visible: notes,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  timeToDisplay,
                  style: TextStyle(
                    fontSize: 33.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                timerButton("Stop", stop, stopped),
                SizedBox(width: 50),
                timerButton("Start", start, started),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget stopwatch() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        // leading: Icon(Icons.menu),
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                
                resetTimer();
              },
              child: Icon(
                Icons.restore,
                size: 26.0,
              ),
            ),
          ),
        ],
        bottom: TabBar(
          tabs: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.timer),
                    SizedBox(width: 10),
                    Text(
                      "Interval",
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Volition",
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.speaker_notes),
                  ],
                ),
              ],
            ),
          ],
          labelPadding: EdgeInsets.only(
            bottom: 10.0,
          ),
          labelStyle: TextStyle(
            fontSize: 19.0,
          ),
          controller: tb,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          timer(),
          timer(notes: true),
          // stopWatch(),
        ],
        controller: tb,
      ),
    );
  }
}
