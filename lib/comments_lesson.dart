// ignore_for_file: prefer_const_constructors

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/api/prefs_helper.dart';
import 'package:test_project/commons/commons.dart';
import 'package:test_project/commons/constants.dart';

class CommentsLesson extends StatefulWidget {
  const CommentsLesson({super.key});

  @override
  State<CommentsLesson> createState() => CommentsLessonState();
}

class CommentsLessonState extends State<CommentsLesson> {
  late ConfettiController _controllerCenter; // CONFETTI! :D

  ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController1 = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();

  bool _correctAnswer = false;

  final _stopwatch = Stopwatch(); // keep track of time spent on lesson

  @override
  void initState() {
    _stopwatch.start();
    _textEditingController1.text = PrefsHelper().comment_1;

    _controllerCenter = ConfettiController(
      duration: const Duration(seconds: 1),
    );
    _scrollController =
        ScrollController(initialScrollOffset: PrefsHelper().currentScroll);
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose(); // Dispose of confetti
    _textEditingController1.dispose();
    super.dispose();
  }

  bool validateComment1(String userInput) {
    if (userInput.startsWith("#")) {
      return true;
    } else {
      return false;
    }
  }

  Widget showNextButton(double thisScroll) {
    return ElevatedButton(
      onPressed: () {
        PrefsHelper().currentScroll = thisScroll;
        _scrollController.animateTo(
          PrefsHelper().currentScroll,
          curve: Curves.easeIn,
          duration: Duration(milliseconds: 800),
        );
        _correctAnswer = false;
        setState(() {});
        FocusScope.of(context).unfocus();
      },
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

  Text commentText1() {
    return Text(
      "# This is a comment",
      style: TextStyle(
        fontFamily: codeFont.fontFamily,
        fontSize: MediaQuery.of(context).size.width / 24,
      ),
    );
  }

  Text commentText2() {
    return Text(
      "\"\"\" \n\tThis is also a comment\n\"\"\"",
      style: TextStyle(
        fontFamily: codeFont.fontFamily,
        fontSize: MediaQuery.of(context).size.width / 24,
      ),
    );
  }

  commentSubmitted1(value) {
    PrefsHelper().comment_1 = value;
    _textEditingController1.text = value;
    if (validateComment1(value)) {
      _controllerCenter.play(); // Confetti!
      showCorrectDialog(context);
      _correctAnswer = true;
      setState(() {});
    } else {
      incorrectAnswerPopup(context);
    }
  }

  Form commentForm1() {
    return Form(
      key: _formKey1,
      child: Column(
        children: [
          TextField(
            controller: _textEditingController1,
            style: mainFont,
            decoration: submitDecoration("Type a comment"),
            autofocus: false,
            maxLength: 30,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            onSubmitted: (value) {
              commentSubmitted1(value);
            },
          ),
        ],
      ),
    );
  }

  Widget mainLesson() {
    // PrefsHelper().currentScroll = 0;
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(40),
                children: [
                  commentText1(),
                  commentForm1(),
                  SizedBox(
                    height: 100,
                  ),
                  commentText2(),
                  doneButton(context),
                ],
              ),
            ),
          ],
        ),
        _correctAnswer ? showNextButton(220) : Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: lessonAppBar(context, _stopwatch, "Comments"),
      body: Stack(
        children: <Widget>[
          confetti(_controllerCenter),
          mainLesson(),
        ],
      ),
    );
  }
}
