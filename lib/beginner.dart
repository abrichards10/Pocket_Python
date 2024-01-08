import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:test_project/comments_lesson.dart';
import 'package:test_project/commons/constants.dart';
import 'package:test_project/print_lesson.dart';

class Beginner extends StatefulWidget {
  const Beginner({super.key});

  @override
  State<Beginner> createState() => BeginnerState();
}

class BeginnerState extends State<Beginner> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Beginner",
          style: TextStyle(
            fontFamily: mainFont.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
        backgroundColor: mainColor,
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
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
                      leading: const Icon(Icons.tag),
                      title: Text(
                        'Comments',
                        style: TextStyle(
                          fontFamily: mainFont.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text('Code that does (almost) nothing',
                          style: mainFont),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CommentsLesson()),
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
                      leading: const Icon(Icons.create),
                      title: Text(
                        'Print!',
                        style: TextStyle(
                          fontFamily: mainFont.fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle:
                          Text('How to print to console', style: mainFont),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PrintLesson()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
