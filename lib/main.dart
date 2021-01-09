import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'TimerWidget.dart';
// import 'package:scoped_model/scoped_model.dart';

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
        primaryColor: Color.fromARGB(255, 139, 117, 205),
        // primarySwatch: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          // accentColor: Colors.deepPurple.shade300,
          accentColor: Color.fromARGB(255, 139, 117, 205),
          primaryColor: Color.fromARGB(255, 139, 117, 205),
          primaryColorDark: Color.fromARGB(255, 139, 117, 205),
          // primarySwatch: Colors.deepPurple,
          iconTheme: IconThemeData(color: Colors.white60)),
      themeMode: ThemeMode.system,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  var firstSwitch = true;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _controller = TextEditingController(
      text: "${TimeOfDay.now().toString().substring(10, 15)}");
  var isSelected;
  var theme = 0;

  // var cardColor = Colors.deepPurple.shade300;
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
        onPressed: () => {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext ctx) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setModalState) {
                  return Padding(
                      padding: EdgeInsets.only(left: 40, right: 40, top: 40),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(6),
                                child: ToggleButtons(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text("Таймер")),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text("Время")),
                                  ],
                                  onPressed: (int index) {
                                    setModalState(() {
                                      for (int i = 0;
                                          i < isSelected.length;
                                          i++) {
                                        isSelected[i] = i == index;
                                      }
                                    });
                                  },
                                  isSelected: isSelected,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                  padding: EdgeInsets.all(6),
                                  child: SizedBox(
                                      height: 40,
                                      width: 80,
                                      child: TextFormField(
                                          controller: _controller,
                                          readOnly: true,
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w500),
                                          onTap: () {
                                            showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            ).then((value) => {
                                                  _controller.text = value
                                                      ?.toString()
                                                      ?.substring(10, 15)
                                                });
                                          }))),
                            ],
                          ),
                          Row(children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  // color: cardColor,
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
                                child: Text("Wi-Fi"),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 8.0),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  // color: cardColor,
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
                                child: Text("Cell"),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 8.0),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  // color: cardColor,
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
                                child: Text("App"),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 8.0),
                            ),
                          ]),
                          IconButton(
                            icon: Icon(Icons.done),
                            tooltip: "Готово",
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ));
                });
              })
        },
        tooltip: 'Add new timer',
        child: Icon(Icons.add),
      ),
    );
  }
}
