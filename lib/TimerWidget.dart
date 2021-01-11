import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:system_shortcuts/system_shortcuts.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';

class TimerWidget extends StatefulWidget {
  @override
  TimerWidgetState createState() => TimerWidgetState();
}

class TimerWidgetState extends State<TimerWidget> {
  var cardColor;
  var cell = true;
  var wifi = true;
  var app = true;
  var status = true;
  var time = "10:00";

  var lightColor = Colors.deepPurple.shade300;
  var darkColor = Colors.black26;

  @override
  void initState() {
    cardColor = status ? lightColor : darkColor;
    setTimer();
  }

  void setTimer() async {
    // await AndroidAlarmManager.initialize();
    // await AndroidAlarmManager.oneShotAt(DateTime.fromMillisecondsSinceEpoch(1610250300000), 0, await SystemShortcuts.home());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              // color: cardColor,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  cardColor,
                  status
                      ? Colors.deepPurple.shade400
                      : Colors.black.withOpacity(.5)
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 4,
                  blurRadius: 7,
                  offset: Offset(3, 3),
                )
              ]),
          child: Padding(
            padding: EdgeInsets.all(14.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("$time",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                    Spacer(),
                    IconButton(
                      splashColor: Colors.white,
                      icon: Icon(
                        Icons.wifi,
                        color: wifi ? Colors.white : Colors.white54,
                      ),
                      onPressed: () {
                        setState(() {
                          wifi = !wifi;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.network_cell,
                        color: cell ? Colors.white : Colors.white54,
                      ),
                      onPressed: () {
                        setState(() {
                          cell = !cell;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.android_outlined,
                        color: app ? Colors.white : Colors.white54,
                      ),
                      onPressed: () {
                        setState(() {
                          app = !app;
                        });
                      },
                    ),
                    Switch(
                      value: status,
                      activeColor: Colors.white,
                      onChanged: (bool newVal) {
                        setState(() {
                          cardColor = (newVal) ? lightColor : darkColor;
                          status = newVal;
                          // var isWifi = await SystemShortcuts.checkWifi;
                          // if (isWifi) await SystemShortcuts.wifi();
                        });
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
