import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:test_project/api/prefs_helper.dart';
import 'package:test_project/commons/constants.dart';

Text explanationText(String theText, BuildContext context) {
  return Text(
    theText,
    style: TextStyle(
      color: textColor,
      fontFamily: codeFont.fontFamily,
      fontSize: MediaQuery.of(context).size.width / 24,
    ),
  );
}

AppBar lessonAppBar(BuildContext context, Stopwatch stopwatch, String title) {
  return AppBar(
    backgroundColor: mainColor,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: textColor,
      ),
      onPressed: () {
        PrefsHelper().timeElapsedInLesson = (PrefsHelper().timeElapsedInLesson +
                (stopwatch.elapsedMilliseconds) / 1000)
            .ceil();

        getDayMinutes(stopwatch);

        print("${PrefsHelper().timeElapsedInLesson}");
        Navigator.pop(context);
      },
    ),
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
                color: textColor,
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
                color: textColor,
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
        color: backgroundColor,
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
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
    hintStyle: TextStyle(
      fontFamily: mainFont.fontFamily,
      color: textColor,
    ),
    labelText: '',
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: arrowColor,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: arrowColor,
      ),
    ),
  );
}

Widget doneButton(BuildContext context, Stopwatch stopwatch) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextButton.icon(
        label: Text(
          "Done! ₊˚⊹", //  ₊˚⊹♡",
          style: TextStyle(
            fontFamily: mainFont.fontFamily,
            fontWeight: FontWeight.w800,
            height: 5,
            color: arrowColor,
          ),
        ),
        icon: Icon(
          Icons.arrow_circle_right_outlined,
          color: arrowColor,
        ),
        onPressed: () {
          PrefsHelper().timeElapsedInLesson =
              (PrefsHelper().timeElapsedInLesson +
                      (stopwatch.elapsedMilliseconds) / 1000)
                  .round();

          getDayMinutes(stopwatch);

          print("${PrefsHelper().timeElapsedInLesson}");
          Navigator.pop(context);
        },
      ),
    ],
  );
}

getDayMinutes(Stopwatch stopwatch) {
  switch (DateTime.now().weekday) {
    case 1:
      PrefsHelper().timeElapsedMonday = (PrefsHelper().timeElapsedMonday +
              (stopwatch.elapsedMilliseconds) / 60000)
          .round()
          .toDouble();
      break;
    case 2:
      PrefsHelper().timeElapsedTuesday = (PrefsHelper().timeElapsedTuesday +
              (stopwatch.elapsedMilliseconds) / 60000)
          .round()
          .toDouble();
      break;
    case 3:
      PrefsHelper().timeElapsedWednesday = (PrefsHelper().timeElapsedWednesday +
              (stopwatch.elapsedMilliseconds) / 60000)
          .round()
          .toDouble();
      break;
    case 4:
      PrefsHelper().timeElapsedThursday = (PrefsHelper().timeElapsedThursday +
              (stopwatch.elapsedMilliseconds) / 60000)
          .round()
          .toDouble();
      break;
    case 5:
      PrefsHelper().timeElapsedFriday = (PrefsHelper().timeElapsedFriday +
              (stopwatch.elapsedMilliseconds) / 60000)
          .round()
          .toDouble();
      break;
    case 6:
      PrefsHelper().timeElapsedSaturday = (PrefsHelper().timeElapsedSaturday +
              (stopwatch.elapsedMilliseconds) / 60000)
          .round()
          .toDouble();
      break;
    case 7:
      PrefsHelper().timeElapsedSunday = (PrefsHelper().timeElapsedSunday +
              (stopwatch.elapsedMilliseconds) / 60000)
          .round()
          .toDouble();
      break;
    default:
      // text = '';
      break;
  }
}

topicCard(String title, String description, IconData icon, double progress,
    BuildContext context) {
  return Stack(
    children: [
      Card(
        elevation: 3,
        shadowColor: shadowColor,
        color: cardColor,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                icon,
                color: textColor,
              ),
              title: Text(
                title,
                style: TextStyle(
                  fontFamily: mainFont.fontFamily,
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                description,
                style: TextStyle(
                  fontFamily: mainFont.fontFamily,
                  color: textColor,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 6,
                  // margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    color: progressColor,
                  ),
                  width: progress > 0
                      ? (progress * MediaQuery.of(context).size.width) - 50
                      : 0,
                )
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
