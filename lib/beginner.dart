import 'package:flutter/material.dart';
import 'package:test_project/api/prefs_helper.dart';
import 'package:test_project/comments_lesson.dart';
import 'package:test_project/commons/commons.dart';
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
          icon: Icon(
            Icons.arrow_back,
            color: textColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Beginner",
          style: TextStyle(
            fontFamily: mainFont.fontFamily,
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          // menuButton(context),
        ],
        backgroundColor: mainColor,
      ),
      backgroundColor: backgroundColor,
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            GestureDetector(
              child: topicCard(
                'Comments',
                'Code that does (almost) nothing',
                Icons.tag,
                PrefsHelper().numberOfCommentActivitiesDone,
                context,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CommentsLesson(),
                  ),
                );
              },
            ),
            GestureDetector(
              child: topicCard(
                'Print',
                'How to print to console',
                Icons.create,
                PrefsHelper().numberOfPrintActivitiesDone,
                context,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrintLesson(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
