import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Expert extends StatefulWidget {
  const Expert({super.key});

  @override
  State<Expert> createState() => ExpertState();
}

class ExpertState extends State<Expert> {
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
          "Expert",
          style: GoogleFonts.comicNeue(
              textStyle: const TextStyle(fontWeight: FontWeight.w600)),
        ),
        backgroundColor: mainColor,
      ),
    );
  }
}
