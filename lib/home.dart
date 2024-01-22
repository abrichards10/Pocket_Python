// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test_project/account.dart';
import 'package:test_project/advanced.dart';
import 'package:test_project/api/my_keys.dart';
import 'package:test_project/beginner.dart';
import 'package:test_project/commons/commons.dart';
import 'package:test_project/commons/constants.dart';
import 'package:test_project/expert.dart';
import 'package:test_project/intermediate.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List<Widget> colorIcons = <Widget>[
  //   Icon(
  //     Icons.sunny,
  //     color: textColor,
  //   ),
  //   Icon(
  //     Icons.ac_unit,
  //     color: textColor,
  //   ),
  // ];

  final List<bool> selectedWeather = <bool>[false, true];

  @override
  void initState() {
    super.initState();
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Account(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  menuButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.menu,
        color: textColor,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              // You need this, notice the parameters below:
              builder: (BuildContext context, StateSetter innerSetState) {
                return AlertDialog(
                  backgroundColor: cardColor,
                  content: SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width / 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dark Mode',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: mainFont.fontFamily,
                            color: textColor,
                          ),
                        ),
                        ToggleButtons(
                          onPressed: (int index) {
                            setState(
                              () {
                                if (index == 0) {
                                  setDarkModeColors(false);
                                  setState(() {});
                                } else if (index == 1) {
                                  setDarkModeColors(true);
                                  setState(() {});
                                }
                                // The button that is tapped is set to true, and the others to false.
                                for (int i = 0;
                                    i < selectedWeather.length;
                                    i++) {
                                  selectedWeather[i] = i == index;
                                }
                              },
                            );
                            innerSetState(
                              () {},
                            );
                            setState(() {});
                          },
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          selectedBorderColor: textColor,
                          selectedColor: selectedColor,
                          fillColor: mainColor,
                          color: cardColor,
                          isSelected: selectedWeather,
                          children: [
                            Icon(
                              Icons.sunny,
                              color: textColor,
                            ),
                            Icon(
                              Icons.ac_unit,
                              color: textColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: IconButton(
          icon: Icon(
            Icons.account_box,
            color: textColor,
          ),
          onPressed: () {
            Navigator.of(context).push(_createRoute());
          },
        ),
        actions: [
          // IconButton(
          //   icon: Icon(
          //     Icons.local_fire_department,
          //     color: textColor,
          //   ),
          //   onPressed: () {
          //     Navigator.of(context).push(_createRoute());
          //   },
          // ),
          Row(
            children: [
              // GestureDetector(
              //   child: Container(
              //     padding: EdgeInsets.all(10),
              //     alignment: Alignment.centerLeft,
              //     height: MediaQuery.of(context).size.width / 4,
              //     child: Image(
              //       image: AssetImage(snek),
              //     ),
              //   ),
              //   onTap: () {
              //     print(chatGPTAPI("Answer the following question only with yes or no: Is this a valid python print statement?  "));
              //   },
              // ),
              menuButton(context),
            ],
          ),
        ],
        title: Text(
          widget.title,
          style: TextStyle(
            color: textColor,
            fontFamily: mainFont.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            GestureDetector(
              child: topicCard(
                'Beginner',
                'Start here if you don\'t know how to print',
                Icons.power_settings_new,
                0,
                context,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Beginner()),
                );
              },
            ),
            GestureDetector(
              child: topicCard(
                'Intermediate',
                'Wanna know what a \'for loop\' is?',
                Icons.power_sharp,
                0,
                context,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Intermediate()),
                );
              },
            ),
            GestureDetector(
              child: topicCard(
                'Advanced',
                'Functions and Recurrsion, oh dear!',
                Icons.bug_report,
                0,
                context,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Advanced()),
                );
              },
            ),
            GestureDetector(
              child: topicCard(
                'Expert',
                'Algorithms and Data Structures, oh my!',
                Icons.precision_manufacturing,
                0,
                context,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Expert()),
                );
              },
            ),
            // TODO: Lock this
            GestureDetector(
              child: topicCard(
                'Legend',
                'If you know you know',
                Icons.coffee,
                0,
                context,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Advanced()),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: Card(
                      elevation: 3,
                      color: cardColor,
                      shadowColor: shadowColor,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Exterminator",
                            style: TextStyle(
                              fontFamily: mainFont.fontFamily,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                              height: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
