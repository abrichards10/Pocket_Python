import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrintLesson extends StatefulWidget {
  const PrintLesson({super.key});

  @override
  State<PrintLesson> createState() => PrintLessonState();
}

class PrintLessonState extends State<PrintLesson> {
  var mainFont = GoogleFonts.comicNeue();

  // NEXT LESSON
  // Progress

  @override
  Widget build(BuildContext context) {
    const mainColor = Color.fromARGB(255, 252, 221, 253);
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
          style: GoogleFonts.comicNeue(
              textStyle: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Printing is easy peasy",
              style: GoogleFonts.comicNeue(
                  textStyle: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
