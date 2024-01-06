import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/api/prefs_helper.dart';

AppBar lessonAppBar(context, Stopwatch stopwatch, String title) {
  final mainColor = const Color.fromARGB(255, 252, 221, 253);

  return AppBar(
    backgroundColor: mainColor,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        PrefsHelper().timeElapsedInLesson = (PrefsHelper().timeElapsedInLesson +
                (stopwatch.elapsedMilliseconds) / 1000)
            .ceil();

        print("${PrefsHelper().timeElapsedInLesson}");
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
      title,
      style: GoogleFonts.comicNeue(
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
  );
}

Widget confetti(ConfettiController controllerCenter) {
  return Align(
    alignment: Alignment.topCenter,
    child: ConfettiWidget(
      confettiController: controllerCenter,
      blastDirectionality: BlastDirectionality
          .explosive, // don't specify a direction, blast randomly
      shouldLoop: false, // start again as soon as the animation is finished
      colors: const [
        Color.fromARGB(255, 255, 208, 252),
        Color.fromARGB(255, 255, 175, 250),
        Color.fromARGB(255, 255, 139, 247),
        Color.fromARGB(255, 255, 68, 243),
        Color.fromARGB(255, 255, 30, 240),
      ], // manually specify the colors to be used
      numberOfParticles: 20,
      maxBlastForce: 40,
      createParticlePath: drawCircle,
    ),
  );
}

Path drawCircle(Size size) {
  // Method to convert degree to radians
  double degToRad(double deg) => deg * (pi / 180.0);

  final halfWidth = size.width / 2;
  final externalRadius = halfWidth;
  final degreesPerStep = degToRad(1);
  final path = Path();
  final fullAngle = degToRad(360);
  path.moveTo(size.width, halfWidth);

  for (double step = 0; step < fullAngle; step += degreesPerStep) {
    path.lineTo(halfWidth + externalRadius * cos(step),
        halfWidth + externalRadius * sin(step));
  }
  path.close();
  return path;
}
