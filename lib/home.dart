// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:test_project/account.dart';
import 'package:test_project/advanced.dart';
import 'package:test_project/beginner.dart';
import 'package:test_project/commons/constants.dart';
import 'package:test_project/expert.dart';
import 'package:test_project/intermediate.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // NEXT LESSON
  // Progress

  @override
  void initState() {
    print("${NavigationHistoryObserver().top}");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: IconButton(
          icon: const Icon(Icons.account_box),
          onPressed: () {
            Navigator.of(context).push(_createRoute());
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
        title: Text(
          widget.title,
          style: TextStyle(
            fontFamily: mainFont.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            GestureDetector(
              child: Card(
                elevation: 3,
                shadowColor: const Color(0xffFCD4FF),
                color: cardColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.power_settings_new),
                      title: Text(
                        'Beginner',
                        style: TextStyle(
                          fontFamily: mainFont.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        'Start here if you don\'t know how to print',
                        style: mainFont,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Beginner()),
                );
              },
            ),
            GestureDetector(
              child: Card(
                elevation: 3,
                shadowColor: const Color(0xffFCD4FF),
                color: cardColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.power_sharp),
                      title: Text(
                        'Intermediate',
                        style: TextStyle(
                          fontFamily: mainFont.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text('Wanna know what a \'for loop\' is?',
                          style: mainFont),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Intermediate()),
                );
              },
            ),
            GestureDetector(
              child: Card(
                elevation: 3,
                shadowColor: const Color(0xffFCD4FF),
                color: cardColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.bug_report),
                      title: Text(
                        'Advanced',
                        style: TextStyle(
                          fontFamily: mainFont.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text('Functions and Recurrsion, oh dear!',
                          style: mainFont),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Advanced()),
                );
              },
            ),
            GestureDetector(
              child: Card(
                elevation: 3,
                shadowColor: const Color(0xffFCD4FF),
                color: cardColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.precision_manufacturing),
                      title: Text(
                        'Expert',
                        style: TextStyle(
                          fontFamily: mainFont.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text('Algorithms and Data Structures, oh my!',
                          style: mainFont),
                    ),
                  ],
                ),
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
              child: Card(
                elevation: 3,
                shadowColor: const Color(0xffFCD4FF),
                color: cardColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.coffee),
                      title: Text(
                        'Legend',
                        style: TextStyle(
                          fontFamily: mainFont.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text('If you know you know', style: mainFont),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Advanced()),
                );
              },
            ),
            SizedBox(
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
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Exterminator",
                            style: TextStyle(
                              fontFamily: mainFont.fontFamily,
                              fontWeight: FontWeight.w600,
                              height: 3,
                            ),
                          ),
                        ],
                      ),
                      color: cardColor,
                      shadowColor: const Color(0xffFCD4FF),
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
