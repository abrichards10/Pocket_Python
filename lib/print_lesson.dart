import 'package:flutter/material.dart';
import 'package:test_project/commons/constants.dart';

class PrintLesson extends StatefulWidget {
  const PrintLesson({super.key});

  @override
  State<PrintLesson> createState() => PrintLessonState();
}

class PrintLessonState extends State<PrintLesson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
        title: Text(
          "Print",
          style: TextStyle(
            fontFamily: mainFont.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Printing is easy peasy",
              style: TextStyle(
                fontFamily: mainFont.fontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
