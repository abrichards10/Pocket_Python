import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Intermediate extends StatefulWidget {
  const Intermediate({super.key});

  @override
  State<Intermediate> createState() => IntermediateState();
}

class IntermediateState extends State<Intermediate> {
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
          "Intermediate",
          style: GoogleFonts.comicNeue(
              textStyle: const TextStyle(fontWeight: FontWeight.w600)),
        ),
        backgroundColor: mainColor,
      ),
    );
  }
}
