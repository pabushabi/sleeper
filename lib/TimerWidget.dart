import 'package:flutter/material.dart';
import 'package:system_shortcuts/system_shortcuts.dart';

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

  @override
  void initState() {
    cardColor = status ? Colors.deepPurple.shade300 : Colors.black26;

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: cardColor,
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
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: IconButton(
                        splashColor: Colors.deepPurple.shade200,
                        icon: Icon(Icons.wifi, color: wifi ? Colors.white : Colors.white54,),
                        onPressed: () {
                          setState(() {
                            wifi = !wifi;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: IconButton(
                        icon: Icon(Icons.network_cell, color: cell ? Colors.white : Colors.white54,),
                        onPressed: () {
                          setState(() {
                            cell = !cell;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: IconButton(
                        icon: Icon(Icons.android_outlined, color: app ? Colors.white : Colors.white54,),
                        onPressed: () {
                          setState(() {
                            app = !app;
                          });
                        },
                    )),
                    Switch(
                      value: status,
                      onChanged: (bool newVal) {
                        setState(() async {
                          cardColor = (newVal)
                              ? Colors.deepPurple.shade300
                              : Colors.black26;
                          status = newVal;
                          var isWifi = await SystemShortcuts.checkWifi;
                          if (isWifi) await SystemShortcuts.wifi();
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