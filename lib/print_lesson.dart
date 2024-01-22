// ignore_for_file: use_build_context_synchronously

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/api/api_service.dart';
import 'package:test_project/my_keys.dart';
import 'package:test_project/api/prefs_helper.dart';
import 'package:test_project/commons/commons.dart';
import 'package:test_project/commons/constants.dart';

class PrintLesson extends StatefulWidget {
  const PrintLesson({super.key});

  @override
  State<PrintLesson> createState() => PrintLessonState();
}

class PrintLessonState extends State<PrintLesson> {
  late ConfettiController _controllerCenter; // CONFETTI! :D
  ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  bool _correctAnswer1 = false;
  bool _correctAnswer2 = false;
  final _stopwatch = Stopwatch(); // keep track of time spent on lesson

  @override
  void initState() {
    _stopwatch.start();
    _textEditingController1.text = PrefsHelper().print1;
    _textEditingController2.text = PrefsHelper().print2;

    _controllerCenter = ConfettiController(
      duration: const Duration(seconds: 1),
    );
    _scrollController =
        ScrollController(initialScrollOffset: PrefsHelper().currentPrintScroll);
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose(); // Dispose of confetti
    _textEditingController1.dispose();
    super.dispose();
  }

  Future<bool> validatePrint(String userInput) async {
    var result = await chatGPTAPI(userInput);

    print("result: $result");

    setState(() {});

    if (result == "Yes" || result == "Yes.") {
      return true;
    } else {
      return false;
    }
  }

  Widget showNextButton(double thisScroll) {
    return ElevatedButton(
      onPressed: () {
        PrefsHelper().currentPrintScroll = thisScroll;
        _scrollController.animateTo(
          PrefsHelper().currentPrintScroll,
          curve: Curves.easeIn,
          duration: const Duration(milliseconds: 800),
        );
        _correctAnswer1 = false;
        _correctAnswer2 = false;
        setState(() {});
        FocusScope.of(context).unfocus();
      },
      style: ElevatedButton.styleFrom(backgroundColor: mainColor),
      child: Text(
        "next >",
        style: TextStyle(
          fontFamily: mainFont.fontFamily,
          fontWeight: FontWeight.w600,
          color: textColor,
          fontSize: MediaQuery.of(context).size.width / 26,
        ),
      ),
    );
  }

  printSubmitted1(value) async {
    PrefsHelper().print1 = value;
    _textEditingController1.text = value;
    if (await validatePrint(
        "Answer the following question only with yes or no: Is this a valid python print statement? $value")) {
      _controllerCenter.play(); // Confetti!
      showCorrectDialog(context);
      _correctAnswer1 = true;
      if (!PrefsHelper().print1AlreadyDone) {
        PrefsHelper().print1AlreadyDone = true;
        PrefsHelper().numberOfPrintActivitiesDone =
            PrefsHelper().numberOfPrintActivitiesDone + .5;
      }
      setState(() {});
    } else {
      incorrectAnswerPopup(context);
    }
  }

  printSubmitted2(value) async {
    PrefsHelper().print2 = value;
    _textEditingController2.text = value;
    if (await validatePrint(
        "Answer the following question only with yes or no: Is this a valid python print statement for printing more than one object? $value")) {
      _controllerCenter.play(); // Confetti!
      showCorrectDialog(context);
      _correctAnswer2 = true;
      if (!PrefsHelper().print2AlreadyDone) {
        PrefsHelper().print2AlreadyDone = true;
        PrefsHelper().numberOfPrintActivitiesDone =
            PrefsHelper().numberOfPrintActivitiesDone + .5;
      }
      setState(() {});
    } else {
      incorrectAnswerPopup(context);
    }
  }

  Form printForm1() {
    return Form(
      key: _formKey1,
      child: Column(
        children: [
          TextField(
            controller: _textEditingController1,
            style: TextStyle(
              fontFamily: mainFont.fontFamily,
              color: textColor,
            ),
            decoration: submitDecoration("Type a print command"),
            autofocus: false,
            maxLength: 30,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            onSubmitted: (value) {
              printSubmitted1(value);
            },
          ),
        ],
      ),
    );
  }

  Form printForm2() {
    return Form(
      key: _formKey2,
      child: Column(
        children: [
          TextField(
            controller: _textEditingController2,
            style: TextStyle(
              fontFamily: mainFont.fontFamily,
              color: textColor,
            ),
            decoration: submitDecoration("Type a print command with commas"),
            autofocus: false,
            maxLength: 30,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            onSubmitted: (value) {
              printSubmitted2(value);
            },
          ),
        ],
      ),
    );
  }

  _printDescription(String description) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          40, MediaQuery.of(context).size.height / 2, 40, 0),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          color: cardColor,
        ),
        child: Text(
          description,
          style: TextStyle(
              fontFamily: mainFont.fontFamily,
              color: textColor,
              fontSize: 18,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w300),
        ),
      ),
    );
  }

  Widget mainLesson() {
    print(PrefsHelper().currentPrintScroll);
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3.5,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(40),
                children: [
                  explanationText(
                      "print(\"A print statement looks like this!\")", context),
                  printForm1(),
                  const SizedBox(
                    height: 100,
                  ),
                  explanationText(
                      "print(\"Print multiple things...\", \"like this!\")",
                      context),
                  printForm2(),
                ],
              ),
            ),
          ],
        ),
        _correctAnswer2
            ? doneButton(context, _stopwatch)
            : (_correctAnswer1 || _correctAnswer2
                ? showNextButton(200)
                : Container()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: backgroundColor,
          appBar: lessonAppBar(
            context,
            _stopwatch,
            "Print",
          ),
          body: mainLesson(),
        ),
        _correctAnswer1
            ? _printDescription(
                "Output: \nA print statement looks like this! \n\nPrinting results in an output to console, so we can see what's going on")
            : Container(),
        _correctAnswer2
            ? _printDescription("Output: \nPrint multiple things...like this!")
            : Container(),
        confetti(_controllerCenter),
      ],
    );
  }
}
