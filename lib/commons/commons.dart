import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:test_project/api/prefs_helper.dart';
import 'package:test_project/commons/constants.dart';

AppBar lessonAppBar(context, Stopwatch stopwatch, String title) {
  return AppBar(
    backgroundColor: mainColor,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: textColor,
      ),
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
        color: textColor,
        onPressed: () {},
      ),
    ],
    title: Text(
      title,
      style: TextStyle(
        color: textColor,
        fontFamily: mainFont.fontFamily,
        fontWeight: FontWeight.w600,
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
      colors: confettiColors,
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

void incorrectAnswerPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      Future.delayed(const Duration(milliseconds: 600), () {
        Navigator.of(context).pop(true);
      });

      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: mainColor,
            ),
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Text(
              'Try again!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontFamily: mainFont.fontFamily,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      );
    },
  );
}

void showCorrectDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      Future.delayed(const Duration(milliseconds: 600), () {
        Navigator.of(context).pop(true);
      });
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: mainColor,
            ),
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Text(
              'Correct!',
              style: TextStyle(
                fontFamily: mainFont.fontFamily,
                color: Colors.black,
                fontSize: 18,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    },
  );
}

InputDecoration submitDecoration(String hintText) {
  return InputDecoration(
    icon: ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        child: InkWell(
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Icon(
              Icons.arrow_circle_right_outlined,
              color: arrowColor,
            ),
          ),
          onTap: () {},
        ),
      ),
    ),
    hintText: hintText,
    labelText: '',
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: arrowColor,
      ),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: arrowColor,
      ),
    ),
  );
}

Widget doneButton(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextButton.icon(
        label: Text(
          "Done!", //  ₊˚⊹♡",
          style: TextStyle(
            fontFamily: mainFont.fontFamily,
            fontWeight: FontWeight.w800,
            height: 5,
            color: arrowColor,
          ),
        ),
        icon: const Icon(
          Icons.arrow_circle_right_outlined,
          color: arrowColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
  );
}
