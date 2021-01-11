import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'TimerWidget.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sleeper',
      theme: ThemeData(
        brightness: Brightness.light,
        accentColor: Color.fromARGB(255, 139, 117, 205),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Color.fromARGB(255, 139, 117, 205),
      ),
      themeMode: ThemeMode.system,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _controller = TextEditingController(
      text: "${TimeOfDay.now().toString().substring(10, 15)}");
  var isSelected;
  var theme = 0;

  var cards = [
    ["10:20", true, false, true],
    ["00:00", true, true, true],
    ["21:00", true, true, false],
    ["00:00", false, false, false]
  ];

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }

  showSnack(text) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$text'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var wifi = true;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 25, 10, 10),
              child: Row(
                children: [
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.wb_sunny_outlined),
                    onPressed: () => {
                      if (theme == 0)
                        {Get.changeThemeMode(ThemeMode.light), theme = 1}
                      else if (theme == 1)
                        {Get.changeThemeMode(ThemeMode.dark), theme = 0}
                    },
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(25, 0, 15, 20),
                    child: Text(
                      "Sleeper",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            // for (var i = 0; i < cards.length; i++)
            //   timerWidget(
            //       time: cards[i][0],
            //       wifi: cards[i][1],
            //       cell: cards[i][2],
            //       status: cards[i][3]),
            TimerWidget(),
            TimerWidget(),
            TimerWidget(),
            TimerWidget(),
            // Row(
            //   children: [
            //     Padding(
            //         padding: EdgeInsets.fromLTRB(25, 20, 15, 20),
            //         child: Text(
            //           "Recommendation",
            //           style: TextStyle(
            //             fontSize: 26,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         )),
            //   ],
            // ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async => {
          // showSnack(),
          showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            helpText: "ВЫБЕРИТЕ ВРЕМЯ",
            cancelText: "ОТМЕНА",
          ).then((value) => {
                showSnack(value?.toString()?.substring(10, 15))
                // var val = value.
              }),
          // await AndroidAlarmManager.initialize(),
          // await AndroidAlarmManager.periodic(Duration(seconds: 15), 10, sayHello),
          print("hellova!"),
          // await AndroidAlarmManager.oneShotAt(DateTime.fromMillisecondsSinceEpoch(1610250300000), 0, showSnack());
        },
        tooltip: 'Add new timer',
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple.shade300,
      ),
    );
  }

  void sayHello() {
    print("[${DateTime.now()}] hello!");
  }
}
