import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:test_project/comments_lesson.dart';
import 'package:test_project/print_lesson.dart';

class Beginner extends StatefulWidget {
  const Beginner({super.key});

  @override
  State<Beginner> createState() => BeginnerState();
}

class BeginnerState extends State<Beginner> {
  final mainFont = GoogleFonts.comicNeue();
  final mainColor = const Color.fromARGB(255, 252, 221, 253);

  @override
  void initState() {
    print("${NavigationHistoryObserver().top}");
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
          style: GoogleFonts.comicNeue(
              textStyle: const TextStyle(fontWeight: FontWeight.w600)),
        ),
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
                color: const Color.fromARGB(255, 254, 235, 255),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.tag),
                      title: Text(
                        'Comments',
                        style: GoogleFonts.comicNeue(
                            textStyle:
                                const TextStyle(fontWeight: FontWeight.w600)),
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
                color: const Color.fromARGB(255, 254, 235, 255),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.create),
                      title: Text(
                        'Print!',
                        style: GoogleFonts.comicNeue(
                            textStyle:
                                const TextStyle(fontWeight: FontWeight.w600)),
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
