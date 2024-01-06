import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Advanced extends StatefulWidget {
  const Advanced({super.key});

  @override
  State<Advanced> createState() => AdvancedState();
}

class AdvancedState extends State<Advanced> {
  final mainFont = GoogleFonts.comicNeue();
  final mainColor = const Color.fromARGB(255, 252, 221, 253);

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
          "Advanced",
          style: GoogleFonts.comicNeue(
              textStyle: const TextStyle(fontWeight: FontWeight.w600)),
        ),
        backgroundColor: mainColor,
      ),
    );
  }
}
